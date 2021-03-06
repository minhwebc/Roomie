//
//  HomeViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //////////////////////////////////////////
    /////////////////////////
    ////// Defining the blocks on the home screen
    
    let ButtonsContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let choreButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        return button
    }()
    
    let billButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 238/255.0, green:163/255.0 , blue: 163/255.0 ,alpha:1)
        return button
    }()
    
    let roommateButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 242/255.0, green:206/255.0 , blue: 176/255.0 ,alpha:1)
        return button
    }()
    
    let groceriesButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
        return button
    }()
    
    let remindersButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 141/255.0, green:172/255.0 , blue: 154/255.0 ,alpha:1)
        return button
    }()
    
    let profileButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(red: 45/255.0, green:35/255.0 , blue: 53/255.0 ,alpha:1)
        return button
    }()
    
    //////////////////////////////////////////
    /////////////////////////
    ////// Constraining and adding action to the blocks on the home screen
    
    func setupButtonsContainer() {
        // contraint Buttons Container
        ButtonsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ButtonsContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ButtonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ButtonsContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        // adding the buttons as subviews
        ButtonsContainer.addSubview(choreButton)
        ButtonsContainer.addSubview(billButton)
        ButtonsContainer.addSubview(roommateButton)
        ButtonsContainer.addSubview(groceriesButton)
        ButtonsContainer.addSubview(profileButton)
        ButtonsContainer.addSubview(remindersButton)
        
        // calling constrain methods for buttons
        setupRemindersButton()
        setupProfileButton()
        setupGroceriesButton()
        setupRoommateButton()
        setupChoreButton()
        setupBillButton()
    }
    
    // constrain chore button
    func setupChoreButton() {
        choreButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        choreButton.topAnchor.constraint(equalTo: ButtonsContainer.topAnchor).isActive = true
        choreButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        choreButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        choreButton.addTarget(self, action: #selector(choreButtonClicked), for: .touchUpInside)
        btnProperties(btn: choreButton, name: "CHORES")
    }
    
    func choreButtonClicked() {
        self.navigationController?.pushViewController(ChoresViewController(), animated: true)
    }
    
    // constrain bill button
    func setupBillButton() {
        billButton.leftAnchor.constraint(equalTo: choreButton.rightAnchor).isActive = true
        billButton.topAnchor.constraint(equalTo: ButtonsContainer.topAnchor).isActive = true
        billButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        billButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        billButton.addTarget(self, action: #selector(billButtonClicked), for: .touchUpInside)
        btnProperties(btn: billButton, name: "BILLS")
    }
    
    func billButtonClicked() {
        self.navigationController?.pushViewController(BillsViewController(), animated: true)
    }
    
    // constrain roommate button
    func setupRoommateButton() {
        roommateButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        roommateButton.topAnchor.constraint(equalTo: choreButton.bottomAnchor).isActive = true
        roommateButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        roommateButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        roommateButton.addTarget(self, action: #selector(roommateButtonClicked), for: .touchUpInside)
        btnProperties(btn: roommateButton, name: "GROUP")
    }
    
    func roommateButtonClicked() {
        self.navigationController?.pushViewController(RoommateViewController(), animated: true)
    }
    
    // constrain groceries button
    func setupGroceriesButton() {
        groceriesButton.leftAnchor.constraint(equalTo: roommateButton.rightAnchor).isActive = true
        groceriesButton.topAnchor.constraint(equalTo: billButton.bottomAnchor).isActive = true
        groceriesButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        groceriesButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        groceriesButton.addTarget(self, action: #selector(groceriesButtonClicked), for: .touchUpInside)
        btnProperties(btn: groceriesButton, name: "GROCERIES")
    }
    
    func groceriesButtonClicked()  {
        self.navigationController?.pushViewController(GroceriesViewController(), animated: true)
    }
    
    // constrain black button
    func setupRemindersButton() {
        remindersButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        remindersButton.topAnchor.constraint(equalTo: roommateButton.bottomAnchor).isActive = true
        remindersButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        remindersButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        remindersButton.addTarget(self, action: #selector(remindersButtonClicked), for: .touchUpInside)
        btnProperties(btn: remindersButton, name: "REMINDERS")
    }
    
    func remindersButtonClicked() {
        self.navigationController?.pushViewController(RemindersViewController(), animated: true)
    }
    
    // constrain profile button
    func setupProfileButton() {
        profileButton.rightAnchor.constraint(equalTo: ButtonsContainer.rightAnchor).isActive = true
        profileButton.topAnchor.constraint(equalTo: groceriesButton.bottomAnchor).isActive = true
        profileButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        profileButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
        profileButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        btnProperties(btn: profileButton, name: "PROFILE")
    }
    
    func profileButtonClicked() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    
    // LOGOUT FUNCTION
    func handleLogout() {
        SessionManager().userLoggedOut();
        present(LoginViewController(), animated: true, completion: nil)
    }
    
    func btnProperties(btn:UIButton,name:String) {
        btn.setTitle(name, for: .normal)
        btn.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //////////////
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
        view.backgroundColor = UIColor.blue
        view.addSubview(ButtonsContainer)
        setupButtonsContainer()
        // Do any additional setup after loading the view.
    }

    
}
