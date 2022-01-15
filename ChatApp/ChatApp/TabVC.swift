//
//  TabViewController.swift
//  ChatApp
//
//  Created by Maram Al shahrani on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth

class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        UsersService.shared.updateUserInfo(
            user: User(
                id: currentUserId,
                name: "Maram",
                status: "Online"
            )
        )
        
        viewControllers = [
            ContactsVC()
        ]
    }
    
}
