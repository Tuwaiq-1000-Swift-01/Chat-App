//
//  LoginScreenVC.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 11/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var loginNameField: UITextField!
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        if (loginNameField.text!.isEmpty || loginEmailField.text!.isEmpty || loginPasswordField.text!.isEmpty == true){
            showErrorAlert("Cannot be Empty")
        }else{
            login(email: loginEmailField.text!, pass: loginPasswordField.text!)
        }
        
    }
    
    func login(email: String , pass: String){
        Auth.auth().signIn(withEmail: email, password: pass) { DataResult, error in
            if error == nil{
                print(error)
            }else{
                print("............Logged in............")
                self.performSegue(withIdentifier: "moveToHomeScreen", sender: self)
            }
        }
    }
    func showErrorAlert(_ errorMessage: String) {
        let alertError = UIAlertController(title: "Failed", message: errorMessage, preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alertError, animated: true, completion: nil)
    }
}
