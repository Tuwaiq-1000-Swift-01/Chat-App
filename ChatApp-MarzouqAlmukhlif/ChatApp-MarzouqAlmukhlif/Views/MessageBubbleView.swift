//
//  MessageBubbleView.swift
//  SpokenWord
//
//  Created by Marzouq Almukhlif on 06/04/1443 AH.
//  Copyright © 1443 Apple. All rights reserved.
//

import UIKit

class MessageBubbleView: UIView {
  
  let bubbleLayer = CAShapeLayer()
  
  let messageLabel: UILabel = {
    let v = UILabel()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.numberOfLines = 0
    v.text = "Sample text"
    return v
  }()
  
  
  // if it's an incoming message, background will be gray and bubble left-aligned
  // otherwise background will be green and bubble right-alinged
  var incoming = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    messageInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    messageInit()
  }
  
  func messageInit() -> Void {
    
    // add the bubble layer
    layer.addSublayer(bubbleLayer)
    
    // add the label
    addSubview(messageLabel)
    
    // constrain the label with 12-pts padding on all 4 sides
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
      messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
    ])
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let width = bounds.size.width
    let height = bounds.size.height
    
    let bezierPath = UIBezierPath()
    
    // NOTE: this bezier path is from
    // https://medium.com/@dima_nikolaev/creating-a-chat-bubble-which-looks-like-a-chat-bubble-in-imessage-the-advanced-way-2d7497d600ba
    if incoming {
      bezierPath.move(to: CGPoint(x: 22, y: height))
      bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
      bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
      bezierPath.addLine(to: CGPoint(x: width, y: 17))
      bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
      bezierPath.addLine(to: CGPoint(x: 21, y: 0))
      bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
      bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
      bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
      bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
      bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
      bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
      bezierPath.close()
    } else {
      bezierPath.move(to: CGPoint(x: width - 22, y: height))
      bezierPath.addLine(to: CGPoint(x: 17, y: height))
      bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
      bezierPath.addLine(to: CGPoint(x: 0, y: 17))
      bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
      bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
      bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
      bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
      bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
      bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
      bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
      bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
      bezierPath.close()
    }
    
    bubbleLayer.fillColor = incoming ? UIColor(red: 0.208, green: 0.522, blue: 0.545, alpha: 1.00).cgColor : UIColor.systemGray5.cgColor
    
    bubbleLayer.path = bezierPath.cgPath
    
  }
}
