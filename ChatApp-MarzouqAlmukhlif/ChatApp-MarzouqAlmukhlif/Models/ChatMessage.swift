//
//  ChatMessage.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import Foundation
import UIKit
import Firebase

class ChatMessage: UITableViewCell {
  
  let bubbleView: MessageBubbleView = {
    let v = MessageBubbleView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  var leadingOrTrailingConstraint = NSLayoutConstraint()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    messageInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    messageInit()
  }
  
  func messageInit() -> Void {
    
    // add the bubble view
    contentView.addSubview(bubbleView)
    
    // constrain top / bottom with 12-pts padding
    // constrain width to lessThanOrEqualTo 2/3rds (66%) of the width of the cell
    NSLayoutConstraint.activate([
      bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
      bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
      bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.66),
    ])
    
  }
  
  func setData(_ message: Message) -> Void {
    
    // set the label text
    bubbleView.messageLabel.text = message.text
    bubbleView.messageLabel.textColor = message.incoming ? .white : UIColor(named: "messageText")

    // tell the bubble view whether it's an incoming or outgoing message
    bubbleView.incoming = message.incoming
    
    // left- or right-align the bubble view, based on incoming or outgoing
    leadingOrTrailingConstraint.isActive = false
    if message.incoming {
      leadingOrTrailingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
    } else {
      leadingOrTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
    }
    leadingOrTrailingConstraint.isActive = true
  }
  
}
