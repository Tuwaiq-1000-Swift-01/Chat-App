//
//  ChatView.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import UIKit
import FirebaseDatabase
import Firebase

class ChatView: UIViewController {
    
    @IBOutlet var TextField: UITextField!
    @IBOutlet var myTable: UITableView!
    
    var arrMessage : [Messages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadMessages()
        myTable.reloadData()
 
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        
        //        let random = Int.random(in: 0...999999)
        //
        //        ref.child("chatroom").child(Auth.auth().currentUser?.uid ?? "").setValue(["massage\(random)":self.TextField.text])
        let db = Firestore.firestore()
        //
        if let messageBody = TextField.text, let account = Auth.auth().currentUser?.email {
            
            let time = Date()
            let newMsg = Messages(sender: account, contant: messageBody, time: time as NSObject)
            arrMessage.append(newMsg)
            
            db.collection("messages").addDocument(data: ["account":
                                                            account, "message": messageBody, "time": time]) {
                (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Successfully saved data.")
                    self.TextField.text = nil
                }
            }
        }
    
        myTable.reloadData()
        TextField.text?.removeAll()
    }
    
    
    func loadMessages(){
        
        let db = Firestore.firestore()
        
        db.collection("messages").order(by: "time").getDocuments { (querySnapshot,
                                                                    error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let data = querySnapshot?.documents else {return}
                
                for documants in data{
                    let contant = documants.get("message") as! String
                    let sender = documants.get("account") as! String
                    let time = documants.get("time") as? String
                    let newMassege = Messages(sender: sender, contant: contant, time: "\(String(describing: time))" as NSObject)
                    self.arrMessage.append(newMassege)
                    
                }
                self.myTable.reloadData()
                
            }
        }
    }
    
}

extension ChatView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatCell
        
        cell.chatLabel.text = arrMessage[indexPath.row].contant
        cell.time.text = "\(arrMessage[indexPath.row].time)"
        cell.sender.text = arrMessage[indexPath.row].sender
        
        
        
        return cell
    }

    
}
