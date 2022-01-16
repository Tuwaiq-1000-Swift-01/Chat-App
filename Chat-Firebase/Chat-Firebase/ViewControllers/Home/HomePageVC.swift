//
//  HomePageVC.swift
//  Chat-Firebase
//
//  Created by Aisha Ali on 1/15/22.
//

import UIKit
import Firebase
import FirebaseFirestore


private let reuseIdentifier = String(describing: Users.self)



class HomePageVC: UITableViewController {
  static let shared = HomePageVC()
  var reciver = ""
  
  @IBOutlet weak var search: UISearchBar!
  
  var users: [User] = []
  var tempUsers: [User] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    getUsers()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return users.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! Users
    
    cell.userNameLabel.text = users[indexPath.row].name
    
    
    
    
    // Configure the cell...
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let myID = Auth.auth().currentUser?.uid
    
    reciver = users[indexPath.row].idUser!
    print("\n\n\n\(reciver)\n\n\n\n\n\n\n\n")
    print("\n\n\(myID!)\n\n\n\n\n\n\n\n")
    
    performSegue(withIdentifier: "showContent", sender: nil)
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationVC = segue.destination as? ChattingRoom {
      destinationVC.reciver = reciver
      
      
    }
  }
  
  
  
  
  //MARK: - Fetch users from data base
  func getUsers(){
    
    let db = Firestore.firestore()
    //    let userID = Auth.auth().currentUser?.uid
    db.collection("Users").getDocuments { Snapshot, error in
      if error != nil {
        print(error!)
        
      }else{
        self.users.removeAll()

        let data = Snapshot!.documents
        //        guard let data = Snapshot?.documents else {return}
        for document in data {
          
          let name = document.get("User Name") as! String
          let family = document.get("Family Name") as! String
          let userID = document.get("ID") as! String
          
          
          let user = User(name: name, familyName: family, email: "", idUser: userID)
          self.users.append(user)
        }
        self.tableView.reloadData()
        
        
      }
    }
  }
}









extension HomePageVC: UISearchBarDelegate{
  
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    users = []
    if searchText == "" {
      users = tempUsers
    }
    else{
      for user in tempUsers{
        if user.name!.lowercased().contains(searchText.lowercased()){
          users.append(user)
        }
      }
    }
    self.tableView.reloadData()
  }
}
