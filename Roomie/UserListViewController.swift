//
//  UserListViewController.swift
//  Roomie
//
//  Created by iGuest on 5/29/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rootRef: DatabaseReference = Database.database().reference()
    let sessionManager = SessionManager()
    var users: [Dictionary<String,String>] = []
    var choreID: String?
    var choreName: String?
    var creator: String?
    var due_on: String?
    var vc: ChoresViewController?
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = choreID!
        let name = choreName!
        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
        let userRef = groupRef.child("users/\(users[indexPath.row]["id"]!)")
        
        groupRef.child("chores/\(id)/assignTo").setValue(users[indexPath.row]["name"]!)
        
        userRef.child("chores/\(id)/title").setValue(name)
        userRef.child("chores/\(id)/creator").setValue(creator)
        userRef.child("chores/\(id)/due_on").setValue(due_on)
        print("Successfully assign the chore(id=\(id)) to the user(id=\(users[indexPath.row]["id"]!))!")
        
        //////////////////////////////////////////////
        // better show some alert on user screen!
        
        
        // back to chores list
        vc?.refreshTable()
        self.navigationController?.popViewController(animated: true)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "choreCell")
        cell.textLabel?.text = users[indexPath.row]["name"]
        return cell
    }
    
    let userTableView:UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
        
        userTableView.dataSource = self
        userTableView.delegate = self
        
        view.addSubview(userTableView)
        constrainUserTableView()
        self.userTableView.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        self.userTableView.tableFooterView = UIView()
        view.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
    }

    func constrainUserTableView()  {
        userTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        userTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func getAllUsers() {
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users").observeSingleEvent(of: .value, with: { (snap) in
            let values = snap.value as! NSDictionary
            for key in values.allKeys{
                let value = values[key] as! NSDictionary
                let dict = ["id": key, "name": value["name"]]
                self.users.append(dict as! [String : String])
            }
            self.userTableView.reloadData()
        })
    }

}
