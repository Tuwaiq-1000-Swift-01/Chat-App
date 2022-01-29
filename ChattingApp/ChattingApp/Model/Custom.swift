//
//  Custom.swift
//  ChattingApp
//
//  Created by Ameera BA on 16/01/2022.
//

import UIKit

class Custom {
  static func styleTextField ( _ textfield: UITextField){
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect (x: 0,
                               y: textfield.frame.height-2,
                               width: textfield.frame.width,
                               height: 5)

    bottomLine.backgroundColor = UIColor(red: 249.0/255.0,
                                         green: 197.0/255.0,
                                         blue: 213.0/255.0,
                                         alpha: 1).cgColor
    // remove border on text feild
    textfield.borderStyle = .none
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
  }
  
  
  static func styleButton(_ button: UIButton){
    
    button.tintColor = UIColor.label
    button.layer.cornerRadius = 20
    button.layer.borderColor = UIColor(red: 249.0/255.0,
                                       green: 197.0/255.0,
                                       blue: 213.0/255.0,
                                       alpha: 1).cgColor
    button.layer.borderWidth = 3
  }
}
