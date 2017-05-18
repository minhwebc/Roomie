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
    ////// SET UP THE BUTTONS TO CLICK AND GO TO OTHER VIEWS
    let ButtonsContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    func setupButtonsContainer() {
        // contraint inputContainer
        ButtonsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ButtonsContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ButtonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ButtonsContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

    }

    
    let choreButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("Chores", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupChoreButton() {
        choreButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        choreButton.topAnchor.constraint(equalTo: ButtonsContainer.topAnchor).isActive = true
        choreButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        choreButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let billButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Bills", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupBillButton() {
        billButton.leftAnchor.constraint(equalTo: choreButton.rightAnchor).isActive = true
        billButton.topAnchor.constraint(equalTo: ButtonsContainer.topAnchor).isActive = true
        billButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        billButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let roommateButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.gray
        button.setTitle("Roommate", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupRoommateButton() {
        roommateButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        roommateButton.topAnchor.constraint(equalTo: choreButton.bottomAnchor).isActive = true
        roommateButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        roommateButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let groceriesButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitle("Groceries", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupGroceriesButton() {
        groceriesButton.leftAnchor.constraint(equalTo: roommateButton.rightAnchor).isActive = true
        groceriesButton.topAnchor.constraint(equalTo: billButton.bottomAnchor).isActive = true
        groceriesButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        groceriesButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let profileButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("Profile", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupProfileButton() {
        profileButton.rightAnchor.constraint(equalTo: ButtonsContainer.rightAnchor).isActive = true
        profileButton.topAnchor.constraint(equalTo: groceriesButton.bottomAnchor).isActive = true
        profileButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        profileButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }

    let blankButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.cyan
        button.setTitle("Profile", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupBlankButton() {
        blankButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        blankButton.topAnchor.constraint(equalTo: roommateButton.bottomAnchor).isActive = true
        blankButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        blankButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    ////// 
    // LOGOUT FUNCTION
    func handleLogout() {
        present(LoginViewController(), animated: true, completion: nil)
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
        ButtonsContainer.addSubview(choreButton)
        ButtonsContainer.addSubview(billButton)
        ButtonsContainer.addSubview(roommateButton)
        ButtonsContainer.addSubview(groceriesButton)
        ButtonsContainer.addSubview(profileButton)
        ButtonsContainer.addSubview(blankButton)
        setupBlankButton()
        setupProfileButton()
        setupGroceriesButton()
        setupRoommateButton()
        setupChoreButton()
        setupBillButton()
        // Do any additional setup after loading the view.
    }

    
}
