//
//  HideKeyboardInViewController.swift
//  AtheerChat
//
//  Created by Atheer Othman on 11/06/1443 AH.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
     
     @objc func dismissKeyboard() {
         view.endEditing(true)
     }
    
}
