//
//  RegisterViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/02.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics

class RegisterViewController: UIViewController, UITextFieldDelegate {

 
    let db = Firestore.firestore()
    @IBOutlet weak var userIDTextView: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var configTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBoxButton: UIButton!
    var isChecked = true
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDTextView.delegate = self
        userPasswordTextField.delegate = self
        checkBoxButton.imageView?.tintColor = .gray
        registerButton.isEnabled = false
         registerButton.layer.cornerRadius = 15.0
        registerButton.backgroundColor = .gray
    }
    

    @IBAction func registerButton(_ sender: UIButton) {
        
        let nickName = nickNameTextField.text
        let gender = genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex)!
        let age = "\(ageTextField.text!)"
        if userPasswordTextField.text == configTextField.text {
        if let userID = userIDTextView.text, let userPassword = userPasswordTextField.text {
            Auth.auth().createUser(withEmail: userID, password: userPassword) { (authDataResult, error) in
                if let err = error {
                    self.errorMessageLabel.text = "パスワード/ID錯誤！"
                    print(err)
                } else {
                     Analytics.logEvent("sign_up", parameters: [
                                           "User ID: " : userID
                                       ])
                    Analytics.setUserProperty(gender, forName: P.userGender)//性別属性を記録する
                    
                    Analytics.setUserProperty(age, forName: P.userAge)//年齢属性を記録する
                    self.db.collection(userID).document(U.userInformationDocument).setData( [U.userID:userID, U.nickName: nickName!, U.gender: gender, U.age: age]) { (err) in
                        if let err = err{
                            print("something wrong with \(err)")
                        } else {
                            print("save success!")
                        }
                        self.performSegue(withIdentifier: "toCustomerView", sender: self)
                    }
                }
            }
        }
        } else {
            errorMessageLabel.text = "パスワード一致しない"
        }
        
    }

    @IBAction func checkBoxButtonTapped(_ sender: UIButton) {
        if isChecked {
            checkBoxButton.imageView?.tintColor = .black
            registerButton.isEnabled = true
            registerButton.backgroundColor = .yellow
            isChecked = false
        } else {
            checkBoxButton.imageView?.tintColor = .gray
            isChecked = true
            registerButton.isEnabled = false
            registerButton.backgroundColor = .gray
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userIDTextView.endEditing(true)
        userPasswordTextField.endEditing(true)
        return true
    }
   
}
