//
//  NotificationVC.swift
//  Chat
//
//  Created by Abdullah Bajaman on 14/01/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class NotificationVC: UIViewController {

    let db = Firestore.firestore()
    var user : User!
    var nottifications : [String] = []
    var counter = 0
    
    var msgs : [Message] = []
    
    @IBOutlet weak var notiTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo { user in
            self.user = user
            
            self.db.collection("Messages").addSnapshotListener { [self] snapshot, error in
                guard let data = snapshot?.documents else {return}
                if let doc = snapshot?.documents{
                    do{
                        
                        let filterM = try doc.compactMap{
                            $0.get("reciever")
                        }
                        
                        print("---------filterM---------")
                        print(filterM as! [String])
                        nottifications = filterM as! [String]
                        notiTV.reloadData()
                    }catch { print(error.localizedDescription)}
                }
                
//                for msg in data {
//                    print("--------------reciever1111----------------")
//                    print(self.user.id)
//                    print(msg.get("reciever") as? String)
//
//
//                    if msg.get("reciever") as? String == user.id {
//                        counter += 1
//                        nottifications.append(msg.get("sender") as! String)
//
//                        notiTV.reloadData()
//                    }else{
//                        print("No messages")
//                    }
//                }
            }
        }
        

    }
    
    func getUserInfo(complation: @escaping (User)->Void){
        let userId = Auth.auth().currentUser!.uid
        db.collection("Users").document(userId).getDocument { [self] snapShot, error in
            guard let doc = snapShot else { return }
            var userInfo : User?
            do {
                userInfo = try doc.data(as: User.self)
                
            }catch{
                print(error.localizedDescription)
            }
            
            complation(userInfo!)
        }
    }
//    func getMessages(){
//
//    }

}
extension NotificationVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nottifications.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notiTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! notificationCell
        cell.message.text = nottifications[indexPath.row]
        
        cell.senderName.text = "\(counter)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let msgVC = storyboard?.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
        msgVC.user = self.user
        msgVC.receiverId = nottifications[indexPath.row]
        
        msgVC.modalPresentationStyle = .fullScreen
        self.present(msgVC, animated: true, completion: nil)
    }
}
class notificationCell : UITableViewCell{
    @IBOutlet weak var senderName : UILabel!
    @IBOutlet weak var message : UILabel!
    
}
