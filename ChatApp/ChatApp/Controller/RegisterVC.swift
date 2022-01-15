//
//  RegisterVC.swift
//  ChatApp
//
//  Created by Njoud Alrshidi on 11/06/1443 AH.
//

import UIKit
import Firebase
class RegisterVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                    if(error == nil){
                        print("Registration Successful")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        print(error)
                    }
                }
    }
   

}
