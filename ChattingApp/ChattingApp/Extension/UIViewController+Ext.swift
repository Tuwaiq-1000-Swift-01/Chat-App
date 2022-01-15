//
//  UIViewController+Ext.swift
//  ChattingApp
//
//  Created by A A on 14/01/2022.
//

import UIKit

extension UIViewController {
  
  func configureHideKeyboardWhenRootViewTapped(){
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
