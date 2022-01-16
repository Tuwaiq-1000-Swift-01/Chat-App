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
  
  var userID:String!
  var userDocument:DocumentReference!
    override func viewDidLoad() {
        super.viewDidLoad()
      let db = Firestore.firestore()
      userID = Auth.auth().currentUser?.uid
      userDocument = db.collection("Users").document(userID!)
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

