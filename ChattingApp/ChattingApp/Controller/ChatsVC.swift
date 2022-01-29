//
//  HomePageVC.swift
//  ChattingApp
//
//  Created by Ameera BA on 15/01/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatsVC: UIViewController {
  
  
  @IBOutlet weak var massageField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  let db = Firestore.firestore()
  var messages: [Messages] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    loedData()
    
  }
  
  
  func loedData(){
    db.collection("Messages").order(by: "time").addSnapshotListener { querySnapshot, error in
      if let snapshotDoc = querySnapshot?.documents{
        
        self.messages = []
        
        for doc in snapshotDoc {
           let data = doc.data()
          if let messageSender = data["sender"] as? String,
             let messageText = data["text"] as? String {
            let newMessage = Messages(sender: messageSender, body: messageText)
            self.messages.append(newMessage)
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          }
        }
      }
    }
  }
  
  
  @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
    if let messageText = massageField.text, let messageSender = Auth.auth().currentUser?.email{
      
      db.collection("Messages").addDocument(data: [
        "sender": messageSender,
        "text": messageText,
        "time": Date().timeIntervalSince1970
      ])
      {(error) in
        if let err = error {
          print(err)
        }else{
          DispatchQueue.main.async {
            self.massageField.text = ""
          }
        }
      }
    }
  }
}


extension ChatsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! ChatCellVC
    cell.messageLabel.text = messages[indexPath.row].body
    cell.backgroundColor = .clear
    
    let message = messages[indexPath.row]
    if message.sender == Auth.auth().currentUser?.email{
      cell.getMessageDesign(sender: .me)
    }
    else {
      cell.getMessageDesign(sender: .other)

    }
        
    return cell
  }
  
  
}
