//
//  GroceriesViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {
    
    let addGroceriesView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
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
    
    // Title TextField
    let titleTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Title", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Owner TextField
    let ownerTextField:UITextField = {
        let txt = UITextField()
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Title Label
    let addGroceriesViewTitleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Add New Groceries List"
        txt.font = UIFont.boldSystemFont(ofSize: 24)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Title Label
    let titleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Title:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Owner Label
    let ownerLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Owner:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    func constrainaddGroceriesView() {
        addGroceriesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addGroceriesView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addGroceriesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addGroceriesView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        addGroceriesView.addSubview(cancelButton)
        addGroceriesView.addSubview(saveButton)
        constrainSaveButton()
        constrainCancelButton()
        
        addGroceriesView.addSubview(titleTextField)
        constrainTitleTextField()
        addGroceriesView.addSubview(ownerTextField)
        constrainOwnerTextField()
        addGroceriesView.addSubview(addGroceriesViewTitleLabel)
        constrainaddGroceriesViewTitleLabel()
        addGroceriesView.addSubview(ownerLabel)
        addGroceriesView.addSubview(titleLabel)
        constrainOwnerLabel()
        constrainTitleLabel()
    }
    
    func constrainSaveButton() {
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.rightAnchor.constraint(equalTo: addGroceriesView.rightAnchor, constant:-15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: addGroceriesView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector (handleSave), for: .touchUpInside)
    }
    
    
    func constrainCancelButton() {
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor,constant:15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addGroceriesView.bottomAnchor, constant: -10).isActive = true
        cancelButton.addTarget(self, action: #selector (handleCancel), for: .touchUpInside)
    }
    
    
    func constrainTitleTextField() {
        titleTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: addGroceriesView.widthAnchor, multiplier: 1/2).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: addGroceriesView.rightAnchor, constant: -15).isActive = true
        titleTextField.topAnchor.constraint(equalTo: addGroceriesView.topAnchor, constant: 40).isActive = true
    }
    
    func constrainOwnerTextField() {
        ownerTextField.heightAnchor.constraint(equalTo: addGroceriesView.heightAnchor, multiplier: 1/6).isActive = true
        ownerTextField.widthAnchor.constraint(equalTo: addGroceriesView.widthAnchor, multiplier: 1/2).isActive = true
        ownerTextField.rightAnchor.constraint(equalTo: addGroceriesView.rightAnchor, constant: -15).isActive = true
        ownerTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    func constrainaddGroceriesViewTitleLabel() {
        addGroceriesViewTitleLabel.centerXAnchor.constraint(equalTo: addGroceriesView.centerXAnchor).isActive = true
        addGroceriesViewTitleLabel.topAnchor.constraint(equalTo: addGroceriesView.topAnchor, constant: 5).isActive = true
    }
    
    func constrainOwnerLabel() {
        ownerLabel.topAnchor.constraint(equalTo: ownerTextField.topAnchor).isActive = true
        ownerLabel.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor, constant: 20).isActive = true
    }
    
    func addGroceries()  {
        self.view.addSubview(addGroceriesView)
        constrainaddGroceriesView()
    }
    
    func handleCancel() {
        self.addGroceriesView.removeFromSuperview()
    }
    
    func handleSave() {
        print(titleTextField.text!)
        print(ownerTextField.text!)
        self.addGroceriesView.removeFromSuperview()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroceries))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
