//
//  IBDesign.swift
//  TriviaMultipleChoice-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 15/03/1443 AH.
//

import Foundation
import UIKit

extension UIColor {
  
  convenience init(hex: Int) {
    let components = (
      R: CGFloat((hex >> 16) & 0xff) / 255,
      G: CGFloat((hex >> 08) & 0xff) / 255,
      B: CGFloat((hex >> 00) & 0xff) / 255
    )
    self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
  }
  
}

@IBDesignable
public class roundCorner: UIView {
  @IBInspectable var topLeft:  Bool =  false
  @IBInspectable var topRight:  Bool =  false
  @IBInspectable var bottomLeft:  Bool =  false
  @IBInspectable var bottomRight:  Bool =  false
  @IBInspectable var cornerRadii: Int =   0
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
  
  func setup() {
    var array:UIRectCorner = []
    if topLeft {array.insert(.topLeft)}
    if topRight {array.insert(.topRight)}
    if bottomLeft {array.insert(.bottomLeft)}
    if bottomRight {array.insert(.bottomRight)}
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: array,
                            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
}
@IBDesignable
public class Gradient: UIView {
  @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
  @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
  @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
  @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
  @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
  @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
  
  @IBInspectable var topLeft:  Bool =  false
  @IBInspectable var topRight:  Bool =  false
  @IBInspectable var bottomLeft:  Bool =  false
  @IBInspectable var bottomRight:  Bool =  false
  @IBInspectable var cornerRadii: Int =   0
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
  
  func setup() {
    var array:UIRectCorner = []
    if topLeft {array.insert(.topLeft)}
    if topRight {array.insert(.topRight)}
    if bottomLeft {array.insert(.bottomLeft)}
    if bottomRight {array.insert(.bottomRight)}
    
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: array,
                            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
  override public class var layerClass: AnyClass {
    CAGradientLayer.self }
  
  var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
  
  func updatePoints() {
    if horizontalMode {
      gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
      gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
    } else {
      gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
      gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
    }
  }
  func updateLocations() {
    gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
  }
  func updateColors() {
    
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
  }
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    updatePoints()
    updateLocations()
    updateColors()
    
  }
  
  
}


@IBDesignable
class CustomButton: UIButton {
  
  @IBInspectable var topLeft:  Bool =  false
  @IBInspectable var topRight:  Bool =  false
  @IBInspectable var bottomLeft:  Bool =  false
  @IBInspectable var bottomRight:  Bool =  false
  @IBInspectable var cornerRadii: Int =   0
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
     
  func setup() {
    var array:UIRectCorner = []
    if topLeft {array.insert(.topLeft)}
    if topRight {array.insert(.topRight)}
    if bottomLeft {array.insert(.bottomLeft)}
    if bottomRight {array.insert(.bottomRight)}
    
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: array,
                            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    self.titleLabel?.numberOfLines = 0
    self.titleLabel?.textAlignment = .center
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.titleLabel?.lineBreakMode = .byClipping
  }
  
}



@IBDesignable
class CustomView: UIView{
  
  @IBInspectable var borderWidth: CGFloat = 0.0
  @IBInspectable var borderColor: UIColor = UIColor.clear

  
  @IBInspectable var topLeft:  Bool =  false
  @IBInspectable var topRight:  Bool =  false
  @IBInspectable var bottomLeft:  Bool =  false
  @IBInspectable var bottomRight:  Bool =  false
  @IBInspectable var cornerRadii: Int =   0
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
     
  func setup() {
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = borderColor.cgColor

    var array:UIRectCorner = []
    if topLeft {array.insert(.topLeft)}
    if topRight {array.insert(.topRight)}
    if bottomLeft {array.insert(.bottomLeft)}
    if bottomRight {array.insert(.bottomRight)}
    
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: array,
                            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
  override func prepareForInterfaceBuilder() {
    
    super.prepareForInterfaceBuilder()
  }
  
}
