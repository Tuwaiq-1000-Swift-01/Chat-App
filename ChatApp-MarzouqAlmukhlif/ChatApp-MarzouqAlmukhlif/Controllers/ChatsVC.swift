//
//  ChatsVC.swift
//  ChatApp-MarzouqAlmukhlif
//
//  Created by Marzouq Almukhlif on 12/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatsVC: UIViewController {
  
  
  @IBOutlet weak var tableView: UITableView!
  
  
  var filterChats:[Chats]!
  var chats:[Chats] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    filterChats = chats
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    getUsers()
  }
  
  
  func getUsers() {
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let storage = Storage.storage()
    
    let collectionMessagesRef =  db.collection("Users")
    
    collectionMessagesRef.whereField("id", isNotEqualTo: userID!).addSnapshotListener { snapshot, error in
      guard error == nil else {
        
        return
      }
      
      guard let document = snapshot?.documents else {
        return
      }
      self.filterChats.removeAll()
      self.chats.removeAll()
      for userInfo in document {
        print("dd")
        let user = Chats(userID: userInfo["id"] as! String,
                         userImage: userInfo["image"] as! String,
                         userName: userInfo["username"] as! String,
                         lastMessage: userInfo["lastMessage"] as? String ?? "",
                         status: userInfo["status"] as? String ?? ""
                         )
        
        self.chats.append(user)
        self.filterChats = self.chats
      }
      self.tableView.reloadData()
      
      
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    
    switch segue.identifier {
    case "ChatMessage":
      
      if let row = tableView.indexPathForSelectedRow?.row {
  
        let ChatMessageVC = segue.destination as! ChatMessageVC
        ChatMessageVC.chat = filterChats[row]
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  
}


// MARK: - Extension for Search bar delegate

extension ChatsVC: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar,
                 textDidChange searchText: String) {
    filterChats = searchText.isEmpty ? chats : chats.filter {
      (item : Chats) -> Bool in
      
      return item.userName.range(of: searchText,
                                 options: .caseInsensitive ,
                                 range: nil,
                                 locale: nil) != nil
    }
    
    tableView.reloadData()
  }
  
}

// MARK: - Extension for Table view data source

extension ChatsVC: UITableViewDelegate,UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterChats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsCell
    
    var chat:Chats!
    
    if filterChats.count != 0 {
      chat = filterChats[indexPath.row]
    } else {
      chat = chats[indexPath.row]
    }
    
    cell.lastMessage.text = chat.lastMessage
    cell.userName.text = chat.userName
    
    var messageUnread = 0
//    for message in chat.messages {
//      if !message.isRead {
//        messageUnread += 1
//      }
//    }
    if messageUnread != 0 {
      cell.newMessageCount.text = "\(messageUnread)"
    } else {
      cell.newMessageCount.isHidden = true
    }
    
    
    
    return cell
    
  }
  
  
  
}
