//
//  HomeVC.swift
//  ChatTest
//
//  Created by Afnan Theb on 12/06/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class HomeVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
        
    var arrUsers : [User] = []
    var selectedUser : User?
    var db = Firestore.firestore()
    
    @IBOutlet weak var usersTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath ) as! UserCell
        cell.nickNameLabel.text = arrUsers[indexPath.row].nickName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = arrUsers[indexPath.row]
        performSegue(withIdentifier: "goToChatRoom", sender: nil)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTable.delegate = self
        usersTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
        readUsers()
        
    }
   
    func readUsers(){
        db.collection("Users").getDocuments { snapshot , error in
            if (error == nil){
                guard let users = snapshot?.documents else { return }
                self.arrUsers.removeAll()
                for user in users {
                    let nickName = user.get("name") as! String
                    let idUser = user.get("id") as! String
                    let emailUser = user.get("email") as! String
                    let user = User(nickName: nickName, email: emailUser , idUser: idUser)
                    self.arrUsers.append(user)
                    
                    
                }
                let currUser = Auth.auth().currentUser
                for (index, user) in self.arrUsers.enumerated(){
                    if ( user.idUser == currUser?.uid){
                        self.arrUsers.remove(at: index)
                    }
                }
                self.usersTable.reloadData()
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    
    
    
    @IBAction func onPressSignout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch let error {
            print(error)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let segueChatRoom = segue.destination as! ChatRoomVC
        // Pass the selected object to the new view controller.
        segueChatRoom.user = selectedUser
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    // Get the new view controller using segue.destination.
//    // Pass the selected object to the new view controller.
//        let segueDetailsVC = segue.destination as! AdDetailsVC
//        segueDetailsVC.ad = selectedAD
}
