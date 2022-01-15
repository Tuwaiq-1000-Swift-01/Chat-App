//
//  ListOfContacts.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 12/06/1443 AH.
//

import Foundation

struct ListOfUser{
    var userName: String
    var userID: String
    
    func getInfo() -> [String:Any]{
        return ["name":userName , "ID User": userID] as! [String:Any]
    }
}
