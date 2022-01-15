//
//  MessagesVC.swift
//  Chat
//
//  Created by Abdullah Bajaman on 14/01/2022.
//

import UIKit
import Firebase

class MessagesVC: UIViewController {

    let db = Firestore.firestore()
    var user : User!
    var senderId = Auth.auth().currentUser!.uid
    var receiverId : String = ""
    var messages : [Message] = []
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("-----------sender-------------")
        print(senderId)
        print("-----------reciever-------------")
        print(receiverId)
    }
    
    @IBAction func onClickSendMsg(_ sender: UIButton) {
        let newMsg = Message(sender: senderId, reseiver: receiverId, mBody: messageTF.text!)
        
        
//        db.collection("Messages").addDocument(data: ["msg" : messageTF.text!, "sender": senderId, "reciever": receiverId])
        let msgRef = try db.collection("Messages").addDocument(data: user.sendMessage(to: receiverId, msg: messageTF.text!))
        
        db.collection("Users").document(receiverId).setData(["notifications" : [msgRef]], merge: true)
        // msg To  Osama
        // Osamah notification -> getMessage From Abdullah
    }
    
    func getMessages(){
        db.collection("Messages").addSnapshotListener { [self] snapshot, error in
            guard let data = snapshot?.documents else {return}
            for msg in data {
                if msg.get("sender") as! String == senderId && msg.get("reciever") as! String == receiverId{
                    
                    let m = Message(sender: senderId, reseiver: msg.get("msg") as! String, mBody: msg.get("sender") as! String)
                    messages.append(m)
                    myTableView.reloadData()
                }else{
                    print("No messages")
                }
            }
        }
    }
    

}
extension MessagesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        cell.messageBody.text = messages[indexPath.row].mBody
        
        return cell
    }
    
    
}
class MessageCell: UITableViewCell{
    @IBOutlet weak var messageBody : UILabel!
    
}
