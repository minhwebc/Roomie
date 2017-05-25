//
//  ViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class LoginViewController: UIViewController {
    
    // height anchors for the defined here so 
    // that we can hide and unhide name
    var nameTextFieldHeightAnchor : NSLayoutConstraint?
    var inputContainerHeightAnchor : NSLayoutConstraint?
    var emailTextFieldHeightAnchor : NSLayoutConstraint?
    var passwordTextFieldHeightAnchor : NSLayoutConstraint?
    var groupNameTextFieldHeightAnchor : NSLayoutConstraint?
    var logInAction : Bool = false;
    var ref: DatabaseReference!
    var sessionManager : SessionManager = SessionManager();
    

    
    ///////////////////
    //////
    /// Defining elements in the login screen
    
    // This is a view that contains the name,email,password,
    // and Groupname textFields
    let inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    // This is the login/register button
    let loginSignup:UISegmentedControl = {
        let items = ["Login", "Register"]
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 0
        seg.tintColor = UIColor.white
        seg.layer.cornerRadius = 10
        seg.selectedSegmentIndex = 1
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    // Name TextField
    let name:UITextField = {
        let name = UITextField()
        return name
    }()
    
    // This is the line below the Name TextField
    let nameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // This is the groupName textField
    let groupName:UITextField = {
        let groupName = UITextField()
        return groupName
    }()
    
    // This is the line below the groupName TextField
    let groupNameSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Email TextField
    let email:UITextField = {
        let email = UITextField()
        return email
    }()
    
    // This is the line below the email TextField
    let emailSeparator:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // This is the password textField
    let password:UITextField = {
        let pass = UITextField()
        pass.isSecureTextEntry = true
        return pass
    }()
    
    // This is the login/register button
    let loginButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    ///////////////////
    //////
    /// Constraining elements in the login screen
    
    // constraints for the segmented control
    func setupSegmentedControl() {
        loginSignup.addTarget(self, action: #selector (handleLoginRegisterChange), for: .valueChanged)
        loginSignup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSignup.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -12).isActive = true
        loginSignup.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginSignup.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    // constraints for the view that contains the textfields
    // also adding the textfields as subviews
    func setupInputContainer() {
        // contraint inputContainer
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerHeightAnchor = inputContainer.heightAnchor.constraint(equalToConstant: 200)
        inputContainerHeightAnchor?.isActive = true
        
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
    
    // constraints for the Name textfield
    func setupName() {
        name.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        name.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = name.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4)
        nameTextFieldHeightAnchor?.isActive = true
        
        addPropertiesToTextFields(txtField: name, placeholder: "Name")
    }
    
    
    // constraints for the line below the Name textfield
    func setupNameSeparator() {
        nameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // constraints for the GroupName textfield
    func setupGroupName() {
        groupName.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        groupName.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        groupName.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupNameTextFieldHeightAnchor = groupName.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4)
        groupNameTextFieldHeightAnchor?.isActive = true
        addPropertiesToTextFields(txtField: groupName, placeholder: "Group Name")
    }
    
    
    // constraints for the line below the groupName textfield
    func setupGroupNameSeparator() {
        groupNameSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        groupNameSeparator.topAnchor.constraint(equalTo: groupName.bottomAnchor).isActive = true
        groupNameSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        groupNameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // constraints for the Email textfield
    func setupEmail() {
        email.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        email.topAnchor.constraint(equalTo: groupName.bottomAnchor).isActive = true
        email.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = email.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        addPropertiesToTextFields(txtField: email, placeholder: "Email")
        
    }
    
    // constraints for the line below the email textfield
    func setupEmailSeparator() {
        emailSeparator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // constraints for the password textField
    func setupPassword() {
        password.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        password.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = password.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
        addPropertiesToTextFields(txtField: password, placeholder: "Password")
    }
    
    // constraints for the login/register button
    func setupLoginButton() {
        loginButton.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.addTarget(self, action: #selector(loggedIn), for: .touchUpInside)
    }
    
    ///////////////////
    //////
    /// Functions to handle button clicks and segmented control .valueChanged
    /// Also includes function to add properties to the textFields
    
    // Function to know wheather the user is going to 
    // login or register according to the segmented control
    // and also to adjust the textFields to hide the nameTextField
    func handleLoginRegisterChange()  {
        logInAction = true;
        //changing the title of the login/register button
        let title = loginSignup.titleForSegment(at: loginSignup.selectedSegmentIndex)
        loginButton.setTitle(title, for: .normal)
        
        // adjusting the height of the inputsContainer 
        // to eliminate the nameTextField
        inputContainerHeightAnchor?.constant = loginSignup.selectedSegmentIndex == 0 ? 150 : 200
        
        // hidding the nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = name.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: loginSignup.selectedSegmentIndex == 0 ? 0 : 1/4)
        name.isHidden = loginSignup.selectedSegmentIndex == 0 ? true : false
        nameSeparator.isHidden = loginSignup.selectedSegmentIndex == 0 ? true : false
        nameTextFieldHeightAnchor?.isActive = true
        
        // adjusting the height of the of the groupNameTextField
        groupNameTextFieldHeightAnchor?.isActive = false
        groupNameTextFieldHeightAnchor = groupName.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: loginSignup.selectedSegmentIndex == 0 ? 1/3 : 1/4)
        groupNameTextFieldHeightAnchor?.isActive = true
        
        // adjusting the height of the of the emailTextField
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = email.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: loginSignup.selectedSegmentIndex == 0 ? 1/3 : 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        
        // adjusting the height of the of the passwordTextField
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = password.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: loginSignup.selectedSegmentIndex == 0 ? 1/3 : 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    // Function for when login/register button is clicked
    func loggedIn() {
        // authentication need to happen here 
        
        // push to the home screen after login or registration
        // has been authenticated
        
        if(!logInAction){ //check if this is log in or register
            let groupName = self.groupName.text!;

            ref.child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.hasChild(groupName){
                    
                    print("group exist")
                }else{
                    print("false room doesn't exist")
                    let usersRef = self.ref.child("groups/\(groupName)/users");
                    let key : String = usersRef.childByAutoId().key;
                    let userRef = self.ref.child("groups/\(groupName)/users/\(key)");
                    let user = ["name": self.name.text!,
                                "email": self.email.text!,
                                "password": self.password.text!]
                    userRef.updateChildValues(user);
                    self.sessionManager.insertUserDetails(groupName, self.name.text!, self.email.text!, key)
                    self.sessionManager.userLoggedIn()
                    let objVC: HomeViewController? = HomeViewController()
                    let navController = UINavigationController(rootViewController: objVC!)
                    self.present(navController, animated:true, completion: nil)
                }
            })
        }else{
            let groupName = self.groupName.text!;
            
            ref.child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.hasChild(groupName){
                    
                    print("group exist")
                    let groupRef = self.ref.child("groups/\(groupName)")
                    
                    groupRef.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        for rest in snapshot.children.allObjects as! [DataSnapshot] {
                            
                            guard let restDict = rest.value as? [String: Any] else { continue }
                            let email = restDict["email"] as? String
                            if(email == self.email.text!){
                               let password = restDict["password"] as? String
                                if(password == self.password.text!){
                                    self.sessionManager.insertUserDetails(groupName, self.name.text!, self.email.text!, rest.key)
                                    self.sessionManager.userLoggedIn()
                                    let objVC: HomeViewController? = HomeViewController()
                                    let navController = UINavigationController(rootViewController: objVC!)
                                    self.present(navController, animated:true, completion: nil)
                                }else{
                                    print("wrong password");
                                }
                            }else{
                                print("wrong email");
                            }
                        }
                    })
                }else{
                    print("false room doesn't exist")
                }
            })
            
        }
    }
    
    // Function to add properties to uiTextFields
    func addPropertiesToTextFields(txtField:UITextField,placeholder:String) {
        txtField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txtField.tintColor = .white
        txtField.textColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    ///////////////////
    //////
    /// ViewDidLoad, where we call all the major functions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.jpg")!)
        // Add segmented control, view containing textfields
        // and login/register button to the main view
        view.addSubview(inputContainer)
        view.addSubview(loginButton)
        view.addSubview(loginSignup)
        

        // Constraint functions for th respective elements
        setupInputContainer()
        setupSegmentedControl()
        setupLoginButton()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

