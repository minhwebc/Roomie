//
//  ViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
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
        inputContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        inputContainer.addSubview(name)
        setupName()
        inputContainer.addSubview(email)
        setupEmail()
        inputContainer.addSubview(password)
        setupPassword()

        
    }
    
    let name:UITextField = {
        let name = UITextField()
        name.placeholder = "Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    func setupName() {
        name.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        name.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let email:UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    func setupEmail() {
        // email Contraints
        email.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        email.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        email.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        email.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    let password:UITextField = {
        let pass = UITextField()
        pass.placeholder = "Password"
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.isSecureTextEntry = true
        return pass
    }()
    
    func setupPassword() {
        password.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        password.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    let loginButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupLoginButton() {
        loginButton.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func loggedIn() {
        
        //present(HomeViewController(), animated: true, completion: nil)
        let objVC: HomeViewController? = HomeViewController()
        let navController = UINavigationController(rootViewController: objVC!) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.present(navController, animated:true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        // add inputContainer as a subview
        view.addSubview(inputContainer)
        // Do any additional setup after loading the view.
        setupInputContainer()
        view.addSubview(loginButton)
        setupLoginButton()
        loginButton.addTarget(self, action: #selector(loggedIn), for: .touchUpInside)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

