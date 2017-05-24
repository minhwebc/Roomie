//
//  ViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    ///////////////////
    //////
    /// Defining elements in the login screen
    
    let inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let loginSignup:UISegmentedControl = {
        let items = ["Login", "Register"]
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 0
        seg.tintColor = UIColor.white
        seg.layer.cornerRadius = 10
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    let name:UITextField = {
        let name = UITextField()
        name.attributedPlaceholder = NSAttributedString(string:"Full Name", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        name.tintColor = .white
        name.textColor = UIColor.white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let nameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let groupName:UITextField = {
        let groupName = UITextField()
        groupName.attributedPlaceholder = NSAttributedString(string:"Group Name", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        groupName.tintColor = .white
        groupName.textColor = UIColor.white
        groupName.translatesAutoresizingMaskIntoConstraints = false
        return groupName
    }()
    
    let groupNameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let email:UITextField = {
        let email = UITextField()
        // email.placeholder = "Email"
        email.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        email.tintColor = .white
        email.textColor = .white
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let emailSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let password:UITextField = {
        let pass = UITextField()
        pass.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        pass.tintColor = .white
        pass.textColor = .white
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.isSecureTextEntry = true
        return pass
    }()
    
    let loginButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    ///////////////////
    //////
    /// Constraining elements in the login screen
    
    func setupSegmentedControl() {
        loginSignup.addTarget(self, action: #selector (handleLoginRegisterChange), for: .valueChanged)
        loginSignup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSignup.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -12).isActive = true
        loginSignup.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginSignup.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupInputContainer() {
        // contraint inputContainer
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // added elements to the input box
        inputContainer.addSubview(name)
        inputContainer.addSubview(groupName)
        inputContainer.addSubview(email)
        inputContainer.addSubview(password)
        inputContainer.addSubview(nameSeparator)
        inputContainer.addSubview(groupNameSeparator)
        inputContainer.addSubview(emailSeparator)
        
        // functions to add constraints to elements in the input box
        setupName()
        setupGroupName()
        setupEmail()
        setupPassword()
        setupNameSeparator()
        setupGroupNameSeparator()
        setupEmailSeparator()
    }
    
    func setupName() {
        name.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        name.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    
    
    func setupNameSeparator() {
        nameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    
    func setupGroupName() {
        groupName.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        groupName.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        groupName.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupName.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    
    
    func setupGroupNameSeparator() {
        groupNameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        groupNameSeparator.topAnchor.constraint(equalTo: groupName.bottomAnchor).isActive = true
        groupNameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupNameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    
    
    func setupEmail() {
        // email Contraints
        email.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        email.topAnchor.constraint(equalTo: groupName.bottomAnchor).isActive = true
        email.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        email.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        
    }
    
    
    
    func setupEmailSeparator() {
        emailSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    
    
    func setupPassword() {
        password.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func setupLoginButton() {
        loginButton.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    ///////////////////
    //////
    /// Functions to handle button clicks and segmented control .valueChanged
    /// Also includes function to add properties to the textFields
    
    func handleLoginRegisterChange()  {
        let title = loginSignup.titleForSegment(at: loginSignup.selectedSegmentIndex)
        loginButton.setTitle(title, for: .normal)
    }
    
    func loggedIn() {
        let objVC: HomeViewController? = HomeViewController()
        let navController = UINavigationController(rootViewController: objVC!)
        self.present(navController, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.jpg")!)
        
        // add inputContainer as a subview
        view.addSubview(inputContainer)
        // Do any additional setup after loading the view.
        setupInputContainer()
        view.addSubview(loginButton)
        view.addSubview(loginSignup)
        setupSegmentedControl()
        setupLoginButton()
        loginButton.addTarget(self, action: #selector(loggedIn), for: .touchUpInside)
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

