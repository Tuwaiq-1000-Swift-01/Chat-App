//
//  Rooms.swift
//  MyChat
//
//  Created by Anas Hamad on 12/06/1443 AH.
//

import Foundation


struct Rooms {
    
    var owner : String
  
    
    func getRooms(dect:[String:Any]) -> [String:Any]{
        return ["owner":owner]
    }
}
