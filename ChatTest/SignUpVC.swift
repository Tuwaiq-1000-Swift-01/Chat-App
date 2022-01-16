//
//  SignUpVC.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpVC: UIViewController {

    var db = Firestore.firestore()
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressSignup(_ sender: Any) {


        if emailField.text == "" || passwordField.text == "" || nickNameField.text == "" {
                    alert()
        }else {
            Auth.auth().createUser(withEmail: emailField.text! , password: passwordField.text!) { result , error in
            if (error == nil ){
                print("user Sign up seccessfully ")
                let myUserID = result?.user.uid
                let myUser = User(nickName: self.nickNameField.text , email: self.emailField.text , idUser: myUserID )
                self.db.collection("Users").document(myUserID!).setData(myUser.getData())
                self.performSegue(withIdentifier: "moveToNavigationVC", sender: self)
            }else{
                print(error!.localizedDescription)
            }
            
        }
        }
        
    }
    
    
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "nickName or Email or Password is empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
struct User {
    var nickName:String?
    var email:String?
    var idUser:String?
    
    func getData()->[String:Any] {
        return ["name":nickName!,"email":email!,"id":idUser!]
    }
}
