//
import UIKit
import FirebaseFirestore
import FirebaseAuth


class LoginVC: UIViewController {
    
    let db = Firestore.firestore()
    
    let emailTF = UITextField()
    let passTf = UITextField()
    let loginBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        view.addSubview(emailTF)
        view.addSubview(passTf)
        view.addSubview(loginBtn)
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.placeholder = "Email"
        emailTF.textAlignment = .center
        emailTF.borderStyle = .roundedRect
        
        passTf.translatesAutoresizingMaskIntoConstraints = false
        passTf.placeholder = "Password"
        passTf.textAlignment = .center
        passTf.borderStyle = .roundedRect
        passTf.isSecureTextEntry = true
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.addTarget(self, action: #selector(loginGo), for: .touchUpInside)
        loginBtn.setTitle("login", for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.heightAnchor.constraint(equalToConstant: 60),
            emailTF.widthAnchor.constraint(equalToConstant: 320),
            
            passTf.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 18),
            passTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTf.heightAnchor.constraint(equalToConstant: 60),
            passTf.widthAnchor.constraint(equalToConstant: 320),
    
            loginBtn.topAnchor.constraint(equalTo: passTf.bottomAnchor, constant: 28),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.widthAnchor.constraint(equalToConstant: 150),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func loginGo() {
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTf.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    let vc = UINavigationController(rootViewController: ContactVC())
                    vc.modalTransitionStyle = .coverVertical
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
}
