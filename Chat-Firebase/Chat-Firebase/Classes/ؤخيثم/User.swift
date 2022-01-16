//
//  Users.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import Foundation

struct User {
  var name:String?
  var familyName:String?
  var email:String?
  var idUser:String?
  
  func getDate()->[String:Any] {
    return ["User Name":name!, "Family Name":familyName! ,"Email":email!,"ID":idUser!]
  }
}
