//
//  MessageTableViewCell.swift
//  ChattingApp
//
//  Created by A A on 15/01/2022.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  enum Sender {
    case me
    case other
  }
  
  
  func getMessageDesign(sender: Sender)  {
    
    //message UI
    var backGroundColor : UIColor?
    
    switch sender {
    case .me:
      backGroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
      messageBubble.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    //        messageLabel.textAlignment = .right
    
    case .other:
      backGroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      messageBubble.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    //        messageLabel.textAlignment = .left
    
    default:
      break
    }
    
    messageBubble.backgroundColor = backGroundColor
    messageBubble.layer.cornerRadius = messageLabel.frame.size.height / 2.5
    messageBubble.layer.shadowOpacity = 0.1
    
  }
  
}
