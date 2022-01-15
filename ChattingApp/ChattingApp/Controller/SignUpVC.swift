//
//  SignUpVC.swift
//  ChattingApp
//
//  Created by A A on 14/01/2022.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
  
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var createAccountButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Utilities.configureButtons(button: createAccountButton)
    configureHideKeyboardWhenRootViewTapped()
    
  }
  
  
  @IBAction func createAccountButtonPressed(_ sender: UIButton) {
    register()
  }
  
  
  func register(){
    if let name = nameTF.text,
       let email = emailTF.text,
       let password = passwordTF.text {
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let e = error {
          print(e)
        } else {
          self.performSegue(withIdentifier: "MoveToHome", sender: nil)
        }
      }
    }
  }
  
}
