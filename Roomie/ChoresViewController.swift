//
//  ChoresViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class ChoresViewController: UIViewController {
    
    let addChoreView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
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
    
    // Description TextView
    let descTextField:UITextView = {
        let txt = UITextView()
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let addChoreViewTitleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Add New Chore"
        txt.font = UIFont.boldSystemFont(ofSize: 24)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let titleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Title:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let descLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Desc:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let dueDateLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Due Date:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let dueDatePicker:UIDatePicker = {
        let due = UIDatePicker()
        due.timeZone = NSTimeZone.local
        due.backgroundColor = UIColor.clear
        due.tintColor = UIColor.black
        due.datePickerMode = .date
        
        
        due.translatesAutoresizingMaskIntoConstraints = false
        return due
    }()
    
    
    func constrainAddChoreView() {
        addChoreView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addChoreView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addChoreView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addChoreView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        addChoreView.addSubview(cancelButton)
        addChoreView.addSubview(saveButton)
        constrainSaveButton()
        constrainCancelButton()
        
        // to be added
        addChoreView.addSubview(titleTextField)
        constrainTitleTextField()
        addChoreView.addSubview(descTextField)
        constrainDescTextField()
        addChoreView.addSubview(addChoreViewTitleLabel)
        constrainAddChoreViewTitleLabel()
        addChoreView.addSubview(titleLabel)
        addChoreView.addSubview(descLabel)
        addChoreView.addSubview(dueDatePicker)
        addChoreView.addSubview(dueDateLabel)
        constrainDueDateLabel()
        constrainDescLabel()
        constrainTitleLabel()
        constrainDueDatePicker()
    }
    
    func constrainSaveButton() {
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.rightAnchor.constraint(equalTo: addChoreView.rightAnchor, constant:-15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: addChoreView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector (handleSave), for: .touchUpInside)
    }
    
    
    func constrainCancelButton() {
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addChoreView.leftAnchor,constant:15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addChoreView.bottomAnchor, constant: -10).isActive = true
        cancelButton.addTarget(self, action: #selector (handleCancel), for: .touchUpInside)
    }
    
    func constrainTitleTextField() {
        titleTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: addChoreView.widthAnchor, multiplier: 1/2).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: addChoreView.rightAnchor, constant: -15).isActive = true
        titleTextField.topAnchor.constraint(equalTo: addChoreView.topAnchor, constant: 40).isActive = true
    }
    
    func constrainDescTextField() {
        descTextField.heightAnchor.constraint(equalTo: addChoreView.heightAnchor, multiplier: 1/6).isActive = true
        descTextField.widthAnchor.constraint(equalTo: addChoreView.widthAnchor, multiplier: 1/2).isActive = true
        descTextField.rightAnchor.constraint(equalTo: addChoreView.rightAnchor, constant: -15).isActive = true
        descTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    func constrainAddChoreViewTitleLabel() {
        addChoreViewTitleLabel.centerXAnchor.constraint(equalTo: addChoreView.centerXAnchor).isActive = true
        addChoreViewTitleLabel.topAnchor.constraint(equalTo: addChoreView.topAnchor, constant: 5).isActive = true
    }
    
    func constrainTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: addChoreView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainDescLabel() {
        descLabel.topAnchor.constraint(equalTo: descTextField.topAnchor).isActive = true
        descLabel.leftAnchor.constraint(equalTo: addChoreView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainDueDateLabel() {
        dueDateLabel.topAnchor.constraint(equalTo: descTextField.bottomAnchor).isActive = true
        dueDateLabel.leftAnchor.constraint(equalTo: addChoreView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainDueDatePicker() {
        dueDatePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dueDatePicker.widthAnchor.constraint(equalTo: addChoreView.widthAnchor, constant: -24).isActive = true
        dueDatePicker.rightAnchor.constraint(equalTo: descTextField.rightAnchor).isActive = true
        dueDatePicker.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func addChore()  {
        self.view.addSubview(addChoreView)
        constrainAddChoreView()
    }
    
    func handleCancel() {
        self.addChoreView.removeFromSuperview()
    }
    
    func handleSave() {
        print(titleTextField.text!)
        print(descTextField.text!)
        self.addChoreView.removeFromSuperview()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChore))
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
