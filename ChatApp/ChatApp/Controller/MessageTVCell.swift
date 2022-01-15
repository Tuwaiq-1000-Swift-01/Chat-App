

import UIKit

class MessageTableViewCell: UITableViewCell {

  @IBOutlet weak var messageContanier: UIView!
  
  @IBOutlet weak var messageTextLabel: UILabel!

  
  enum Sender {
    case user
    case otherUsers
  }
  
  
  func getMessageDesign(sender: Sender) {
    
    var backgroundColor: UIColor?
    
    switch sender {
    case .user:
      backgroundColor = .systemYellow
      messageContanier.layer.maskedCorners = [.layerMinXMaxYCorner,
                                           .layerMinXMaxYCorner,
                                           .layerMinXMaxYCorner]
      messageTextLabel?.textAlignment = .right

      
    case .otherUsers:
      backgroundColor = .systemGray6
      messageContanier.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                           .layerMaxXMaxYCorner,
                                           .layerMaxXMinYCorner]
      messageTextLabel?.textAlignment = .left
      
    default:
      break
    }
    
    messageContanier.backgroundColor = backgroundColor
    messageContanier.layer.cornerRadius = messageTextLabel.frame.size.height / 4
    messageContanier.layer.shadowOpacity = 0.1
  }
}
