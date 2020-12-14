//
//  CustomerViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/02.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase
import CoreImage

class CustomerViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var messageView: UILabel!
    @IBOutlet weak var QRcodeImageView: UIImageView!
    @IBOutlet weak var barCodeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       loadInformation()
        loadCodeImage()
        
    }
    
    
    func loadInformation() {
        if let userMail = Auth.auth().currentUser?.email{
        db.collection(userMail).getDocuments { (querySnapShot, error) in
            if let err = error {
                print("There was something wrong: \(err)")
            } else {
                let userName = querySnapShot?.documents[0].data()[U.nickName]// ユーザーネームを抽出する
                self.messageView.text = "ようこそ　\(userName as! String)様"//ユーザー名を表示する
                }
            }
        }
    }
    
    func loadCodeImage(){
        if let userMail = Auth.auth().currentUser?.email{
            let urlString = "\(QRcodeData.urlText)/\(userMail)"
            let image = UIImage.makeQRCode(text: urlString)//QRcode生成
                   self.QRcodeImageView.image = image//QRcode表示
            let image2 = UIImage.makeBarcode(string: userMail)//バーコードランダムで生成
            self.barCodeImageView.image = image2//バーコード表示
        }
    }
    
}
// MARK: - QRCode、バーコード機能定義
extension UIImage{
    static func makeQRCode(text: String) -> UIImage? {
        guard let data = text.data(using: .utf8) else { return nil }
        guard let QR = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data]) else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let ciImage = QR.outputImage?.transformed(by: transform) else { return nil }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    static func makeBarcode(string: String) -> UIImage? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")
        
        guard let output = filter.outputImage else {
            return nil
        }
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        
        let image = UIImage(cgImage: cgImage, scale: 2.0, orientation: UIImage.Orientation.up)
        
        return image
    }
}
