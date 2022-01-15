//
//  SignUpPage.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 11/06/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class SignUpPage: UIViewController {
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var signupNameField: UITextField!
    @IBOutlet weak var signupEmailField: UITextField!
    @IBOutlet weak var signupPasswordField: UITextField!
    
    @IBAction func signupAtction(_ sender: Any) {
        if (signupNameField.text!.isEmpty || signupEmailField.text!.isEmpty || signupPasswordField.text!.isEmpty == true){
            showErrorAlert("Cannot be Empty")
        }else{
            SignUp(email: signupEmailField.text!, pass: signupPasswordField.text!)
        }
    }
    
    func SignUp(email:String,pass:String){
        
        Auth.auth().createUser(withEmail: email, password: pass) { DataResult, error in
            if error == nil {
                let userID = DataResult?.user.uid
                let myUser = User(name: self.signupNameField.text!, email: email, userID: userID!)
                self.db.collection("Users").document(userID!).setData(myUser.getDate())
            }
            print("............sign up............")
            self.performSegue(withIdentifier: "moveToHomeScreen", sender: self)
        }
    }
    
    func showErrorAlert(_ errorMessage: String) {
        let alertError = UIAlertController(title: "Failed", message: errorMessage, preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alertError, animated: true, completion: nil)
    }
}

