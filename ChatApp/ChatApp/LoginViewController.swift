//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Nada Alansari on 10/06/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBAction func loginBtn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTxt.text ?? "", password:passText.text ?? "")
        { result, error in
            if(error == nil){
                print("we go")
                print("the user loged id \(result?.user.uid)")
               
            }
            else{
                if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case .wrongPassword,
                            .invalidCredential:
                        let alert = UIAlertController(title: "Incorrect password ", message: "The password you entered is incorrect. Please try again", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: {() -> Void in })
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                            
                        }))
                    case .userNotFound,
                            .invalidEmail:
                        let alert = UIAlertController(title: "Incorrect Email Address", message: "The email address you entered doesn't appear to belong to an account. Please check your address and try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  
                            
                        }))
                        self.present(alert, animated: true, completion: {() -> Void in })
                    default:
                        let alert = UIAlertController(title: "There is an error", message: "Here is the message from Firebase: \(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  
                            
                        }))
                        self.present(alert, animated: true, completion: {() -> Void in })
                    }
                }
            }
            
        }
    }
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

 

}
