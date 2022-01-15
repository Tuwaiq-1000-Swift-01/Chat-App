//
//  DataBaseInfo.swift
//  chatApp01
//
//  Created by Osama folta on 11/06/1443 AH.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import UIKit


struct Msg{
    var message = String()
    var sender = String()
    var resever = String()
    var time = String()
    var id = String()
    func setDate() ->[String:String]{
        return ["message": message ,"sender":sender,"resever": resever,"time":time]
    }
}

struct User {
    var name = String()
    var userID = String()
}
