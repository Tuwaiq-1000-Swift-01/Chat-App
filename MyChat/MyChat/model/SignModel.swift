//
//  SignModel.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import Foundation

struct UsersSignUp {
    var name:String?
    var email:String?
    var idUser:String?
    
    func getDate()->[String:Any] {
        return ["Name User":name!,"Email User":email!,"ID User":idUser!]
    }
        

                                           
}
