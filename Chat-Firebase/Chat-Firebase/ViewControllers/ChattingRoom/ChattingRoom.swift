//
//  ChattingRoom.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import UIKit
import Firebase



private let reuseIdentifier = String(describing: MessageCell.self)


class ChattingRoom: UIViewController {
  
  var user: User?
  //  var currentUser: User?
  var messages: [Message] = []
  let db = Firestore.firestore()
  var reciver = ""
  
  
  @IBOutlet weak var messageTextField: UITextField!
  
  
  @IBOutlet weak var tabelView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    tabelView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    tabelView.rowHeight = 65
//    loadMessages()
    
    
  }
  
  @IBAction func send_Pressed(_ sender: UIButton) {
    
    print("\n\n\n\(messages.count)\n\n")
    
    var idMessage = Int.random(in: 1000000000...9999999999)
    print(idMessage)
    db.collection("Courses").getDocuments { Snapshot, error in
      guard let documents = Snapshot?.documents else{return}
      for idDoucment in documents {
        print(idDoucment.documentID)
        if idDoucment.documentID == "\(idMessage)" {
          idMessage = Int.random(in: 1000000000...9999999999)
        }
        
      }
      if let messageBody = self.messageTextField.text, let myID = Auth.auth().currentUser?.uid {
        let myMessage = Message(sender: myID, reciever: self.reciver, message: messageBody, idMessage: "\(idMessage)")
        
        print("\n\n\n\n\n\(myMessage)\n\n\n\n\n\n\n\n")
        self.db.collection("Users").document(myID).collection("Messages").document("\(idMessage)").setData(myMessage.getData()){ (error) in
          if let e = error {
            print(e)
          }else {
            print("messages successfuly save!")
            
            DispatchQueue.main.async {
              self.messageTextField.text = ""
            }
          }
        }
      }
    }
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    readCourses()
  }
  
  func readCourses(){
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    db.collection("Users").document(userID!).collection("Messages").getDocuments { Snapshot, error in
      if error == nil {
        self.messages.removeAll()
        guard let data = Snapshot?.documents else {return}
        for userinfo in data {
          let Messagesender = userinfo["sender"] as? String
              let idMessage = userinfo["idMessage"] as? String
              let idReciver = userinfo["reciever"] as? String
              let messageBody = userinfo["Message"] as? String // explain why string
          let newMessage = Message(sender: Messagesender, reciever: idReciver, message: messageBody, idMessage: idMessage!)
                self.messages.append(newMessage)
              }
          self.tabelView.reloadData()
        }
      }
      
    }
}

  
  extension ChattingRoom: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! MessageCell
      cell.messageLabel.text = messages[indexPath.row].message
      let message = messages[indexPath.row]
      
      // if the current user is the sender
      if message.sender == Auth.auth().currentUser?.uid {
        DispatchQueue.main.async {
          cell.getMessageDesign(sender: ".Me")
        }
        
      } else {
        DispatchQueue.main.async {
          cell.getMessageDesign(sender: ".Other")
        }
      }
      
      return cell
    }
  }
  
  extension ChattingRoom : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.text == "message here" {
        textView.text = ""
        textView.textColor = .darkGray
      }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text == "" {
        textView.text = "message here"
        textView.textColor = .lightGray
      }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
    }
  }
  
