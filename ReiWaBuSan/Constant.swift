//
//  userInformation.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/03.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import Foundation

struct U {
    static let userID: String = "userID"
    static let nickName: String = "nickName"
    static let gender: String = "gender"
    static let age: String = "age"
    static let userInformationDocument: String = "information"
    static let messageCellnibName: String = "MessageCell"
    static let cellIdentifier: String = "ReusebleMessbubble"
}

struct P {
    static let userGender: String = "user_age"
    static let userAge: String = "user_age"
}

struct M {
    static let messageCollection: String = "Message"
    static let messageBody: String = "body"
    static let messageSender:String = "sender"
    static let messageDate: String = "date"
    static let messageNiceName: String = "nickName"
}

struct I {
    static let itemCellnibName: String = "ItemCell"
    static let itemCellIdentifier: String = "ReusableItemCell"
    static let itemCollection = "item"
    static let itemNO = "itemNo"
    static let itemName = "item_name"
    static let itemDescription = "item_description"
}

struct Ma {
    static let mailCellnibName: String = "MailCell"
    static let mailCellIdentifier = "ReuseMailCellIdentifier"
    static let mailCollection = "mail_box_"
    static let mailTitel = "title"
    static let mailContent = "content"
    static let mailSender = "sender"
    static let mailDate = "date"
}

struct C {
    static let cartCellnibName = "CartItemCell"
    static let cartCellIdetifier = "ReusableCartItemCell"
    static let cartItemCollection = "cart_item_"
    static let cartItemDocument = "item_name"
    static let cartItemName = "name"
    static let cartItemDescription = "description"
    static let cartItemNumber = "num"
    static let cartItemNO = "itemNo"
}
