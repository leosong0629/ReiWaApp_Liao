//
//  Message.swift
//  ReiWaBuSan
//
//  Created by 廖靖玮 on 2020/12/06.
//  Copyright © 2020 JingweiLiao. All rights reserved.
//

import Foundation

struct Message {
    let sender: String
    let body: String
    let nickName: String
    var imageId: String {
        switch nickName {
        case "ヘルプディスク":
            return "headphones"
        case "helpdesk":
            return "headphones"
        default:
            return "person.circle"
        }
    }
}
