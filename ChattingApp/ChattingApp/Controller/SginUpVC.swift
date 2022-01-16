//
//  SginUpVC.swift
//  ChattingApp
//
//  Created by Ameera BA on 15/01/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SginUpVC: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var sginUpButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      // design from class Custom in Model
      Custom.styleTextField(nameField)
      Custom.styleTextField(emailField)
      Custom.styleTextField(passwordField)
      
      sginUpButton.tintColor = UIColor.label
      cancelButton.layer.cornerRadius = 10
      cancelButton.layer.borderWidth = 0.5
      cancelButton.layer.borderColor = UIColor.black.cgColor
    }
    

  @IBAction func sginUpButtonPressed(_ sender: UIButton) {
    if emailField.text == "" || passwordField.text == "" {
      alert()
    }else{
     // SginUp()
      print("sgin Up Pressed")
     
        // Create cleaned versions of the data
        let name = self.nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let lastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
          
          // Check for errors
          if err != nil {
            print(err)
            //   There was an error creating the user
          }
          else {
            
            // User was created successfully, now store the first name and last name
            let db = Firestore.firestore()
            let id = Auth.auth().currentUser?.uid
            
            db.collection("users").document(id!).setData(["firstname": name,
                                                           "email": email, "password": password, "uid": result!.user.uid]) { (error) in
              self.performSegue(withIdentifier: "MoveToHome", sender: nil)          }

            }
            
            // Transition to the home screen
        }
    }
  }
  
  
  func SginUp(){
    if let email = emailField.text,let password = passwordField.text {
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        guard let user = authResult?.user, error == nil else {return}
        print("\(user.email!) creat")
        self.performSegue(withIdentifier: "MoveToHome", sender: nil)
      }
    }
  }
  
  
  func alert() {
    let alert = UIAlertController(title: "",
                                  message: "Please fill in the fields",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok",
                                  style: .default,
                                  handler: .none))
    present(alert, animated: true)
  }
  
  
  @IBAction func cancelButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
