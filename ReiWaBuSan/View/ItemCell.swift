//
//  ItemCell.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/09.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class ItemCell: UITableViewCell {
    let db = Firestore.firestore()
    @IBOutlet weak var ItemNameLabel: UILabel!
    @IBOutlet weak var ItemImageView: UIImageView!
    @IBOutlet weak var ItemDescriptionLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var itemNOLabel: UILabel!
    
    var itemNumber = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        ItemDescriptionLabel.layer.cornerRadius = 15.0
        ItemNameLabel.layer.cornerRadius = 15.0
        ItemDescriptionLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        ItemDescriptionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ItemNameLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        ItemNameLabel.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            cartButton.isEnabled = false
            cartButton.backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func itemNumberStepper(_ sender: UIStepper) {
        numLabel.text = String(format: "%.0f", sender.value)
        itemNumber = Int(sender.value)
        
        if itemNumber == 0 {
            cartButton.isEnabled = false
             cartButton.backgroundColor = .gray
        } else {
            cartButton.isEnabled = true
            cartButton.backgroundColor = .yellow
        }
    }
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        if let userMail = Auth.auth().currentUser?.email {
            db.collection(C.cartItemCollection+userMail).document(itemNOLabel.text!).setData([C.cartItemName: ItemNameLabel.text!, C.cartItemDescription: ItemDescriptionLabel.text!,  C.cartItemNumber: numLabel.text!, C.cartItemNO: itemNOLabel.text!])
            messageLabel.text = "カートに入れました！"
            messageLabel.textColor = .red
            cartButton.isEnabled = false
            cartButton.isHidden = true
        }
    }
}
