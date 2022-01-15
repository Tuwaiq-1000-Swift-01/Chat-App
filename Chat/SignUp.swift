//
//  SignUp.swift
//  Chat
//
//  Created by Abdullah Bajaman on 15/01/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SignUp: UIViewController {

    let db = Firestore.firestore()
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSubmit(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { user, error in
            if error == nil {
                self.setUser(name: self.nameTF.text!)
                self.moveToNotificationVC()
            }else{
                print(error!.localizedDescription as Any)
            }
        }
    }
    
    
    func moveToNotificationVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TapBar")
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
    func setUser(name: String){
        
        let userID = (Auth.auth().currentUser?.uid)!
        let user = User(name: name, id: userID)

        
        db.collection("Users").document(userID).setData(user.getUser())
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
