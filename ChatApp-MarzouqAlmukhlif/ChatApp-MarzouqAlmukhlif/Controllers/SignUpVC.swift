//
//  SignUpVC.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
class SignUpVC: UIViewController {
  
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var scrollView: UIScrollView!
  var textFeildSelected:UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNotificationKeyboard()
    configureHideKeyboardWhenRootViewTapped()

  }
  
  
  @IBAction func signInPressed(_ sender: UIButton) {
    
    let storboard = UIStoryboard(name: "Main", bundle: nil)
    let welcomeVC = storboard.instantiateViewController(withIdentifier: "SignIn")
    welcomeVC.modalPresentationStyle = .fullScreen
    let parentVC = presentingViewController
    dismiss(animated: true) {
      parentVC!.present(welcomeVC, animated: true)
    }
    
  }
  
  @IBAction func signUpPressed(_ sender: UIButton) {
    
    let username = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let isValidate = validationEmailPassword(email: email, password: password)
    
    if isValidate {
      
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        guard error == nil else {
          self.alert(message: error!.localizedDescription)
          return
        }
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userID!).setData(["username":username,"id":userID!,"image":"","lastMessage":" ","status":" "], merge: true) { error in
          guard error == nil else {
            self.alert(message: error!.localizedDescription)
            return
          }
          
          let storboard = UIStoryboard(name: "Main", bundle: nil)
          let welcomeVC = storboard.instantiateViewController(withIdentifier: "Main")
          welcomeVC.modalPresentationStyle = .fullScreen
          self.present(welcomeVC, animated: true, completion: nil)
          
        }
        
        
        
      }
      
    }
  }
  
  
  
  func validationEmailPassword(email:String ,password:String) -> Bool {
    
    if email == "" || password == "" {
      alert(message: "One of the fields is empty, please check all fields")
      return false
    }
    
    if !email.contains("@") || !email.contains(".") {
      alert(message: "Please write the email in the correct way")
      return false
    }
    
    if password.count < 6 {
      alert(message: "The password is very short, it must be at least 6")
      return false
    } else if password.count > 15 {
      alert(message: "The password is too long, it should be 15 at most")
      return false
    } else {
      let Password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
      let isValied = Password.evaluate(with: password)
      
      if !isValied {
        alert(message: "Password must contain at least one capital letter and one number")
        return false
      }
    }
    
    return true
    
  }
  
  
  func alert(message:String) {
    let alert = UIAlertController(title: "Alert",
                                  message: message,
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "OK",
                               style: .cancel,
                               handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    
  }
  
  
  func setNotificationKeyboard ()  {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWasShown(notification: NSNotification)
  {
    let info = notification.userInfo!
    let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height+10, right: 0.0)
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
    var aRect : CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if let activeField = textFeildSelected
    {
      if (!aRect.contains(activeField.frame.origin))
      {
        scrollView.scrollRectToVisible(activeField.frame, animated: true)
      }
    }
  }
  
  
  @objc func keyboardWillBeHidden(notification: NSNotification){
    let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0,bottom: 0.0, right: 0.0)
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
    self.view.endEditing(true)
  }
  
}


extension SignUpVC:UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField)
  {
    textFeildSelected = textField;
  }
  
  func textFieldDidEndEditing(_ textField: UITextField)
  {
    textFeildSelected = nil;
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Try to find next responder
    if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
      nextField.becomeFirstResponder()
    } else {
      // Not found, so remove keyboard.
      textField.resignFirstResponder()
    }
    // Do not add a line break
    return false
  }
}
