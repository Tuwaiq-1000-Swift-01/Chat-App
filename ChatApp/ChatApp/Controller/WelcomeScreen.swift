//
//  ViewController.swift
//  ChatApp
//
//  Created by Njoud Alrshidi on 11/06/1443 AH.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
   
      
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

      


    @IBAction func loginBtnClicked(_ sender: Any) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

