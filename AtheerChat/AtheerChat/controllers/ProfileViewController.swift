//
//  ProfileViewController.swift
//  AtheerChat
//
//  Created by Eth Os on 06/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController, UITextFieldDelegate {

    
    let nameTextFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.resignFirstResponder()
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.backgroundColor = .clear
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.textColor = .black
        return field
    }()
    
    let statusTextFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.resignFirstResponder()
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.backgroundColor = .clear
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "Status"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.textColor = .black
        return field
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(logoutBtnPressed), for: .touchUpInside)

        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)

        return button
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(nameTextFeild)
        view.addSubview(statusTextFeild)
        view.addSubview(logoutButton)
        view.addSubview(saveButton)
        
        nameTextFeild.translatesAutoresizingMaskIntoConstraints = false
        statusTextFeild.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextFeild.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            nameTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            nameTextFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            nameTextFeild.heightAnchor.constraint(equalToConstant: 40),
            
            statusTextFeild.topAnchor.constraint(equalTo: nameTextFeild.bottomAnchor, constant: 24),
            statusTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            statusTextFeild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            statusTextFeild.heightAnchor.constraint(equalToConstant: 40),
            
            logoutButton.topAnchor.constraint(equalTo: statusTextFeild.bottomAnchor, constant: 48),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 48),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    @objc func logoutBtnPressed(){
        
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                    
            guard let strongSelf = self else {
                return
            }
            
            
            do{
                try Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
                
            }catch{
                print("Faild to log out")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc func saveButtonPressed(){
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        print("Save Button Wooooork")
        
        let newName = nameTextFeild.text ?? ""
        let status = statusTextFeild.text ?? ""
        
        
        
        UsersService.shared.updateUserInfo(user: User(id: currentUserId,
                                                      name: newName,
                                                      status: status) )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        nameTextFeild.resignFirstResponder()
        statusTextFeild.resignFirstResponder()

        return view.endEditing(true)
    }
}

