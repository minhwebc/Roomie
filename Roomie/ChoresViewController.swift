//
//  ChoresViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class ChoresViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    ////////////////////////////
    //////////////
    //// Define UI Elements to add chores
    
    let rootRef = Database.database().reference()
    let sessionManager = SessionManager()
    let dateFormatter = DateFormatter()
    
    // Array to contain chores
    var chores: [Dictionary<String,String>] = []
    
    // Table view to display chores
    let choresTableView:UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "choreCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // view to enter chore details
    let addChoreView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    // button to cancel adding a chore
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
    
    // button to save a chore
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
    
    // Title of chore TextField
    let titleTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Title", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Description of chore TextView
    let descTextField:UITextView = {
        let txt = UITextView()
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // label to describe adding a chore view
    let addChoreViewTitleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Add New Chore"
        txt.font = UIFont.boldSystemFont(ofSize: 24)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // label to identify title of chore TextField
    let titleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Title:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // label to identify desc of chore TextField
    let descLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Desc:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // label to identify due date of chore datePicker
    let dueDateLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Due Date:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // date picker for due date
    let dueDatePicker:UIDatePicker = {
        let due = UIDatePicker()
        due.timeZone = NSTimeZone.local
        due.backgroundColor = UIColor.clear
        due.tintColor = UIColor.black
        due.datePickerMode = .date
        due.translatesAutoresizingMaskIntoConstraints = false
        return due
    }()
    
    
    ////////////////////////////
    //////////////
    //// Constrain UI elemnets to view and addchore view
    
    func constrainAddChoreView() {
        addChoreView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addChoreView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addChoreView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addChoreView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        // adding subviews
        addChoreView.addSubview(cancelButton)
        addChoreView.addSubview(saveButton)
        addChoreView.addSubview(titleTextField)
        addChoreView.addSubview(descTextField)
        addChoreView.addSubview(addChoreViewTitleLabel)
        addChoreView.addSubview(titleLabel)
        addChoreView.addSubview(descLabel)
        addChoreView.addSubview(dueDatePicker)
        addChoreView.addSubview(dueDateLabel)
        
        // constraining subviews
        constrainSaveButton()
        constrainCancelButton()
        constrainDescTextField()
        constrainTitleTextField()
        constrainAddChoreViewTitleLabel()
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
    
    func constrainChoreTableView()  {
        choresTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        choresTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    ////////////////////////////
    //////////////
    //// Other functional functions to add a chore
    
    // function to add a subview to be able to add a chore
    func addChore()  {
        self.view.addSubview(addChoreView)
        constrainAddChoreView()
    }
    
    // function for when the user cancels adding chore
    func handleCancel() {
        titleTextField.text = ""
        descTextField.text = ""
        self.addChoreView.removeFromSuperview()
    }
    
    // function for when a user saves a chore
    func handleSave() {
        let selectedDate = dateFormatter.string(from: dueDatePicker.date)
        
        
        if let title = titleTextField.text {
            let desc = descTextField.text ?? ""
            let userName = sessionManager.getUserDetails()["userName"]!
            
            let choresRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores")
            let key : String = choresRef.childByAutoId().key
            choresRef.child("\(key)/title").setValue(title)
            choresRef.child("\(key)/description").setValue(desc)
            choresRef.child("\(key)/create_on").setValue(dateFormatter.string(from: Date()))
            choresRef.child("\(key)/due_on").setValue(selectedDate)
            choresRef.child("\(key)/creator").setValue(userName)
            print("add chore successfully!")
            let dict = ["title":titleTextField.text!,"desc":descTextField.text!,"creator":"Created by: \(userName)","assignee":"Assigned to: ","dueDate":"Due on: \(selectedDate)", "id": "\(key)"]
            
            chores.append(dict)
            refreshTable()
        }
        else {
            print("title field cannot be empty!")
        }
        
        
    }

    ////////////////////////////
    //////////////
    //// Setup table view to display chores added
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "choreCell")
        
        // extra labels to display on each cell
        let AssignedToLabel:UILabel = {
            let label = UILabel()
            //label.text = "Assigned to: "+"username"
            label.textAlignment = NSTextAlignment.right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let dueDateLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        // setup extra labels in each cell
        AssignedToLabel.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        AssignedToLabel.text = chores[indexPath.row]["assignee"]!+"username"
        dueDateLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        dueDateLabelOnCell.text = chores[indexPath.row]["dueDate"]!
        
        // add label as subviews in each cell
        cell.addSubview(AssignedToLabel)
        cell.addSubview(dueDateLabelOnCell)
        
        //contrain extra labels on cell
        AssignedToLabel.bottomAnchor.constraint(equalTo: (cell.detailTextLabel?.bottomAnchor)!).isActive = true
        AssignedToLabel.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        
        dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.textLabel?.topAnchor)!).isActive = true
        dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        
        // cell setup
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = chores[indexPath.row]["title"]
        cell.detailTextLabel?.text = chores[indexPath.row]["creator"]!
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // swipe to delete chore
            
            rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores")
            rootRef.child("tasks/\(chores[indexPath.row]["id"]!)").setValue(nil)
            
            self.choresTableView.beginUpdates()
            self.chores.remove(at: indexPath.row)
            self.choresTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.choresTableView.endUpdates()
        }
    }

    ////////////////////////////
    //////////////
    //// ViewDidLoad to call all the major functions 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        choresTableView.dataSource = self
        choresTableView.delegate = self
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        initTable()
        
        // add the toolbar to the view.
        self.view.addSubview(toolbar)
        toolbar.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        toolbar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 5).isActive = true
//        toolbar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
//        toolbar.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        view.addSubview(choresTableView)
        
        constrainChoreTableView()
        self.choresTableView.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        self.choresTableView.tableFooterView = UIView()
        view.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChore))
    }
    
    func initTable() {
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores").observeSingleEvent(of: .value, with: { (snap) in
            let values = snap.value as! NSDictionary
            for key in values.allKeys{
                let value = values[key] as! NSDictionary
                let dict = ["title": value["title"],"desc": value["description"],"creator":"Created by: \(value["creator"]!)","assignee":"Assigned to: ","dueDate":"Due on: \(value["due_on"]!)", "id": "\(key)"]
                self.chores.append(dict as! [String : String])
                self.refreshTable()
            }
            
        })
    }
    
    func refreshTable() {
        choresTableView.reloadData()
        dueDatePicker.date = NSDate() as Date
        titleTextField.text = ""
        descTextField.text = ""
        self.addChoreView.removeFromSuperview()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var toolbar: UIToolbar = {
        // make uitoolbar instance
        let myToolbar = UIToolbar()
        
        // set the color of the toolbar
        //myToolbar.barStyle = .blackTranslucent
        myToolbar.tintColor = UIColor.white
        myToolbar.backgroundColor = UIColor.black
        myToolbar.translatesAutoresizingMaskIntoConstraints = false
        // make a button
        let myUIBarButtonGreen: UIBarButtonItem = UIBarButtonItem(title: "Green", style:.plain, target: self, action: Selector(("onClickBarButton:")))
        myUIBarButtonGreen.tag = 1
        
        let myUIBarButtonBlue: UIBarButtonItem = UIBarButtonItem(title: "Blue", style:.plain, target: self, action: Selector(("onClickBarButton:")))
        myUIBarButtonBlue.tag = 2
        
        let myUIBarButtonRed: UIBarButtonItem = UIBarButtonItem(title: "Red", style:.plain, target: self, action: Selector(("onClickBarButton:")))
        myUIBarButtonRed.tag = 3
        
        // add the buttons on the toolbar
        myToolbar.items = [myUIBarButtonGreen, myUIBarButtonBlue, myUIBarButtonRed]
        
        return myToolbar
    }()

}
