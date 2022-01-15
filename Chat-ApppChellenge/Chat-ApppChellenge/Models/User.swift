//
//  User.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 12/06/1443 AH.
//

import Foundation
struct User{
    var name : String?
    var email : String?
    var userID: String?
    
    func getDate()->[String:Any] {
        return ["Name User":name!,"Email User":email!,"ID User":userID!]
    }
}
