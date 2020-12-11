//
//  ViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/11/30.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics


class LogInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var userPasswordTextView: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDTextField.delegate = self
        userPasswordTextView.delegate = self
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        if let userID = userIDTextField.text, let userPassword = userPasswordTextView.text {
            Auth.auth().signIn(withEmail: userID, password: userPassword) { (authData, error) in
                if let err = error {
                    self.errorMessageLabel.text = "ID/パスワード確認ください！"
                    print(err)
                } else {
                    Analytics.logEvent("login", parameters: [
                        "User ID: " : userID
                    ]) //ログイン事件を記録する
                    self.performSegue(withIdentifier: "goToCustomerView", sender: self)
                }
            }
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userIDTextField.endEditing(true)
        userPasswordTextView.endEditing(true)
        return true
    }
    
       
    }
}
