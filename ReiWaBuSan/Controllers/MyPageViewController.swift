//
//  MyPageViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/14.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class MyPageViewController: UIViewController {
    let db = Firestore.firestore()
    var isChecked = true
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var genderSegmentation: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var informationChangeButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(userMail).getDocuments { (querySnapShot, err) in
                if let err = err {
                    print(err)
                } else {
                    self.nameTextfield.text = querySnapShot?.documents[0].data()[U.nickName] as? String
                    self.ageTextField.text = querySnapShot?.documents[0].data()[U.age] as? String
                }
            }
        }
        checkBoxButton.imageView?.tintColor = .gray
        informationChangeButton.isEnabled = false
        informationChangeButton.backgroundColor = .gray
        informationChangeButton.layer.cornerRadius = 15.0
        logOutButton.backgroundColor = .yellow
        logOutButton.layer.cornerRadius = 15.0
    }
    
    @IBAction func checkBoxIsChecked(_ sender: UIButton) {
        if isChecked {
            checkBoxButton.tintColor = .black
            informationChangeButton.isEnabled = true
            informationChangeButton.backgroundColor = .yellow
            isChecked = false
        } else {
            checkBoxButton.tintColor = .gray
            informationChangeButton.isEnabled = false
            informationChangeButton.backgroundColor = .gray
            isChecked = true
        }
    }
    @IBAction func informationChangeButtonTapped(_ sender: UIButton) {
        let name = nameTextfield.text!
        let age = ageTextField.text!
        let gender = genderSegmentation.titleForSegment(at: genderSegmentation.selectedSegmentIndex)!
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(userMail).document(U.userInformationDocument).updateData([U.nickName: name,U.gender: gender,U.age: age]) { (err) in
                if let err = err {
                    print(err)
                } else {
                    print("update Succeed!")
                }
            }
        }
       //ユーザー情報変更
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
                    performSegue(withIdentifier: "backToStatrt", sender: self)
                    print("log out successed")
               } catch let signOutError as NSError {
                 print ("Error signing out: %@", signOutError)
               }
        //ユーザーログアウト
    }
    
    
}
