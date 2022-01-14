//
//  ChatVC.swift
//  Chat
//
//  Created by Jawaher on 13/01/22.
//

import UIKit
import FirebaseAuth

class TabVC: UITabBarController , UITabBarControllerDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item1 = PeopleVC()
        let item2 = ProfileVC()

        let icon1 = UITabBarItem(title:"Chat", image: UIImage(systemName: "person.3.fill"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        let icon2 = UITabBarItem(title: "profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
    
        
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2

        
        let controllers = [item1, item2]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        
        
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.8917622779, green: 0.9029003482, blue: 0.9117498729, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.6526222096, green: 0.6526222096, blue: 0.6526222096, alpha: 1)
        UITabBar.appearance().selectedImageTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

