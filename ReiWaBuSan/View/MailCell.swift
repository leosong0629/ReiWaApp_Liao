//
//  MailCell.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/10.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import UIKit

class MailCell: UITableViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var IconLabel: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if self.accessoryType == .checkmark {
            self.accessoryType = .none
            
        } else {
            self.accessoryType = .checkmark
        }
        
    }
    
    
}
