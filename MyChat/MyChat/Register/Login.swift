//
//  Login.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import UIKit
import Firebase
import SwiftUI

class Login: UIViewController {
    
    @IBOutlet var PassWord: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var Name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func SignUp(email:String,pass:String){
        
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: pass) { DataResult, error in
            if error == nil {
                let myUserID = Auth.auth().currentUser?.uid
              
                    let myUser = UsersSignUp(name: self.Name.text!, email: email, idUser: myUserID!)
                    db.collection("Users").document().setData(myUser.getDate())

                self.performSegue(withIdentifier: "Home", sender: self)
            }
        }
    }
    
    
    func Check(){
        
        if PassWord.text?.isEmpty == true || EmailText.text?.isEmpty == true  || Name.text?.isEmpty == true {
            desplayAlet(titel: "Wrong", message: "there ia field is Empety")
            
            
            
        }else{
            Auth.auth().signIn(withEmail: EmailText.text ?? "", password: PassWord.text ?? "" ) { user, error in
                if let error = error {
                    self.desplayAlet(titel: "error", message: "\(String(describing: error.localizedDescription))")
                    print("\(error.localizedDescription)")
                    
                }else{
                    
                    self.performSegue(withIdentifier: "Home", sender: self)
                    
                    
                }
            }
        }
 }
                                               
     func desplayAlet(titel:String,message:String ) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            
        }
   
    @IBAction func LoginBTN(_ sender: Any) {
        
        Check()
    }
    
    @IBAction func RegisterBtn(_ sender: Any) {
        SignUp(email: EmailText.text ?? "", pass: PassWord.text ?? "")
    }

}
                                               
