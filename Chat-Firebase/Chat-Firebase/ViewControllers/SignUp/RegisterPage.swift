//
//  RegisterPage.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/14/22.
//

import UIKit
import Firebase

class RegisterPage: UIViewController {
  
  
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var familyNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var EmailTextField: UITextField!
  
  
  
  
  
  var db = Firestore.firestore()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  func signUp(email: String, password: String){
    Auth.auth().createUser(withEmail: email, password: password) { DataResult, error in
      
      if error == nil {
        let userID = DataResult?.user.uid
        let  name = self.firstNameTextField.text
        let familyName = self.familyNameTextField.text
        let user = UserSignUp(name: name, familyName: familyName, email: email, idUser: userID!)
        self.db.collection("Users").document(userID!).setData(user.getDate())
        self.show()

      }
    }
  }
  
  
  
  @IBAction func register_Pressed(_ sender: UIButton) {
    
    signUp(email: EmailTextField.text!, password: passwordTextField.text!)
  }
  
  
  func show(){
    let vc = storyboard?.instantiateViewController(withIdentifier: "MainTab") as! MainTab
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: false, completion: nil)
  }

  
  
}


struct UserSignUp {
  var name:String?
  var familyName:String?
  var email:String?
  var idUser:String?
  
  func getDate()->[String:Any] {
    return ["User Name":name!, "Family Name":familyName! ,"Email":email!,"ID":idUser!]
  }
}


