//
//  ViewController.swift
//  ChattingApp
//
//  Created by Ameera BA on 14/01/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase


class LoginVC: UIViewController {
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // design from class Custom in Model
    Custom.styleButton(loginButton)
    Custom.styleTextField(emailField)
    Custom.styleTextField(passwordField)
  }
  
  
  @IBAction func logInButtonPressed(_ sender: UIButton) {
    if emailField.text == "" || passwordField.text == "" {
      alert()
    } else {
      login()
      print("Log in")
    }
  }
  
  
  @IBAction func creatAccountPressed(_ sender: UIButton) {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyBoard.instantiateViewController(withIdentifier: "SginUpVC") as! SginUpVC
    self.present(vc, animated: true, completion: nil)
    print("Creat account Pressed")
  }
  
  
  func login(){
    if let email = emailField.text,
       let password = passwordField.text{
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if error != nil {
          print("Error")
        }
        self.performSegue(withIdentifier: "MoveToHome", sender: nil)
      }
    }
  }
  
  
  func alert() {
    let alert = UIAlertController(title: "",
                                  message: "email or password is empty",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok",
                                  style: .default,
                                  handler: .none))
    present(alert, animated: true)
  }
}
