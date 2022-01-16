//
//  LogInPage.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/14/22.
//

import UIKit
import Firebase

class LogInPage: UIViewController {
  
  
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  @IBAction func LogIn_Pressed(_ sender: UIButton) {
    
    Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
        if error == nil {
          self.show()
        }else{
            print(error!)
        }
    }
  }
  
  
  func show(){

    let vc = storyboard?.instantiateViewController(withIdentifier: "MainTab") as! MainTab
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: false, completion: nil)
    
    
    
  }
  
  
}
