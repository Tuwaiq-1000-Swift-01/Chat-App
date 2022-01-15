//
//  ChatVC.swift
//  Chat
//
//  Created by Jawaher on 13/01/22.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
	
	var emailTF: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.backgroundColor = .systemGray6
		return tf
	}()
	var passwordTF: UITextField = {
		let tf = UITextField()
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.isSecureTextEntry = true
		tf.backgroundColor = .systemGray6
		return tf
	}()
	var loginBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Login", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.6019317994, green: 0.6448008315, blue: 0.807385069, alpha: 1)
        btn.layer.cornerRadius = 14
		btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
		return btn
	}()
	var registerBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Register", for: .normal)
		btn.backgroundColor = #colorLiteral(red: 0.5489454189, green: 0.6895801969, blue: 0.807385069, alpha: 1)
        btn.layer.cornerRadius = 14
		btn.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
		return btn
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		view.addSubview(emailTF)
		view.addSubview(passwordTF)
		view.addSubview(loginBtn)
		view.addSubview(registerBtn)
		
		NSLayoutConstraint.activate([
			emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
			emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			emailTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
			emailTF.heightAnchor.constraint(equalToConstant: 40),
			
			passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 24),
			passwordTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			passwordTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
			passwordTF.heightAnchor.constraint(equalToConstant: 40),
			
			loginBtn.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 48),
			loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
			loginBtn.heightAnchor.constraint(equalToConstant: 40),
			
			
			registerBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 24),
			registerBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			registerBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
			registerBtn.heightAnchor.constraint(equalToConstant: 40),
		])
	}
	
	@objc func registerBtnPressed() {
		let email = emailTF.text ?? ""
		let password = passwordTF.text ?? ""
		
		if email.isEmpty || password.isEmpty {
			return
		}
		
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if error != nil {
				print(error as Any)
				return
			}
			
			self.present(TabVC(), animated: true, completion: nil)
		}
		
	}
	@objc func loginBtnPressed() {
		let email = emailTF.text ?? ""
		let password = passwordTF.text ?? ""
		
		if email.isEmpty || password.isEmpty {
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if error != nil {
				print(error as Any)
				return
			}
			
			self.present(TabVC(), animated: true, completion: nil)
		}
		
	}
}
