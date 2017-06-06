//
//  GroceryListViewController.swift
//  Roomie
//
//  Created by Vicky Juan on 6/5/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//


import UIKit
import Firebase

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rootRef: DatabaseReference = Database.database().reference()
    let sessionManager = SessionManager()
    var users: [Dictionary<String,String>] = []
    var groceryID: String?
    var groceryName: String?
    var creator: String?
    var due_on: String?
    var gvc: GroceriesViewController?
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = groceryID!
        let name = groceryName!
        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
        let userRef = groupRef.child("users/\(users[indexPath.row]["id"]!)")
        
//        groupRef.child("grocery/\(id)/assignTo").setValue(users[indexPath.row]["name"]!)
        groupRef.child("grocery/\(id)/assigneeID").setValue(users[indexPath.row]["id"]!)
        
        userRef.child("grocery/\(id)/title").setValue(name)
        userRef.child("grocery/\(id)/creator").setValue(creator)
        userRef.child("grocery/\(id)/due_on").setValue(due_on)
        print("Successfully assign the grocery(id=\(id)) to the user(id=\(users[indexPath.row]["id"]!))!")
        
        //////////////////////////////////////////////
        // better show some alert on user screen!
        
        // back to grocery list
        gvc?.refreshTable()
        self.navigationController?.popViewController(animated: true)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RoommateTableViewCell(style: .subtitle, reuseIdentifier: "groceryCell")
        cell.textLabel?.text = users[indexPath.row]["name"]
        cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: users[indexPath.row]["profileURL"]!)
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
                let dict = ["id": key, "name": value["name"], "profileURL": "\(value["profileImageURL"] ?? "")"]
                self.users.append(dict as! [String : String])
            }
            self.userTableView.reloadData()
        })
    }
    
}

import Foundation
