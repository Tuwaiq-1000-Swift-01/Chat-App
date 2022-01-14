//
import UIKit
import Firebase
import FirebaseFirestore


class  ContactVC: UITableViewController {
    
    var users = [UserSignUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SingOut", style: .done, target: self, action: #selector(singOutTpd))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        getUsers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.backgroundColor = .lightGray
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatVC()
        vc.user = users[indexPath.row]
       navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func singOutTpd() {
        let out = Auth.auth()
        do {
            try out.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    func getUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { snapshot, error in
            if error == nil {
                self.users.removeAll()
                guard let userID = Auth.auth().currentUser?.uid else {return}
                
                for document in snapshot!.documents{
                    let data = document.data()

                    if data["id"] as? String != userID {
                        self.users.append(UserSignUp(name: data["name"] as? String, email: data["email"] as? String, id: data["id"] as? String))
                    }
                    self.tableView.reloadData()
                }

            } else {
                print(error?.localizedDescription)
            }
        }
    }
}


   
