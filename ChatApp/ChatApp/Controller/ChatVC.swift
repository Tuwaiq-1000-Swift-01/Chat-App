//
//  ChatVC.swift
//  ChatApp
//
//  Created by Njoud Alrshidi on 11/06/1443 AH.
//

import UIKit
import Firebase

class ChatVC: UIViewController {

    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var messageArr = [Message]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      //  self.navigationController?.navigationBar.isHidden = true
        
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        getMsgs()
     }
    


    @IBAction func sendBtnClicked(_ sender: Any) {
        
        messageTF.endEditing(true)
        messageTF.isEnabled = false
                sendBtn.isEnabled = false
                let msgDB = Database.database().reference().child("Messages")
                let msgDict = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTF.text!]
                msgDB.childByAutoId().setValue(msgDict){(error,ref) in
                    if(error != nil){
                        debugPrint(error)
                    }else{
                        debugPrint("Msg saved successfully")
                        self.messageTF.isEnabled = true
                        self.sendBtn.isEnabled = true
                        self.messageTF.text = nil
                    }
                }
        
    }
    
    @IBAction func logOutBtnClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print(error)
        }
        
    }
    
    func getMsgs(){
            let msgDB = Database.database().reference().child("Messages")
            msgDB.observe(.childAdded) { (snapShot) in
                let value = snapShot.value as! Dictionary<String,String>
                let text = value["MessageBody"]!
                let sender = value["Sender"]!
                let msg = Message()
                msg.msgBody = text
                msg.sender = sender
                self.messageArr.append(msg)
                debugPrint(self.messageArr.count)
                self.tableView.reloadData()
            }
        }
}

extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.messageBodyLbl.text = messageArr[indexPath.row].msgBody
            cell.userName.text = messageArr[indexPath.row].sender
            cell.iimageView.image =  UIImage(named: "1")
            return cell
        }  
}
