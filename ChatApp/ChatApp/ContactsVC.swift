//
//  ContactsVC.swift
//  ChatApp
//
//  Created by Maram Al shahrani on 12/06/1443 AH.
//

import UIKit
import Firebase


class ContactsVC: UIViewController {
    
    let cellId = "Cell"
    var people: [User] = []
    
    lazy var peopleTV: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersService.shared.listenToUsers { newUsers in
            self.people = newUsers
            self.peopleTV.reloadData()
        }
        
        
        view.addSubview(peopleTV)
        NSLayoutConstraint.activate([
            peopleTV.topAnchor.constraint(equalTo: view.topAnchor),
            peopleTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            peopleTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            peopleTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let user = people[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.status
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = people[indexPath.row]
        let messagingVC = DirectMessageVC()
        messagingVC.user = user
        messagingVC.title = user.name
        
        
        
        messagingVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(messagingVC,animated: true)
        
    }
    
}

