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
    
    // Save Button
    let cancelButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Cancel", for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Cancel Button
    let saveButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Save", for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func constrainAddAmountView(){
        addAmountView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addAmountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addAmountView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        addAmountView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        addAmountView.addSubview(amountTextField)
        addAmountView.addSubview(amountLabel)
        addAmountView.addSubview(cancelButton)
        addAmountView.addSubview(saveButton)
        
        constrainAmountLabel()
        constrainAmountTextView()
        constrainCancelButton()
        constrainSaveButton()
    }
    
    func constrainAmountLabel(){
        amountLabel.heightAnchor.constraint(equalTo: addAmountView.heightAnchor, multiplier: 1/6).isActive = true
        amountLabel.topAnchor.constraint(equalTo: addAmountView.topAnchor, constant: 15).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: addAmountView.leftAnchor, constant: 150).isActive = true
    }
    
    func constrainAmountTextView(){
        amountTextField.heightAnchor.constraint(equalTo: addAmountView.heightAnchor, multiplier: 1/6).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: addAmountView.widthAnchor, multiplier: 1/2).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: addAmountView.leftAnchor, constant: 115).isActive = true
        amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15).isActive = true
    }
    
    func constrainSaveButton() {
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.rightAnchor.constraint(equalTo: addAmountView.rightAnchor, constant:-15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: addAmountView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector (handleSave), for: .touchUpInside)
    }
    
    
    func constrainCancelButton() {
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addAmountView.leftAnchor,constant:15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addAmountView.bottomAnchor, constant: -10).isActive = true
        cancelButton.addTarget(self, action: #selector (handleCancel), for: .touchUpInside)
    }
    
    func handleCancel() {
        self.addAmountView.removeFromSuperview()
        gvc?.refreshTable()
        self.navigationController?.popViewController(animated: true)
    }
    
    var rootRef: DatabaseReference = Database.database().reference()
    let sessionManager = SessionManager()
    var groceryID: String?
    var groceryName: String?
    var creator: String?
    var userID: String?
    var gvc: GroceriesViewController?
    
    func handleSave() {
        let id = groceryID!
        let name = groceryName!
        let userid = userID!
        
        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
        let userRef = groupRef.child("users/\(userid)")
        
        groupRef.child("grocery/\(id)/totalAmount").setValue(amountTextField.text)
        groupRef.child("grocery/\(id)/payID").setValue(userID)
        
        userRef.child("grocery/\(id)/title").setValue(name)
        userRef.child("grocery/\(id)/creator").setValue(creator)
        userRef.child("grocery/\(id)/amount").setValue(amountTextField.text)
        
        self.addAmountView.removeFromSuperview()
        gvc?.refreshTable()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
        self.view.addSubview(addAmountView)
        constrainAddAmountView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
