//
//  CartItemCell.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/11.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class CartItemCell: UITableViewCell {
    let db = Firestore.firestore()

    @IBOutlet weak var numOfItemInCart: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var delectButton: UIButton!
    @IBOutlet weak var delectMessageLabel: UILabel!
    @IBOutlet weak var itemNOLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.cornerRadius = 15.0
        buyButton.backgroundColor = .yellow
        itemNameLabel.backgroundColor = .purple
        itemDescriptionLabel.backgroundColor = .blue
        delectMessageLabel.text = ""
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func delectButtonTapped(_ sender: UIButton) {
         if let userMail = Auth.auth().currentUser?.email {
            db.collection(C.cartItemCollection+userMail).document(itemNOLabel.text!).delete { (err) in
                if let err = err {
                    print("something wrong with \(err)")
                } else {
                    self.delectMessageLabel.textColor = .red
                    self.delectMessageLabel.text = "商品削除しました！"
                }
            }
        }
    }
    
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        //開発中
    }
}
