//
//  MialContentViewController.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/11.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class MailContentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    var mailArray:[MailData] = []
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


