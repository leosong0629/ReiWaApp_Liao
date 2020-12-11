//
//  MessageCell.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/07.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    let db = Firestore.firestore()
    @IBOutlet weak var MessageBubble: UIView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var NickNameLabel: UILabel!
    @IBOutlet weak var RightIconView: UIImageView!
    
    @IBOutlet weak var LeftIconView: UIImageView!
    
    @IBOutlet weak var HelpDeskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height / 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
