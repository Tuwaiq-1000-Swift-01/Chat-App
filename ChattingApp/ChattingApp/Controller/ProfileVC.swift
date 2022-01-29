//
//  ProfileVC.swift
//  ChattingApp
//
//  Created by Ameera BA on 15/01/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileVC: UIViewController {
  
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var logOutButton: UIButton!
  
  
  var db = Firestore.firestore()
  var name : String = ""
  var email: String = ""
  var password : String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("Profile page present")
    
    // design from class Custom in Model
    Custom.styleTextField(nameTF)
    Custom.styleTextField(emailTF)
    Custom.styleTextField(passwordTF)
    
    logOutButton.tintColor = UIColor.label
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let user = Auth.auth().currentUser
    print(user?.uid)
    if let currentUser = user {
      db.collection("users").document(currentUser.uid).getDocument { doc , err in
        if err != nil {
          print(err!)
        }
        else{
          let data = doc!.data()!
          
          self.name = data["firstname"] as! String
          self.email = (user?.email)!
          self.password = data["password"] as! String
          
          self.nameTF.text = self.name
          self.emailTF.text = self.email
          self.passwordTF.text = self.password
        }
      }
    }
  }
  
  
  @IBAction func logOutButtonPressed(_ sender: UIButton) {
    do {
      try Auth.auth().signOut()
      let storyBord = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyBord.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
      self.present(vc, animated: true, completion: nil)
      print("log Out Pressed")
    }catch let error {
      print("\(error)")
    }
  }
}
