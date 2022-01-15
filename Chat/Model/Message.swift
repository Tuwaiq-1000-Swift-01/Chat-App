//
//  Message.swift
//  Chat
//
//  Created by Abdullah Bajaman on 15/01/2022.
//

import Foundation

struct Message : Codable{
    var sender: String
    var reseiver: String // ref
    var mBody: String
}
