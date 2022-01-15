//
//  UsersVC.swift
//  Chat
//
//  Created by Abdullah Bajaman on 14/01/2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersVC: UIViewController {

    var db = Firestore.firestore()
    var users: [User] = []
    var userId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUsers()
    }

    func getUsers(){
        db.collection("Users").getDocuments { snapshot, error in
            if error == nil{
                guard let data = snapshot?.documents else {return}
                //                    let u = data.filter{$0. != }
                data.map{ let u = try? $0.data(as: User.self)
                    self.users.append(u!)
                    print(u!.name)
                    self.myTableView.reloadData()
                    
                }
            }
        }
    }

}
extension UsersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        cell.name.text = users[indexPath.row].name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let msgVC = storyboard?.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
        
        msgVC.senderId = Auth.auth().currentUser!.uid
        msgVC.receiverId = users[indexPath.row].id
        
        msgVC.modalPresentationStyle = .fullScreen
        present(msgVC, animated: true, completion: nil)
    }
    
    
}
class UserCell : UITableViewCell{
    @IBOutlet weak var name: UILabel!
}
