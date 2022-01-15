

import UIKit
import Firebase

class SignUpViewController: UIViewController {
  
  var db =  Firestore.firestore()
  
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  
  
  
  @IBAction func registerButtonPressed(_ sender: UIButton) {
    Auth.auth().createUser(withEmail: emailTF.text!,
                           password: passwordTF.text!) {
      DataResult, error in
      if error == nil {
        let myUserEmail = DataResult?.user.email
        
        let myUser = UserSignUp (name: self.nameTF.text!,
                                 email: self.emailTF.text!,
                                 password: self.passwordTF.text!)
        
        self.db.collection("Users").document(myUserEmail!).setData(myUser.getData())
      }
    }
  }
  
}
