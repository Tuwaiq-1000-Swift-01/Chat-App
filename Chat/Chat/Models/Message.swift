//
//  ChatVC.swift
// Chat
//
//  Created by Jawaher on 13/01/22.
//


import UIKit
import FirebaseFirestore

struct Message {
	let id: String
	let sender: String
	let receiver: String
	let content: String
	let timestamp: Timestamp
}
