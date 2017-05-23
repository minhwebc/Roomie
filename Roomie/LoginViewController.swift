//
//  ViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginSignup:UISegmentedControl = {
        let items = ["Login", "Register"]
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 0
        //seg.backgroundColor = UIColor.blue
        seg.tintColor = UIColor.white
        seg.layer.cornerRadius = 10
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    func setupSegmentedControl() {
        loginSignup.addTarget(self, action: #selector (handleLoginRegisterChange), for: .valueChanged)
        loginSignup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSignup.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -12).isActive = true
        loginSignup.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginSignup.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func handleLoginRegisterChange()  {
        let title = loginSignup.titleForSegment(at: loginSignup.selectedSegmentIndex)
        loginButton.setTitle(title, for: .normal)
    }
    
    let inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        //self.userEmailTextField.layer.mask = rectShape
        //self.userEmailTextField.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    func setupInputContainer() {
        // contraint inputContainer
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        inputContainer.addSubview(name)
        setupName()
        inputContainer.addSubview(email)
        setupEmail()
        inputContainer.addSubview(password)
        setupPassword()
        inputContainer.addSubview(nameSeparator)
        setupNameSeparator()
        inputContainer.addSubview(emailSeparator)
        setupEmailSeparator()
    }
    
    let name:UITextField = {
        let name = UITextField()
        name.attributedPlaceholder = NSAttributedString(string:"Full Name", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        name.tintColor = .white
        name.textColor = UIColor.white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    func setupName() {
        name.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        name.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    let nameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupNameSeparator() {
        nameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
   
    let groupName:UITextField = {
        let groupName = UITextField()
        groupName.attributedPlaceholder = NSAttributedString(string:"Group Name", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        groupName.tintColor = .white
        groupName.textColor = UIColor.white
        groupName.translatesAutoresizingMaskIntoConstraints = false
        return groupName
    }()
    
    func setupGroupName() {
        groupName.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        groupName.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        groupName.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupName.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    let groupNameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupGroupNameSeparator() {
        groupNameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        groupNameSeparator.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        groupNameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupNameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    

    
    let email:UITextField = {
        let email = UITextField()
       // email.placeholder = "Email"
        email.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        email.tintColor = .white
        email.textColor = .white
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    func setupEmail() {
        // email Contraints
        email.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        email.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        email.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        email.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        
    }
    
    let emailSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupEmailSeparator() {
        emailSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    let password:UITextField = {
        let pass = UITextField()
        pass.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        pass.tintColor = .white
        pass.textColor = .white
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.isSecureTextEntry = true
        return pass
    }()
    
    func setupPassword() {
        password.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
    }
    
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
    
    func setupLoginButton() {
        loginButton.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func loggedIn() {
        
        let objVC: HomeViewController? = HomeViewController()
        let navController = UINavigationController(rootViewController: objVC!) // Creating a navigation controller with VC1 at the root of the navigation stack.
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

