//
//  ChatMessageVC.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatMessageVC: UIViewController {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var userStatus: UILabel!
  
  
  @IBOutlet weak var inputMessage: UIView!
  var oldPointY:CGFloat = 0
  var chat:Chats!
  var messages:[Message] = []
  var timer:Timer!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let storeage = Storage.storage()
      let storeageRef = storeage.reference().child(chat.userID).child(chat.userImage)

      storeageRef.getData(maxSize: 2 * 1024 * 1024) { imageData, error in
        guard error == nil else {return}
        self.userImage.image = UIImage(data: imageData!)
        
      }
      userName.text = chat.userName
      userStatus.text = chat.status
      tableView.register(ChatMessage.self, forCellReuseIdentifier: "MessageCell")
      setNotificationKeyboard()
//      configureHideKeyboardWhenRootViewTapped()
      
      let tap = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissKeyboard))
      
      tap.cancelsTouchesInView = false
      
      tableView.addGestureRecognizer(tap)
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getMessageData), userInfo: nil, repeats: true)
    getMessageData()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    
    db.collection("Users").document(userID!).setData(["lastMessage":messages.last?.text ?? ""], merge: true)
    timer.invalidate()
  }
  
  
  @objc func getMessageData() {
    
    let db = Firestore.firestore()
    let collectionRef = db.collection("Messages")
    let userID = Auth.auth().currentUser?.uid
    
    collectionRef.whereField("senderID", isEqualTo: chat.userID).whereField("receiverID", isEqualTo: userID!).addSnapshotListener { snapshot, error in
      guard error == nil else {return}
      
      guard let data = snapshot?.documents else {return}
      
      for messageInfo in data {
        let message = Message(id: messageInfo["id"] as! String,
                              senderID: messageInfo["senderID"] as! String,
                              receiverID: messageInfo["receiverID"] as! String,
                              text: messageInfo["text"] as! String,
                              time: messageInfo["time"] as! Timestamp,
                              isRead: messageInfo["isRead"] as! Bool,
                              incoming: true)
        if !self.messages.contains(where: { messages in
          if messages.id == message.id {
            return true
          } else {
            return false
          }
        }) {
        self.messages.append(message)
        self.tableView.reloadData()
        self.tableView.scroll(to: .bottom, animated: true)

        }
      }
    }
    
    collectionRef.whereField("senderID", isEqualTo: userID!).whereField("receiverID", isEqualTo: chat.userID).addSnapshotListener { snapshot, error in
      guard error == nil else {return}
      
      guard let data = snapshot?.documents else {return}
      
      for messageInfo in data {
        let message = Message(id: messageInfo["id"] as! String,
                              senderID: messageInfo["senderID"] as! String,
                              receiverID: messageInfo["receiverID"] as! String,
                              text: messageInfo["text"] as! String,
                              time: messageInfo["time"] as! Timestamp,
                              isRead: messageInfo["isRead"] as! Bool,
                              incoming: false)
        if !self.messages.contains(where: { messages in
          if messages.id == message.id {
            return true
          } else {
            return false
          }
        }) {
        self.messages.append(message)
          self.tableView.reloadData()
          
          self.tableView.scroll(to: .bottom, animated: true)

        }
      }
    }
    
  }
  
  
  @IBAction func sendPressed(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    let documentRef = db.collection("Messages").document()
    let userID = Auth.auth().currentUser?.uid
    guard self.textField.text != "" else {return}
    let text = textField.text
    self.textField.text = ""
    documentRef.setData(["id":documentRef.documentID,
                         "senderID":userID!,
                         "receiverID":chat.userID,
                         "text":text!,
                         "time":Timestamp(),
                         "isRead":false], merge: true) { error in
      guard error == nil else {return}
      
    }
    
    
    
    
  }
  
  
  func setNotificationKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
      if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if oldPointY == 0 {
        oldPointY = inputMessage.frame.origin.y
        }
//        if tableView.frame.origin.y == 0 {
          tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
          
          inputMessage.frame.origin.y -= keyboardSize.height
          self.tableView.scroll(to: .bottom, animated: true)

//          }
      }
    
  }

  @objc func keyboardWillHide(notification: NSNotification) {
//      if tableView.frame.origin.y != 0 {
    let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    inputMessage.frame.origin.y = oldPointY
  }
  
  
  
}


// MARK: - Extension for Table view data source

extension ChatMessageVC: UITableViewDelegate,UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! ChatMessage
    let sortedMessage  = messages.sorted(by: { $0.time.dateValue() < $1.time.dateValue() })

    let chat = sortedMessage[indexPath.row]
    
    
    cell.selectionStyle = .none
    cell.setData(chat)
    cell.backgroundColor = .clear
    
    return cell
    
  }
  
  
  
}
