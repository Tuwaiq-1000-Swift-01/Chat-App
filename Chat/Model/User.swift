//
//  User.swift
//  Chat
//
//  Created by Abdullah Bajaman on 14/01/2022.
//

import Foundation
//
import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift


class User : Codable{
//    let db = Firestore.firestore()

    var id : String
    var name : String
    var nottifications : [String]? // Change it to [DocumentReference]?
    
    init(name: String, id : String ){
        self.name = name
        self.id = id
    }
    func getUser()->[String: Any]{
        return ["id": self.id, "name": self.name, "notifications": self.nottifications]
    }
    func sendMessage(to userID: String, msg: String)->[String: Any]{
        
        return ["sender": self.id, "receiver": userID, msg: msg]
    }
}
//struct User1 : Codable{
//    var id : String
//    var name : String
//    var nottifications : [DocumentReference]?
//
//}
