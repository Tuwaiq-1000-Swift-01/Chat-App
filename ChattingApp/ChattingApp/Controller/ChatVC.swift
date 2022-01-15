//
//  ChatVC.swift
//  ChattingApp
//
//  Created by A A on 15/01/2022.
//

import UIKit
import Firebase

class ChatVC: UIViewController {
  
  @IBOutlet weak var messagesTableView: UITableView!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var messagesTF: UITextField!
  @IBOutlet weak var senderEmail: UILabel!
  
  var db = Firestore.firestore()
  var messages: [Messages] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messagesTableView.delegate = self
    messagesTableView.dataSource = self
    
    senderEmail.text = Auth.auth().currentUser?.email
    
    configureHideKeyboardWhenRootViewTapped()
    loadData()
  }
  
  
  @IBAction func sendButtonPressed(_ sender: UIButton) {
    
    if let messageText = messagesTF.text,
       let messageSender = Auth.auth().currentUser?.email {
      db.collection("Messages").addDocument(data: [
                                              "sender": messageSender,
                                              "text": messageText,
                                              "time": Date().timeIntervalSince1970 ])
      { (error) in
        if let err = error {
          print(err)
        } else {
          DispatchQueue.main.async {
            self.messagesTF.text = ""
          }
        }
      }
    }
  }
  
  
  @IBAction func logOutButtonPressed(_ sender: AnyObject) {
    do {
      try Auth.auth().signOut()
      transitionToMain()
    } catch let signOutError as NSError {
      print("Error signing out: %&", signOutError)
    }
  }
  
  
  func transitionToMain(){
    
    let mainViewController = storyboard?.instantiateViewController(identifier:"AuthorizationVC")
    
    view.window?.rootViewController = mainViewController
    view.window?.makeKeyAndVisible()
    
  }
  
  
  func loadData(){
    db.collection("Messages").order(by: "time").addSnapshotListener { ( querySnapshot, error) in
      if let snapchotDoc = querySnapshot?.documents {
        self.messages = []
        for doc in snapchotDoc {
          let data = doc.data()
          if let messageSender = data["sender"] as? String,
             let messageText = data["text"] as? String {
            let newMessage = Messages(sender: messageSender, body: messageText)
            self.messages.append(newMessage)
            
            DispatchQueue.main.async {
                self.messagesTableView.reloadData()
            }
            
          }
        }
      }
    }
  }
  
}

extension ChatVC : UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    messages.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessageTableViewCell
    cell.messageLabel.text = messages[indexPath.row].body
    cell.backgroundColor = .clear
    
    let message = messages[indexPath.row]
    if message.sender == Auth.auth().currentUser?.email {
      cell.getMessageDesign(sender: .me)
    } else {
      cell.getMessageDesign(sender: .other)
    }
    return cell
  }

  
}
