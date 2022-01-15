//
//  LoginVC.swift
//  ChatApp
//
//  Created by Maram Al shahrani on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    var emailTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemGray6
        tf.layer.cornerRadius = 15
        return tf
    }()
    var passTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.backgroundColor = .systemGray6
        tf.layer.cornerRadius = 15
        return tf
    }()
    var signIn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign in", for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return btn
    }()
    var signUp: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign up", for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(emailTF)
        view.addSubview(passTF)
        view.addSubview(signIn)
        view.addSubview(signUp)
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            emailTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            
            passTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 24),
            passTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            passTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            passTF.heightAnchor.constraint(equalToConstant: 40),
            
            signIn.topAnchor.constraint(equalTo: passTF.bottomAnchor, constant: 48),
            signIn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            signIn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            signIn.heightAnchor.constraint(equalToConstant: 40),
            
            
            signUp.topAnchor.constraint(equalTo: signIn.bottomAnchor, constant: 24),
            signUp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            signUp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            signUp.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func registerBtnPressed() {
        let email = emailTF.text ?? ""
        let password = passTF.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            self.present(
                UINavigationController(rootViewController: ContactsVC()),
                animated: true,
                completion: nil
            )
        }
        
    }
    @objc func loginBtnPressed() {
        let email = emailTF.text ?? ""
        let password = passTF.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            let vc =  TabVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
