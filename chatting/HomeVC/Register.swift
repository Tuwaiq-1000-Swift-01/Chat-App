

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class Register: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Register Page"
        setUpConstraint()
    }
    
    let containerV = UIView()
    let registerBtn = UIButton()
    let nameTF = UITextField()
    let nameSeparatorV = UIView()
    let emailTF = UITextField()
    let emailSeparatorV = UIView()
    let passTF = UITextField()
    let loginBtn = UIButton()
    
    func setUpConstraint() {
        containerV.layer.cornerRadius = 5
        containerV.layer.masksToBounds = true
        containerV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerV)
        containerV.addSubview(nameTF)
        containerV.addSubview(nameSeparatorV)
        containerV.addSubview(emailTF)
        containerV.addSubview(emailSeparatorV)
        containerV.addSubview(passTF)
        
        nameTF.placeholder = "Your Name"
        nameTF.textAlignment = .center
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.backgroundColor = .lightGray
        
        emailTF.placeholder = "Email"
        emailTF.textAlignment = .center
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.backgroundColor = .lightGray
        
        passTF.placeholder = "Password"
        passTF.textAlignment = .center
        passTF.translatesAutoresizingMaskIntoConstraints = false
        passTF.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            containerV.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerV.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            containerV.widthAnchor.constraint(equalToConstant: 350),
            containerV.heightAnchor.constraint(equalToConstant: 150),
            
            nameTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            nameTF.topAnchor.constraint(equalTo: containerV.topAnchor),
            nameTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3),
            
            nameSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            nameSeparatorV.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            nameSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameSeparatorV.heightAnchor.constraint(equalToConstant: 1),
            
            emailTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            emailTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
            emailSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            emailSeparatorV.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            emailSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailSeparatorV.heightAnchor.constraint(equalToConstant: 1),
            
            passTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            passTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            passTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            passTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
        ])
        
        registerBtn.backgroundColor = .systemBlue
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerBtn)
        registerBtn.layer.cornerRadius = 10
        registerBtn.addTarget(self, action: #selector(registerTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerBtn.topAnchor.constraint(equalTo: containerV.bottomAnchor, constant: 50),
            registerBtn.widthAnchor.constraint(equalToConstant: 150),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(loginGo), for: .touchUpInside)
        loginBtn.setTitle("login", for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 28),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.widthAnchor.constraint(equalToConstant: 150),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func registerTpd(){
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTF.text, password.isEmpty == false {
            Auth.auth().createUser(withEmail: email, password: password) { dataResult, error in
                if error == nil {
                    let vc = UINavigationController(rootViewController: ContactVC())
                    vc.modalTransitionStyle = .coverVertical
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }else {
                    print(error?.localizedDescription as Any)
                }
                
                guard let currentUserID = Auth.auth().currentUser?.uid else {return}
                self.db.document("users/\(currentUserID)").setData([
                    "name" : self.nameTF.text,
                    "id" : currentUserID,
                    "email" : self.emailTF.text,
                ])
                
            }
        }
    }
    
    @objc func loginGo() {
        let vc = LoginVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

