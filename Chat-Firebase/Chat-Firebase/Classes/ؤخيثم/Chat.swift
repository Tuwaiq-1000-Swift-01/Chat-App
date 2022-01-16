//
//  File.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import Foundation
import Firebase



struct Message {
  
  var sender : String?
  var reciever : String?
  var message : String?
  let idMessage:String
  
  
  
  func getData()->[String:Any] {
    
    return ["Message":message!,
            "sender":sender!,
            "reciever":reciever!,
            "idMessage":idMessage
            
    ]
  }
  func chatPartnerId() -> String? {
    return sender == Auth.auth().currentUser?.uid ? reciever : sender
    
    
  }
}



