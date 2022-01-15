//
//  ViewController.swift
//  Chat
//
//  Created by Abdullah Bajaman on 14/01/2022.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("-------------------------------------")
        print( Auth.auth().currentUser?.uid )
        if Auth.auth().currentUser?.uid != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TapBar")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }

    @IBAction func onClickSignin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { user, error in
            if error == nil{
                
                self.moveToNotificationVC()
            }else{
                print(error!.localizedDescription as Any)
            }
        }
    }
    
    @IBAction func onClickSignUp(_ sender: UIButton) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    func moveToNotificationVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TapBar")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
//    func setUser(name: String){
//        let db = Firestore.firestore()
//        let userID = (Auth.auth().currentUser?.uid)!
//        let user = User(name: name, id: userID)
//        db.collection("Users").document(userID).setData(user.setUser())
//
//    }
}

//struct User: Codable {
//    var name : String
//    var nottifications : [UserNotification]
//    
//    func sendMessage(to userId: DocumentReference?, msg: String){
//        let db = Firestore.firestore()
////        let noti = UserNotification(userId: userId, breefMsg: msg)
////        let newNotification = db.collection("Nottifications").document(userId!.documentID)
////        try! newNotification.setData(["userId": userId!, "breefMsg": msg])
//
//    }
//}




