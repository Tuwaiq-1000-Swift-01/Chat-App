
import UIKit
import Firebase
import FirebaseFirestore

class ChatVC: UIViewController {
    
    var user : UserSignUp?
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getAllMessages()
        chatTV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    let chatTV: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    let messageTF: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Message"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let sendBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        $0.tintColor = .brown
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return $0
    }(UIButton())

    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = user?.name
        
        chatTV.delegate = self
        chatTV.dataSource = self
        
        view.addSubview(chatTV)
        view.addSubview(messageTF)
        view.addSubview(sendBtn)
        
        NSLayoutConstraint.activate([
            chatTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            chatTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            chatTV.bottomAnchor.constraint(equalTo: messageTF.topAnchor),
            
            messageTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            messageTF.rightAnchor.constraint(equalTo: sendBtn.leftAnchor, constant: -5),//*****
            messageTF.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageTF.heightAnchor.constraint(equalToConstant: 45),
            
            sendBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            sendBtn.heightAnchor.constraint(equalTo: messageTF.heightAnchor),
            sendBtn.widthAnchor.constraint(equalTo: sendBtn.heightAnchor),
            sendBtn.centerYAnchor.constraint(equalTo: messageTF.centerYAnchor)
        ])
    }
}

extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = chatTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentUserID = Auth.auth().currentUser?.uid
        cell.textLabel?.text = messages[indexPath.row].content
        print(messages[indexPath.row].content)
        if messages[indexPath.row].sender == currentUserID {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .blue
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .red
        }
        return cell
    }
}

extension ChatVC {
    @objc func sendMessage() {
        let messageId = UUID().uuidString
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let message = messageTF.text else {return}
        guard let user = user else {return}
        Firestore.firestore().document("messages/\(messageId)").setData([
            "sender" : currentUserID,
            "receiver" : user.id!,
            "content" : message,
            "id": messageId,
        ])
        
        messageTF.text = ""
    }
    
    func getAllMessages() {
        guard let chatID = user?.id else {return}
        guard let userID = Auth.auth().currentUser?.uid else {return}
        self.messages.removeAll()
        
        Firestore.firestore()
            .collection("messages")
            .whereField("receiver", isEqualTo: userID)
            .whereField("sender", isEqualTo: chatID)
            .addSnapshotListener { snapshot, error in
                
                if error == nil {
                    for document in snapshot!.documents{
                        let data = document.data()
                        let newMsg = Message(
                            content: data["content"] as? String,
                            sender: data["sender"] as? String,
                            reciever: data["receiver"]  as? String,
                            id: (data["id"]  as? String) ?? "",
                            timestamp: (data["timestamp"]  as? Timestamp) ?? Timestamp()
                        )
                        let isMsgAdded = self.messages.contains { msg in
                            return msg.id == newMsg.id
                        }
                        if !isMsgAdded {
                            self.messages.append(newMsg)
                        }
                        
                    }
                    self.chatTV.reloadData()
                }
            }
        
        Firestore.firestore()
            .collection("messages")
            .whereField("sender", isEqualTo: userID)
            .whereField("receiver", isEqualTo: chatID)
            .addSnapshotListener { snapshot, error in
                
                if error == nil {
                    for document in snapshot!.documents{
                        let data = document.data()
                        let newMsg = Message(
                            content: data["content"] as? String,
                            sender: data["sender"] as? String,
                            reciever: data["receiver"]  as? String,
                            id: (data["id"]  as? String) ?? "",
                            timestamp: (data["timestamp"]  as? Timestamp) ?? Timestamp()
                        )
                        let isMsgAdded = self.messages.contains { msg in
                            return msg.id == newMsg.id
                        }
                        if !isMsgAdded {
                            self.messages.append(newMsg)
                        }
                        self.chatTV.reloadData()
                    }
                    
                }
            }
    }
}
