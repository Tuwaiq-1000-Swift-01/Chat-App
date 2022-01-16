//
//  MessageCell.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import UIKit
import Firebase


class MessageCell: UITableViewCell {

  @IBOutlet weak var messageView: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var messageTrailing: NSLayoutConstraint!
  @IBOutlet weak var messageLeading: NSLayoutConstraint!
  

  override func awakeFromNib() {
        super.awakeFromNib()
    
    contentView.backgroundColor = .clear
    messageView.layer.cornerRadius = 12
    
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  
  func getMessageDesign(sender: String)  {
      //setting label
    messageLabel.textColor = .white
      //message UI
      var backGroundColor : UIColor?

      switch sender {
          
      case ".Me":
        backGroundColor = UIColor(red: 2362/255, green: 121/255, blue: 100/255, alpha: 1)
          messageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        messageLabel.textAlignment = .right
      case  ".Other":
        backGroundColor = UIColor.darkGray
          messageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        messageLabel.textAlignment = .left

      default:
          print("")
      }
      
      messageView.backgroundColor = backGroundColor
      messageView.layer.shadowOpacity = 0.1

      
  }
    
}
