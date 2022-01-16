//
//  ChetCellVC.swift
//  ChattingApp
//
//  Created by Ameera BA on 15/01/2022.
//

import UIKit
import SwiftUI

class ChatCellVC: UITableViewCell {
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var meesageBubble: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  enum messengers{
    case other, me
  }
  
  
  func getMessageDesign(sender: messengers){
     var backgroundColor: UIColor?
    switch sender{
    case .me:
      backgroundColor = UIColor(red: 254.0/255.0, green: 227.0/255.0, blue: 236.0/255.0, alpha: 1)
      textLabel?.textAlignment = .right
      
    case .other:
      backgroundColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1)
      textLabel?.textAlignment = .left
    }
    
    meesageBubble.backgroundColor = backgroundColor
    meesageBubble.layer.shadowOpacity = 0.5
  }
}
