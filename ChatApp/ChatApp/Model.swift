//
//  Model.swift
//  ChatApp
//
//  Created by Maram Al shahrani on 12/06/1443 AH.
//

import UIKit
import FirebaseFirestore


struct User {
    let id: String
    let name: String
    let status: String
}

struct Message {
    let id: String
    let sender: String
    let receiver: String
    let content: String
    let timestamp: Timestamp
}
