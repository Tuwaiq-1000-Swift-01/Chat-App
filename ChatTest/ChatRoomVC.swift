//
//  ChatRoomVC.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatRoomVC: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    
    var user : User?
    let db = Firestore.firestore()
    var arrMessage : [Message] = []
    @IBOutlet weak var nickNameMain: UILabel!
    
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var enterMessageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameMain.text = "   \(user!.nickName!) "
        messageTable.delegate = self
        messageTable.dataSource = self
        messageTable.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "MessageCell")
        readMessage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        //cell.nickNameLabel.text =
        let idSender = arrMessage[indexPath.row].sender
        db.collection("Users").document(String(idSender!)).getDocument { snapshot , error in
            if (error == nil ){
                guard let user = snapshot else { return }
                let nickName = user.get("name") as! String
                cell.nickNameLabel.text = nickName
                
            }else{
                print(error?.localizedDescription)
            }
                
            
        }
        cell.messageLabel.text = arrMessage[indexPath.row].text
        return cell
    }

    
    func readMessage(){
        guard let currentuser = Auth.auth().currentUser?.uid,
              let reciver = user?.idUser else { return }
       let messageRef =  db.collection("Message")
        arrMessage.removeAll()
        messageRef.whereField("sender", isEqualTo: currentuser).whereField("reciver", isEqualTo: reciver ).addSnapshotListener { snapshot , error in
            self.arrMessage.removeAll()
            if let error = error {
                print(error.localizedDescription)
            }else {
               // print(snapshot?.documents.count)
                guard let messages = snapshot?.documents else { return }
                for message in messages {
                    let id = message.get("id") as! String
                    let text = message.get("text") as! String
                    let sender = message.get("sender") as! String
                    let reciver = message.get("reciver") as! String
                    let all = Message(id: id, text: text, sender: sender, reciver: reciver)
                    self.arrMessage.append(all)
                  }
                messageRef.whereField("sender", isEqualTo: reciver ).whereField("reciver", isEqualTo: currentuser )
                    .addSnapshotListener { snapshot , error in
                       
                    if let error = error {
                        print(error.localizedDescription)
                    }else {
                        
                        guard let messages = snapshot?.documents else { return }
                        for message in messages {
                            let id = message.get("id") as! String
                            let text = message.get("text") as! String
                            let sender = message.get("sender") as! String
                            let reciver = message.get("reciver") as! String
                            let all = Message(id: id, text: text, sender: sender, reciver: reciver)
                            self.arrMessage.append(all)

                        }
                        self.messageTable.reloadData()
                    }
                    
                } // end snapshot
                self.messageTable.reloadData()
                
        }
        }
        
    
    }
   
        
        
        
        @IBAction func onPressSend(_ sender: Any) {
        guard let idSender = Auth.auth().currentUser?.uid,
              let messageEnter = enterMessageField.text ,
              let reciver = user?.idUser else { return }
        let messageRef = db.collection("Message").document()
        let message = Message(id: messageRef.documentID , text: messageEnter , sender: idSender , reciver: reciver)
        messageRef.setData(message.getData())
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
struct Message {
    var id : String?
    var text : String?
    var sender : String?
    var reciver : String?
    func getData()->[String:Any] {
        return ["id": id!,"text": text!,"sender":sender! , "reciver": reciver!]
    }
}
