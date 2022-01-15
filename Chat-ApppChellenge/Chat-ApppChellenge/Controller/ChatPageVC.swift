//
//  ChatPageVC.swift
//  Chat-ApppChellenge
//
//  Created by Noura Alahmadi on 12/06/1443 AH.
//

import UIKit
import Firebase
class ChatPageVC: UIViewController {
    
    var messageArr : [Message] = []
    var reciverID : String = " "
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageFiled: UITextField!
    @IBOutlet weak var sendMessageOutlet: UIButton!
    
    @IBAction func sendMessageAction(_ sender: Any) {
        
        messageFiled.endEditing(true)
        messageFiled.isEnabled = false
        sendMessageOutlet.isEnabled = false
        let messageRef = Database.database().reference().child("Messages")
        let messageDict = ["MessageBody": messageFiled.text!,"Sender": Auth.auth().currentUser?.uid, "reciverID": reciverID]
        messageRef.childByAutoId().setValue(messageDict){(error , ref ) in
            if error != nil{
                print(error)
            }else{
                print("..........saved successfully..........")
                self.messageFiled.isEnabled = true
                self.sendMessageOutlet.isEnabled = true
                self.messageFiled.text = nil
            }
        }
    }
    
    func getMessage(){
        let messagedb = Database.database().reference().child("Messages")
        messagedb.observe(.childAdded) { snapShot in
            let value = snapShot.value as! Dictionary<String,String>
            let textMessage = value["MessageBody"]!
            let sender = value["Sender"]!
            let reciver = value["reciverID"]!
            
            debugPrint(sender)
            
            var message = Message(sender: sender, reciver: reciver, messageBody: textMessage)
            message.messageBody = textMessage
            message.sender = sender
            message.reciver = reciver
            
            if((sender == Auth.auth().currentUser?.uid && reciver == self.reciverID) || (sender == self.reciverID && reciver == Auth.auth().currentUser?.uid )){
                
                self.messageArr.append(message)
                self.messagesTableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
    }
}

extension ChatPageVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messageArr[indexPath.row]
        cell.userMessages.text = message.messageBody
        cell.userNameinChat.text = message.sender
        return cell
    }
}
