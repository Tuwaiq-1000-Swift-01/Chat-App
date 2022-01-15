//
//  ViewController.swift
//  chatApp01
//
//  Created by Osama folta on 11/06/1443 AH.
//
import Firebase
import UIKit

class ViewController: UIViewController {
    let dbStore = Firestore.firestore()
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var errlable: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginPressd(_ sender: Any) {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && password.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && name.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            logIn(name:name.text!,email: email.text!, password: password.text!, segueID: "move1")
    }else{
        showAlert(title: "Error", message: "Please Fill TextFields")
        }
    }
    
    
    @IBAction func signupPressd(_ sender: Any) {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && password.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && name.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            signUp(name:name.text!,email: email.text!, password: password.text!, segueID: "move1")
    }else{
        showAlert(title: "Error", message: "Please Fill TextFields")
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func signUp(name:String,email:String,password:String,segueID:String){
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if err == nil {
                let uid = result?.user.uid
                self.dbStore.collection("Users").document(uid!).setData(["username":name,"userID":uid!])
                self.performSegue(withIdentifier: segueID, sender: self)
            }else{print(err!.localizedDescription)}
        }
    }
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func logIn(name:String,email:String,password:String,segueID:String){
        Auth.auth().signIn(withEmail:email, password:password) { result, error in
            if error == nil {
                let ID = result?.user.uid
                self.dbStore.collection("Users").document(ID!).getDocument { snap, err in
                    if let data = snap?.data(){
                        let name = data["username"] as! String
                        if name == self.name.text{
                            self.performSegue(withIdentifier: segueID, sender: self)
                        }else{
                            self.errlable.isHidden = false
                            self.errlable.text = "Please check Your Name"
                        }
                    }
                }
              
            }  else {
                self.errlable.isHidden = false
                self.errlable.text = error!.localizedDescription
            }
        }
    }
}

