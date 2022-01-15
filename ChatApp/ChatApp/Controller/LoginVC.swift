//
//  LoginVC.swift
//  ChatApp
//
//  Created by Njoud Alrshidi on 11/06/1443 AH.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    self.navigationController?.navigationBar.isHidden = true
        
    }
        
        func showAlert(_ msg: String) {
                let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
          }

    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            if(error != nil){
                print(error)
                self.showAlert(error?.localizedDescription ?? "")
            }else{
                  
                let vc = self.storyBoard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
    


