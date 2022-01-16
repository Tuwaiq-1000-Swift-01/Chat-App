//
//  Chats.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import Foundation
import FirebaseFirestore

struct Message {
  var id:String
  var senderID:String
  var receiverID:String
  var text:String
  var time: Timestamp
  var isRead:Bool
  var incoming: Bool = false
}


struct Chats {
  var userID:String
  var userImage:String
  var userName:String
  var lastMessage:String
  var status:String
}
