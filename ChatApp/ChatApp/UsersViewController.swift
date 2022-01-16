//
//  UsersViewController.swift
//  ChatApp
//
//  Created by Nada Alansari on 11/06/1443 AH.
//

import UIKit
import Firebase
class UsersViewController: UIViewController {
    var userArray = [Users]()
    var selectedId = ""
    @IBOutlet weak var usersCollection: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_msg"
        {
            let msgVC = segue.destination as! ViewController
            msgVC.reciverId = selectedId
        
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        fetchUsers()
//        self.navigationItem.hidesBackButton = true
        usersCollection.delegate = self
        usersCollection.dataSource = self
    }
    func fetchUsers(){
        let msgDB = Database.database().reference().child("user")
        msgDB.observe(.childAdded) { (snapShot) in
            let value = snapShot.value as! Dictionary<String,String>
            let email = value["email"]!
            let id = value["id"]!
            let name = value["name"]!
            print("name\(name)")
            let userobj = Users(name: name, id: id)
            self.userArray.append(userobj)
            self.usersCollection.reloadData()

        }


    }

}

extension UsersViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_S", for: indexPath as IndexPath) as! UsersCollectionViewCell
        cell.layer.cornerRadius = 12;
        cell.userName.text = userArray[indexPath.row].name
        return cell
        print("user name \(userArray[indexPath.row].name)")
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedId = userArray[indexPath.row].id
        print("selected id")
        print(userArray[indexPath.row].id)
        performSegue(withIdentifier: "show_msg", sender: self)

    }
    
    
    
}
