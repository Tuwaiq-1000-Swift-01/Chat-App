//
//  UIViewController+Ext.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit

extension UIViewController {
  
  func configureHideKeyboardWhenRootViewTapped() {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(dismissKeyboard))
    
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
