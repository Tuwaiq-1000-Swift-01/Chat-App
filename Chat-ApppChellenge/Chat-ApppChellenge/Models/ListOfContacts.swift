//
//  ListOfContacts.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 12/06/1443 AH.
//

import Foundation

struct ListOfUser{
    var userName: String
    func getInfo() -> [String:Any]{
        return ["name":userName] as! [String:Any]
    }
}
