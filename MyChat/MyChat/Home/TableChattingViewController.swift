//
//  TableChattingViewController.swift
//  MyChat
//
//  Created by Anas Hamad on 11/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableChattingViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    
    var rooms : [Rooms] = []
    var ref : DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        getRooms()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

  
    func getRooms(){
        
        let db = Firestore.firestore()
        let docRef = db.collection("Rooms").document("6G6UyEMgQaoKrtj8fGLl")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let new = Rooms(owner:dataDescription )
                self.rooms.append(new)
                self.myTableView.reloadData()
                print("owner: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
  
        
   }
    @IBAction func addRoom(_ sender: Any) {
        
        let db = Firestore.firestore()
        let random = Int.random(in: 33...9999)
        db.collection("Rooms").document().setData(["owner" : "Room\(random)"])
        let owner = Auth.auth().currentUser?.email ?? ""
        let newRoom = Rooms(owner: owner)
        rooms.append(newRoom)
        myTableView.reloadData()
   
}
}

extension TableChattingViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CattingCell
        
        cell.chatLabel.text = rooms[indexPath.row].owner
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

 performSegue(withIdentifier: "Chat", sender: self)
    }
}


// func getUsers(dict: [String: Any]) -> Messages {
//
//
//
//     .massage = dict["message"] as? String
//    user.email = dict["email"] as? String
//
//
//    return user
//}
