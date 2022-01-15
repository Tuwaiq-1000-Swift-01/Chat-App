//
//  ViewController.swift
//  ChattingApp
//
//  Created by A A on 13/01/2022.
//

import UIKit

class AuthorizationVC: UIViewController {
  
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Utilities.configureButtons(button: signUpButton)
    Utilities.configureButtons(button: loginButton)
  }
  
}
