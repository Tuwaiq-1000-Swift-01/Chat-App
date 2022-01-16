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
    //var
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
      //  cell.nickNameLabel.text = user?.nickName
       // cell.messageLabel.text =
        return cell
    }

    
    func readMessage(){
        guard let currentuser = Auth.auth().currentUser?.uid,
              let reciver = user?.idUser else { return }
       let messageRef =  db.collection("Message")
        messageRef.whereField("sender", isEqualTo: currentuser).whereField("reciver", isEqualTo: currentuser )
        messageRef.whereField("reciver", isEqualTo: currentuser ).whereField("sender", isEqualTo: reciver )
            .addSnapshotListener { snapshot , error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                print(snapshot?.documents.count)
                guard let messages = snapshot?.documents else { return }
                for message in messages {
                    let messageData = message.data() as! [String : String]
                    print( messageData["text"] , messageData["reciver"] ,
                    messageData["sender"] )
                    

                }
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
