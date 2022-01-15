//
//  ViewController2.swift
//  chatApp01
//
//  Created by Osama folta on 11/06/1443 AH.
//
import Firebase
import UIKit

class ViewController2: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var user:[User] = []
    var room = String()
    var selectedName = String()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if Auth.auth().currentUser?.uid == user[indexPath.row].userID{
            user[indexPath.row].name = "myChanel"
        }
        cell.textLabel?.text = user[indexPath.row].name
        cell.detailTextLabel?.text =  user[indexPath.row].userID
        return cell
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        navigationItem.hidesBackButton = true
    }
    
    
    func fetchData(){
        let dbStore = Firestore.firestore()
        dbStore.collection("Users").getDocuments { snapshot, error in
            if error != nil {print("An error occurred while downloading \(error!.localizedDescription)")}
            guard let data = snapshot?.documents else { return }
            for info in data{
                self.user.append(User(name: info.get("username") as! String,userID: info.get("userID") as! String))
            }
            self.tableview.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         room = user[indexPath.row].userID
        selectedName = user[indexPath.row].name
       performSegue(withIdentifier: "move2", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let show = segue.destination as! ViewController3
        show.selectedUserID = room
        show.selectedUserName = selectedName
    }
}
