

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
  @IBOutlet weak var messageTF: UITextField!
  
  @IBOutlet weak var chatTableView: UITableView!

  let db = Firestore.firestore()
  
  var messages: [Messages] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    
    chatTableView.delegate = self
    chatTableView.dataSource = self
    
  }
  
  
  @IBAction func signOutButtonPressed(_ sender: UIButton) {
    do {
      try Auth.auth().signOut()
      dismiss(animated: true, completion: nil)
      
    } catch let signOutError as NSError {
      print(signOutError)
    }
  }
  
  
  @IBAction func sendButtonPressed(_ sender: UIButton) {
    
    if let messageText = messageTF.text,
       let messageSender = Auth.auth().currentUser?.email{
      db.collection("Messages").addDocument(data: [
        "sender": messageSender,
        "message": messageText,
        "time": Date().timeIntervalSince1970
      ]) {
        (error) in
        if let err = error{
          print(err)
        }else {
          //to delete message after send it
          DispatchQueue.main.async {
            self.messageTF.text = ""
          }
        }
      }
      
    }
    
  }
}



extension ChatViewController: UITableViewDelegate,
                              UITableViewDataSource{
  
  func loadData() {
    db.collection("Messages").order(by: "time").addSnapshotListener { (snapshot, error) in
      if let snapshotDoc = snapshot?.documents{
        
        self.messages = []
        
        for doc in snapshotDoc {
          let data = doc.data()
          if let messageSender = data["sender"] as? String,
             let messageText = data["message"] as? String {
            let newMsg = Messages(sender: messageSender,
                                  text: messageText)
            
            self.messages.append(newMsg)
            
            DispatchQueue.main.async {
              self.chatTableView.reloadData()
            }
          }
        }
      }
    }
  }
  
  
      func tableView(_ tableView: UITableView,
                     numberOfRowsInSection section: Int)
      -> Int {
        return messages.count
      }
      
      
      func tableView(_ tableView: UITableView,
                     cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Cell") as! MessageTableViewCell
        
        cell.messageTextLabel.text = messages[indexPath.row].text
        cell.backgroundColor = .clear
        
        let message = messages[indexPath.row]
        if message.sender == Auth.auth().currentUser?.email{
          cell.getMessageDesign(sender: .user)
        }else{
          cell.getMessageDesign(sender: .otherUsers)
        }
        
        return cell
      }
    }
