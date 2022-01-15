//
//  Message.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import Foundation
struct Messages {
    
    var sender : String
    var contant : String
    var time : NSObject
    func getMessage() -> [String:Any]{
        return ["sender":sender,
                "contant":contant,
                "time":time]
    }
    
    
    
    
    
    
    
//    init (dict: [String: Any]) {
//      
//        
//       
//        self.contant = dict["contant"] as? String
//       self.sender = dict["sender"] as? String
//        self.time = dict["time"]
//     
//   }
}
