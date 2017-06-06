//
//  GroceryListViewController.swift
//  Roomie
//
//  Created by Vicky Juan on 6/5/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//


import UIKit
import Firebase

class GroceryListViewController: UIViewController {
    
    var rootRef: DatabaseReference = Database.database().reference()
    let sessionManager = SessionManager()
    var users: [Dictionary<String,String>] = []
    var groceryID: String?
    var groceryName: String?
    var creator: String?
    var due_on: String?
    var gvc: GroceriesViewController?
    
    
    let addAmountView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    // amount lable
    let amountLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Item amount:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // amount enter TextField
    let amountTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:" Enter a amount in USD", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    func constrainAddAmountView(){
        addAmountView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addAmountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addAmountView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addAmountView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        addAmountView.addSubview(amountTextField)
        addAmountView.addSubview(amountLabel)
        
        constrainAmountLabel()
        constrainAddAmountView()
        
    }
    
    func constrainAmountLabel(){
        amountLabel.heightAnchor.constraint(equalTo: addAmountView.heightAnchor, multiplier: 1/6).isActive = true
        amountLabel.topAnchor.constraint(equalTo: addAmountView.topAnchor, constant: 15).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: addAmountView.leftAnchor, constant: 5).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: addAmountView.rightAnchor, constant: 5).isActive = true
        
    }
    
    func constrainAmountTextView(){
        amountTextField.heightAnchor.constraint(equalTo: addAmountView.heightAnchor, multiplier: 1/6).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: addAmountView.widthAnchor, multiplier: 1/2).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: addAmountView.leftAnchor, constant: 5).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: addAmountView.rightAnchor, constant: 5).isActive = true
        amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5).isActive = true
    }

//    func addAmount()  {
//        self.view.addSubview(addAmountView)
//        constrainAddAmountView()
//    }

//        let id = groceryID!
//        let name = groceryName!
//        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
//        let userRef = groupRef.child("users/\(users[indexPath.row]["id"]!)")
    
//        ////////////////////check this later
//        groupRef.child("grocery/\(id)/totalAmount").setValue(users[indexPath.row]["name"]!)
//        groupRef.child("grocery/\(id)/payID").setValue(users[indexPath.row]["id"]!)
//        
//        userRef.child("grocery/\(id)/title").setValue(name)
//        userRef.child("grocery/\(id)/creator").setValue(creator)
//        userRef.child("grocery/\(id)/due_on").setValue(due_on)
//        print("Successfully assign the grocery(id=\(id)) to the user(id=\(users[indexPath.row]["id"]!))!")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
