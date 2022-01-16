//
//  CheckLoginVC.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit
import Firebase

class CheckLoginVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    check()
  }
  
  
  func check() {
    let storboard = UIStoryboard(name: "Main", bundle: nil)
    
    if Auth.auth().currentUser?.uid == nil {
      let welcomeVC = storboard.instantiateViewController(withIdentifier: "Welcome")
      welcomeVC.modalPresentationStyle = .fullScreen
      self.present(welcomeVC, animated: true, completion: nil)
    }else{
      let mainVC = storboard.instantiateViewController(withIdentifier: "Main")
      mainVC.modalPresentationStyle = .fullScreen
      self.present(mainVC, animated: true, completion: nil)
    }
  }
  
}
