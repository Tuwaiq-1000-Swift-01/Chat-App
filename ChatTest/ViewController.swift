//
//  ViewController.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        print("user id : \(Auth.auth().currentUser?.uid)")
       if Auth.auth().currentUser?.uid != nil {
            
           let vc = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! NavigationVC
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
       }else{
           let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
       }
    }

}

