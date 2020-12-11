//
//  SelectViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/02.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics

class SelectViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLogInView", sender: self)
        print("login")
//        let age = "23"
//        let gender = "male"
//        Analytics.setUserProperty(age, forName: "your_age")
//        Analytics.setUserProperty(gender, forName: "your_gender")

    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRegisterView", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
