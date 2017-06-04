//
//  ChoresViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class ChoresViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
        view.layer.opacity = 1
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
    
    let refreshControl: UIRefreshControl = {
       return UIRefreshControl()
    }()
    
    func constrainChoreTableView()  {
        // add pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        choresTableView.addSubview(refreshControl)
        
        choresTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -60).isActive = true
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
        let selectedDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: dueDatePicker.date)!)
        
        if let title = titleTextField.text {
            let desc = descTextField.text ?? ""
            
            let choresRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores")
            let key : String = choresRef.childByAutoId().key
            choresRef.child("\(key)/title").setValue(title)
            choresRef.child("\(key)/description").setValue(desc)
            choresRef.child("\(key)/create_on").setValue(dateFormatter.string(from: Date()))
            choresRef.child("\(key)/due_on").setValue(selectedDate)
            choresRef.child("\(key)/creator").setValue(userName)
            choresRef.child("\(key)/creatorID").setValue(sessionManager.getUserDetails()["userID"]!)
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
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let dueDateLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.right
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let TitleLabel:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.left
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let CreatorLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.left
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let detailViewOnCell:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        let detailLabelOnCell: UILabel = {
            let label = UILabel()
            label.text = self.chores[indexPath.row]["desc"]
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let AssignToButtonOnCell: UIButton = {
            let button = UIButton()
            button.setTitle("Assign To", for: .normal)
            button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 7)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // setup extra labels in each cell
        AssignedToLabel.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        AssignedToLabel.text = chores[indexPath.row]["assignee"]
        dueDateLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        dueDateLabelOnCell.text = chores[indexPath.row]["dueDate"]!
        TitleLabel.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        TitleLabel.text = chores[indexPath.row]["title"]!
        CreatorLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        CreatorLabelOnCell.text = chores[indexPath.row]["creator"]!
        
        // add label as subviews in each cell
        cell.addSubview(AssignedToLabel)
        cell.addSubview(dueDateLabelOnCell)
        cell.addSubview(TitleLabel)
        cell.addSubview(CreatorLabelOnCell)
        cell.addSubview(detailViewOnCell)
        
        //contrain extra labels on cell
        dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.topAnchor), constant: 5).isActive = true
        dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -2.5).isActive = true
        dueDateLabelOnCell.leftAnchor.constraint(equalTo: TitleLabel.rightAnchor, constant: 2.5).isActive = true
        
        AssignedToLabel.topAnchor.constraint(equalTo: (dueDateLabelOnCell.bottomAnchor), constant: 5).isActive = true
        AssignedToLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -2.5).isActive = true
        AssignedToLabel.leftAnchor.constraint(equalTo: CreatorLabelOnCell.rightAnchor, constant: 2.5).isActive = true
        
        TitleLabel.topAnchor.constraint(equalTo: (cell.topAnchor), constant: 5).isActive = true
        TitleLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 2.5).isActive = true
        TitleLabel.rightAnchor.constraint(equalTo: dueDateLabelOnCell.leftAnchor, constant: -2.5)
        
        CreatorLabelOnCell.topAnchor.constraint(equalTo: (TitleLabel.bottomAnchor), constant: 5).isActive = true
        CreatorLabelOnCell.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 2.5).isActive = true
        CreatorLabelOnCell.rightAnchor.constraint(equalTo: AssignedToLabel.leftAnchor, constant: -2.5).isActive = true
        
        // cell setup
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        detailViewOnCell.topAnchor.constraint(equalTo: (CreatorLabelOnCell.bottomAnchor), constant: 2.5).isActive = true
        detailViewOnCell.leftAnchor.constraint(equalTo: (cell.leftAnchor), constant: 2.5).isActive = true
        detailViewOnCell.bottomAnchor.constraint(equalTo: (cell.bottomAnchor), constant: -2.5).isActive = true
        detailViewOnCell.rightAnchor.constraint(equalTo: (cell.rightAnchor), constant: -2.5).isActive = true
        
        detailLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!-2)
        detailViewOnCell.addSubview(detailLabelOnCell)
        detailViewOnCell.addSubview(AssignToButtonOnCell)
        
        detailLabelOnCell.leftAnchor.constraint(equalTo: detailViewOnCell.leftAnchor, constant: 2.5).isActive = true
        detailLabelOnCell.rightAnchor.constraint(equalTo: detailLabelOnCell.rightAnchor, constant: -22.5).isActive = true
        detailLabelOnCell.centerYAnchor.constraint(equalTo: detailViewOnCell.centerYAnchor).isActive = true
            //.topAnchor.constraint(equalTo: detailViewOnCell.topAnchor).isActive = true
        AssignToButtonOnCell.rightAnchor.constraint(equalTo: detailViewOnCell.rightAnchor, constant: -2.5).isActive = true
        AssignToButtonOnCell.leftAnchor.constraint(equalTo: detailLabelOnCell.rightAnchor, constant: -2.5).isActive = true
        AssignToButtonOnCell.centerYAnchor.constraint(equalTo: detailViewOnCell.centerYAnchor).isActive = true
        
        AssignToButtonOnCell.tag = indexPath.row
        AssignToButtonOnCell.addTarget(self, action: #selector(handleChoresAssignment(_:)), for: .touchUpInside)
        
        if chores[indexPath.row]["assignee"] != "Assigned to: \(self.na)" {
            AssignToButtonOnCell.isEnabled = false
            AssignToButtonOnCell.backgroundColor = UIColor.gray
        }
        else {
            AssignToButtonOnCell.isEnabled = true
            AssignToButtonOnCell.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        }
        
        if choresTableView.rectForRow(at: indexPath).height == EXPAND_HEIGHT {
            detailViewOnCell.isHidden = false
        }
        else {
            detailViewOnCell.isHidden = true
        }
        
        return cell
    }
    
    @objc func handleChoresAssignment(_ sender: UIButton) {
        let vc = UserListViewController()
        vc.choreID = chores[sender.tag]["id"]
        vc.choreName = chores[sender.tag]["title"]
        vc.creator = chores[sender.tag]["creator"]
        vc.due_on = chores[sender.tag]["dueDate"]
        vc.vc = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    var previousIndexPath: IndexPath?
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if previousIndexPath == indexPath {
            previousIndexPath = nil
        }
        else {
            previousIndexPath = indexPath
        }
        self.choresTableView.reloadData()
    }
    
    let EXPAND_HEIGHT = CGFloat(70)
    let COLLAPSE_HEIGHT = CGFloat(50)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if previousIndexPath == indexPath {
            return EXPAND_HEIGHT
        }
        else {
            return COLLAPSE_HEIGHT
        }
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
            if chores[indexPath.row]["creatorID"]! == sessionManager.getUserDetails()["userID"]! {
                rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores/\(chores[indexPath.row]["id"]!)").setValue(nil)
                
                self.choresTableView.beginUpdates()
                self.chores.remove(at: indexPath.row)
                self.choresTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.choresTableView.endUpdates()
            }
            else {
                chores.remove(at: indexPath.row)
                choresTableView.reloadData()
            }
            
        }
    }

    
    // ViewDidLoad to call all the major functions
    let tabbar: UITabBar = {
        let view = UITabBar(frame: CGRect(x: 100, y: 0, width: 40, height: 60))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let TodoItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "To Do"
        item.image = #imageLiteral(resourceName: "List-50")
        return item
    }()
    
    let OverdueItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Overdue"
        item.image = #imageLiteral(resourceName: "Present-50")
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        choresTableView.dataSource = self
        choresTableView.delegate = self
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        // add and config the Tabbar to the view.
        view.addSubview(tabbar)
        configTabBar()
        
        getUsername()
        
        view.addSubview(choresTableView)
        constrainChoreTableView()
        self.choresTableView.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        self.choresTableView.tableFooterView = UIView()
        view.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChore))
        
        refreshTable()
        
        swipeLeft.addTarget(self, action: #selector(handleGesture(gesture:)))
        swipeRight.addTarget(self, action: #selector(handleGesture(gesture:)))
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right && tabbar.selectedItem == OverdueItem {
            print("Swipe Right")
            self.tabBar(tabbar, didSelect: TodoItem)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left && tabbar.selectedItem == TodoItem {
            print("Swipe Left")
            self.tabBar(tabbar, didSelect: OverdueItem)
        }
    }

    
    let swipeLeft: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer()
        recognizer.direction = .left
        return recognizer
    }()
    
    let swipeRight: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer()
        recognizer.direction = .right
        return recognizer
    }()
    
    var userName = ""
    func getUsername() {
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users/\(sessionManager.getUserDetails()["userID"]!)").observeSingleEvent(of: .value, with: {
            (snap) in
            let value = snap.value as? NSDictionary
            self.userName = value?["name"] as? String ?? ""
        })
    }
    
    func configTabBar() {
        tabbar.delegate = self
        tabbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //        tabbar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/7).isActive = true
        tabbar.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        tabbar.backgroundColor = UIColor.gray
        tabbar.items = [TodoItem, OverdueItem]
        tabbar.selectedItem = TodoItem
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabbar.selectedItem = item
        refreshTable()
    }
    
    let na = "N/A"
    func refreshTable() {
        chores.removeAll()
        
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    
                    
                    if self.tabbar.selectedItem! == self.TodoItem && self.dateFormatter.date(from: value["due_on"] as! String)!.compare(Date()) == .orderedDescending {
                        let dict = ["title": value["title"],"desc": value["description"],"creator":"Created by: \(value["creator"]!)","assignee":"Assigned to: \(value["assignTo"] ?? self.na)","dueDate":"Due on: \(value["due_on"]!)", "id": "\(key)", "creatorID": "\(value["creatorID"]!)"]
                        self.chores.append(dict as! [String : String])
                    }
                    
                    if self.tabbar.selectedItem! == self.OverdueItem && self.dateFormatter.date(from: value["due_on"] as! String)!.compare(Date()) != .orderedDescending {
                        let dict = ["title": value["title"],"desc": value["description"],"creator":"Created by: \(value["creator"]!)","assignee":"Assigned to: \(value["assignTo"] ?? self.na)","dueDate":"Due on: \(value["due_on"]!)", "id": "\(key)", "creatorID": "\(value["creatorID"]!)"]
                        self.chores.append(dict as! [String : String])
                    }
                    self.refreshTableData()
                }

            }
            self.refreshControl.endRefreshing()
        })
    }
    
    func refreshTableData() {
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
    

}
