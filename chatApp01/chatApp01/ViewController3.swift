//
//  ViewController3.swift
//  chatApp01
//
//  Created by Osama folta on 11/06/1443 AH.
//
import FirebaseDatabase
import Firebase
import UIKit

class ViewController3: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    let uid = Auth.auth().currentUser?.uid
    let dbRef = Database.database().reference()
    let dbStore = Firestore.firestore()
    var selectedUserID = String()
    var selectedUserName = String()
    var messages :[Msg] = []
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: false)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readMsgs()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell
        cell.moveRight.constant = 10
        cell.moveLeft.constant = 75
        
        if messages[indexPath.row].sender == uid{
            cell.moveRight.constant = 75
            cell.moveLeft.constant = 10
            cell.logo.isHidden = true
            cell.logo2.isHidden = false
        }
        cell.name.text = "Sender"
        cell.date.text=messages[indexPath.row].time
        cell.msg.text=messages[indexPath.row].message
        
        return cell
    }
    @IBAction func sendPressd(_ sender: UIButton) {
        if textfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
           textfield.text = ""
            return
        }
      let ref = dbRef.child("Messages")
        let msgBody = ["message" : textfield.text!, "sender" :uid!,"time": Date.now.formatted(),"resever":selectedUserID]
        ref.childByAutoId().setValue(msgBody){(error,ref) in
            self.textfield.text = ""
            if(error != nil){
                debugPrint(error!)}
            }
    }
    
    func readMsgs(){
        
        dbRef.child("Messages").observe(.childAdded) { snapshot in
            //realtime
            let result=snapshot.value as! Dictionary<String,String>
            let sender=result["sender"]!
            let msg=result["message"]!
            let time=result["time"]!
            let res=result["resever"]!
           
            let package=Msg(message: msg, sender: sender, resever :res, time: time ,id: snapshot.key)
           
            if (package.resever == self.selectedUserID && package.sender == self.uid) ||
                (package.sender == self.selectedUserID && package.resever == self.uid) {
                self.messages.append(package)
            }
            self.tableView.reloadData()
            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  messages[indexPath.row].sender == Auth.auth().currentUser?.uid else { return }
        if editingStyle == .delete {
            let itemToDelete = messages[indexPath.row].id
            messages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            dbRef.child(selectedUserID).child(itemToDelete).removeValue()
            tableView.reloadData()
        }
    }
}
    
