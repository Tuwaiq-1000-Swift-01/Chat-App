//
//  LoginVC.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressSignin(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            alert()
        }
        if let email = emailField.text,let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { auth, error in
                
                if let error = error{
                    print(error)
                }else {
                    print("sign in successful")
                    self.performSegue(withIdentifier: "moveToNavigationVC", sender: self)
                }
            }
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Email or Password is empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
   
}
