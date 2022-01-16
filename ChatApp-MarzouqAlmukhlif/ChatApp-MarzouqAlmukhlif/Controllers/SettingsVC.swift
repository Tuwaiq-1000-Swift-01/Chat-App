//
//  SettingsVC.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import PhotosUI


class SettingsVC: UIViewController {
  
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var statusField: UITextField!
  @IBOutlet weak var scrollView: UIScrollView!
  
  
  var userID:String!
  var userDocument:DocumentReference!
  var textFeildSelected:UITextField!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    let db = Firestore.firestore()
    userID = Auth.auth().currentUser?.uid
    userDocument = db.collection("Users").document(userID!)
    setNotificationKeyboard()
    configureHideKeyboardWhenRootViewTapped()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getProfileData()
  }
  
  func getProfileData() {
    
    userDocument.getDocument { snapshot, error in
      guard error == nil else {
        self.alert(message: error!.localizedDescription)
        return
      }
      
      guard let data = snapshot?.data() else {
        return
      }
      
      self.usernameField.text = data["username"] as? String
      self.statusField.text = data["status"] as? String
      let imageId = data["image"] as? String
      
      if imageId != "" {
        let storeage = Storage.storage()
        let storeageRef = storeage.reference().child("xqNcisocJyUm5oDFl0zRekuKntI2").child("50E367E4-ED5F-4874-AD08-0B07D7EE58E5")
        
        storeageRef.getData(maxSize: 2 * 1024 * 1024) { imagedata, error in
          guard error == nil else {
            self.alert(message:error!.localizedDescription)
            return
          }
          self.profilePicture.image = UIImage(data: (imagedata)!)
        }
      }
      
      
      
      
    }
  }
  
  
  @IBAction func selectPicturePressed(_ sender: UIButton) {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 1
    configuration.filter = .images
    let photoPicker = PHPickerViewController(configuration: configuration)
    photoPicker.delegate = self
    present(photoPicker, animated: true, completion: nil)
  }
  
  
  @IBAction func updatePressed(_ sender: UIButton) {
    
    
    
    let username = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    let status = statusField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let storeage = Storage.storage()
    let imageID = UUID().uuidString
    let storeageRef = storeage.reference().child(userID!).child(imageID)
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    
    
    let imageData = profilePicture.image?.jpegData(compressionQuality: 0.75)
    
    storeageRef.putData(imageData!, metadata: uploadMetadata) { metadata, error in
      guard error == nil else {
        self.alert(message: error!.localizedDescription)
        return
      }
      
      self.userDocument.setData(["username":username!,
                                 "status":status!,
                                 "image":imageID], merge: true) { error in
        guard error == nil else {
          self.alert(message: error!.localizedDescription)
          return
        }
        
        self.alert(message: "Update profile successful")
      }
      
    }
    
    
    
    
  }
  
  
  @IBAction func signOutPressed(_ sender: UIButton) {
    
    do {
      try Auth.auth().signOut()
      
      let storboard = UIStoryboard(name: "Main", bundle: nil)
      let welcomeVC = storboard.instantiateViewController(withIdentifier: "CheckLogin")
      welcomeVC.modalPresentationStyle = .fullScreen
      self.present(welcomeVC, animated: true, completion: nil)
    } catch {
      alert(message: error.localizedDescription)
    }
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
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    var aRect : CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if let activeField = self.textFeildSelected
    {
      if (!aRect.contains(activeField.frame.origin))
      {
        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
      }
    }
  }
  
  
  @objc func keyboardWillBeHidden(notification: NSNotification){
    let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0,bottom: 0.0, right: 0.0)
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    self.view.endEditing(true)
  }
  
  
}


extension SettingsVC:UITextFieldDelegate {
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

extension SettingsVC: PHPickerViewControllerDelegate {
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
    if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
      result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
        if let image = image as? UIImage {
          DispatchQueue.main.async {
            self.profilePicture.image = image
          }
        }
        
      }
    }
  }
  
  
  
  
}

