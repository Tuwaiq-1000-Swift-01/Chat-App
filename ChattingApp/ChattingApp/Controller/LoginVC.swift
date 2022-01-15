//
//  LoginVC.swift
//  ChattingApp
//
//  Created by A A on 14/01/2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
  
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Utilities.configureButtons(button: loginButton)
    
  }
  
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    login()
  }
  
  
  func login(){
    if let email = emailTF.text,
       let password = passwordTF.text {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let e = error {
          print(e)
        } else {
          self.performSegue(withIdentifier: "MoveToHome", sender: nil)
        }
      }
    }
  }
  
}
