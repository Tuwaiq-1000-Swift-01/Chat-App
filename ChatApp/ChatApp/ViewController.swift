//
//  ViewController.swift
//  ChatApp
//
//  Created by Nada Alansari on 10/06/1443 AH.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    var msgArray = [Message]()
  

    let loggedUser = Auth.auth().currentUser?.uid
    var reciverId = ""
    
    func getMsgs(){
        let msgDB = Database.database().reference().child("ChatMsg")
        msgDB.observe(.childAdded) { (snapShot) in
                
                let value = snapShot.value as! Dictionary<String,String>
                let msgBody = value["MessageBody"]!
                let sender = value["senderId"]!
                let reciverId = value["receiverId"]!
                let time = value["time"]!
                
                let msg = Message(sender: sender, reciver: reciverId, msgBody: msgBody, time: time)
               
            if((sender == self.loggedUser &&
                reciverId == self.reciverId) ||
               (reciverId == self.loggedUser && sender == self.reciverId)){
                print(msgBody)
                self.msgArray.append(msg)
                debugPrint(self.msgArray.count)
                self.tableView.reloadData()
            }
        }
    }


    @IBAction func msgBtn(_ sender: Any) {
        print("we tryy")
        msgField.endEditing(true)
        msgField.isEnabled = false
        print("reciverId")
        print(reciverId)
              let msgDB = Database.database().reference().child("ChatMsg")
        let msgDict = ["receiverId" : reciverId, "MessageBody" : msgField.text!, "senderId": loggedUser, "time" : "9AM"]
              msgDB.childByAutoId().setValue(msgDict){(error,ref) in
                  if(error != nil){
                      debugPrint(error)
                  }else{
                      debugPrint("Msg saved successfully")
                      self.msgField.isEnabled = true
                      self.msgField.text = nil
                      self.tableView.reloadData()
                  }
              }

    }
  
    
    @IBOutlet weak var msgField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("reciverId")
        print(reciverId)
        //register the chat cell
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        //make the table rounded
        tableView.layer.cornerRadius = 10
        tableView.layer.backgroundColor = UIColor.cyan.cgColor
                getMsgs()
    }
    


}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        if(msgArray[indexPath.row].sender == Auth.auth().currentUser?.uid){
            cell.msg?.textAlignment = .right
            cell.time?.textAlignment = .right
            cell.chatCell.backgroundColor = .green


        }
        cell.msg.text = msgArray[indexPath.row].msgBody
        cell.time.text = msgArray[indexPath.row].time

        return cell
    }
}

