//
//  DataMondel.swift
//  EnumStateManagerExample
//
//  Created by JerryWang on 2018/3/5.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

import Foundation

struct ResponseMemberData: Codable {
    let members: [Member]
}

struct Member: Codable {
    let firstName: String
    let lastName: String
}
