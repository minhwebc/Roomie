//
//  GroceriesViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class GroceriesViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    let rootRef  = Database.database().reference()
    let sessionManager = SessionManager()
    let dateFormatter = DateFormatter()
    
    // Array to contain Groceries
    var groceries: [Dictionary<String,String>] = []
    
    let addGroceriesView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    // Table view to display Groceries
    let groceriesTableView:UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "groceryCell")
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
        txt.attributedPlaceholder = NSAttributedString(string:" Item's Name", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Detail TextField
    let descTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:" Detail about the item", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Title Label
    let addGroceriesViewTitleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Add New Groceries"
        txt.font = UIFont.boldSystemFont(ofSize: 24)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // item Title Label
    let titleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Item Needs:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // detail Label
    let descLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Detail:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // due date of grocery datePicker
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
    
    //constrain for adding view
    func constrainaddGroceriesView() {
        addGroceriesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addGroceriesView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addGroceriesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addGroceriesView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        //add subview
        addGroceriesView.addSubview(cancelButton)
        addGroceriesView.addSubview(saveButton)
        addGroceriesView.addSubview(titleTextField)
        addGroceriesView.addSubview(descTextField)
        addGroceriesView.addSubview(addGroceriesViewTitleLabel)
        addGroceriesView.addSubview(descLabel)
        addGroceriesView.addSubview(titleLabel)
        addGroceriesView.addSubview(dueDateLabel)
        addGroceriesView.addSubview(dueDatePicker)
        
        //constraining subview
        constrainSaveButton()
        constrainCancelButton()
        constrainTitleTextField()
        constrainDescTextField()
        constrainaddGroceriesViewTitleLabel()
        constrainDescLabel()
        constrainTitleLabel()
        constrainDueDateLabel()
        constrainDueDatePicker()
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
        titleTextField.heightAnchor.constraint(equalTo: addGroceriesView.heightAnchor, multiplier: 1/7).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: addGroceriesView.widthAnchor, multiplier: 1/2).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: addGroceriesView.rightAnchor, constant: -15).isActive = true
        titleTextField.topAnchor.constraint(equalTo: addGroceriesView.topAnchor, constant: 40).isActive = true
    }
    
    func constrainDescTextField() {
        descTextField.heightAnchor.constraint(equalTo: addGroceriesView.heightAnchor, multiplier: 1/7).isActive = true
        descTextField.widthAnchor.constraint(equalTo: addGroceriesView.widthAnchor, multiplier: 1/2).isActive = true
        descTextField.rightAnchor.constraint(equalTo: addGroceriesView.rightAnchor, constant: -15).isActive = true
        descTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    func constrainaddGroceriesViewTitleLabel() {
        addGroceriesViewTitleLabel.centerXAnchor.constraint(equalTo: addGroceriesView.centerXAnchor).isActive = true
        addGroceriesViewTitleLabel.topAnchor.constraint(equalTo: addGroceriesView.topAnchor, constant: 5).isActive = true
    }
    
    func constrainDescLabel() {
        descLabel.topAnchor.constraint(equalTo: descTextField.topAnchor).isActive = true
        descLabel.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainDueDateLabel() {
        dueDateLabel.topAnchor.constraint(equalTo: descTextField.bottomAnchor, constant: 20).isActive = true
        dueDateLabel.leftAnchor.constraint(equalTo: addGroceriesView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainDueDatePicker() {
        dueDatePicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dueDatePicker.widthAnchor.constraint(equalTo: addGroceriesView.widthAnchor, constant: -24).isActive = true
        dueDatePicker.rightAnchor.constraint(equalTo: descTextField.rightAnchor).isActive = true
        dueDatePicker.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    let refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    func constrainGroceriesTableView() {
        // add pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        groceriesTableView.addSubview(refreshControl)
        
        groceriesTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -60).isActive = true
        groceriesTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func addGroceries()  {
        self.view.addSubview(addGroceriesView)
        constrainaddGroceriesView()
    }
    
    func handleCancel() {
        titleTextField.text = ""
        descTextField.text = ""
        self.addGroceriesView.removeFromSuperview()
    }
    
    func handleSave() {
        let selectedDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: dueDatePicker.date)!)
        
        if let title = titleTextField.text {
            let desc = descTextField.text ?? ""
            
            let groceryRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/grocery")
            let key : String = groceryRef.childByAutoId().key
            groceryRef.child("\(key)/title").setValue(title)
            groceryRef.child("\(key)/description").setValue(desc)
            groceryRef.child("\(key)/create_on").setValue(dateFormatter.string(from: Date()))
            groceryRef.child("\(key)/due_on").setValue(selectedDate)
            groceryRef.child("\(key)/creator").setValue(userName)
            groceryRef.child("\(key)/creatorID").setValue(sessionManager.getUserDetails()["userID"]!)
            print("add grocery item successfully!")
            let dict = ["title":titleTextField.text!,"desc":descTextField.text!,"creator":"Created by: \(userName)", "dueDate":"Due on: \(selectedDate)", "id": "\(key)", "amount": "Total amount is "]
            
            groceries.append(dict)
//            addGroceriesView.removeFromSuperview()
            refreshTable()
        }
        else {
            print("title field cannot be empty!")
        }
        
        //        print(titleTextField.text!)
        //        print(ownerTextField.text!)
        //        self.addGroceriesView.removeFromSuperview()
        //        let gro = ["item":titleTextField.text]
        //        groceries.append(gro as! [String : String])
        //        print(groceries)
        //        groceriesTableView.reloadData()
    }
    
    
    // table view setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "groceryCell")
        
        let dueDateLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.right
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let ItemLabel:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.left
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let DescLabelOnCell: UILabel = {
            let label = UILabel()
            label.text = self.groceries[indexPath.row]["desc"]
            label.textAlignment = NSTextAlignment.left
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let CreatorLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.right
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
            label.text = self.groceries[indexPath.row]["amount"]
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let CompleteButtonOnCell: UIButton = {
            let button = UIButton()
            button.setTitle("Completed", for: .normal)
            button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 7)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // setup extra labels in each cell
        dueDateLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        dueDateLabelOnCell.text = groceries[indexPath.row]["dueDate"]!
        ItemLabel.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        ItemLabel.text = groceries[indexPath.row]["title"]!
        CreatorLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
        CreatorLabelOnCell.text = groceries[indexPath.row]["creator"]!
        
        // add label as subviews in each cell
        cell.addSubview(dueDateLabelOnCell)
        cell.addSubview(ItemLabel)
        cell.addSubview(CreatorLabelOnCell)
        cell.addSubview(DescLabelOnCell)
        cell.addSubview(detailViewOnCell)
        
        //contrain extra labels on cell
        dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.topAnchor), constant: 5).isActive = true
        dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -2.5).isActive = true
        dueDateLabelOnCell.leftAnchor.constraint(equalTo: ItemLabel.rightAnchor, constant: 2.5).isActive = true
        
        ItemLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5).isActive = true
        ItemLabel.rightAnchor.constraint(equalTo: (dueDateLabelOnCell.leftAnchor), constant: -2.5).isActive = true
        ItemLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 2.5).isActive = true
        
        DescLabelOnCell.topAnchor.constraint(equalTo: ItemLabel.bottomAnchor, constant: 5).isActive = true
        DescLabelOnCell.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 2.5).isActive = true
        DescLabelOnCell.rightAnchor.constraint(equalTo: CreatorLabelOnCell.leftAnchor, constant: -2.5)
        
        CreatorLabelOnCell.topAnchor.constraint(equalTo: dueDateLabelOnCell.bottomAnchor, constant: 5).isActive = true
        CreatorLabelOnCell.leftAnchor.constraint(equalTo: DescLabelOnCell.rightAnchor, constant: 2.5).isActive = true
        CreatorLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -2.5).isActive = true
        
        // detail cell setup
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        detailViewOnCell.topAnchor.constraint(equalTo: (DescLabelOnCell.bottomAnchor), constant: 2.5).isActive = true
        detailViewOnCell.leftAnchor.constraint(equalTo: (cell.leftAnchor), constant: 2.5).isActive = true
        detailViewOnCell.bottomAnchor.constraint(equalTo: (cell.bottomAnchor), constant: -1).isActive = true
        detailViewOnCell.rightAnchor.constraint(equalTo: (cell.rightAnchor), constant: -2.5).isActive = true
        
        detailLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!-2)
        detailViewOnCell.addSubview(detailLabelOnCell)
        detailViewOnCell.addSubview(CompleteButtonOnCell)
        
        detailLabelOnCell.leftAnchor.constraint(equalTo: detailViewOnCell.leftAnchor, constant: 2.5).isActive = true
        detailLabelOnCell.rightAnchor.constraint(equalTo: detailLabelOnCell.rightAnchor, constant: -22.5).isActive = true
        detailLabelOnCell.centerYAnchor.constraint(equalTo: detailViewOnCell.centerYAnchor).isActive = true
        CompleteButtonOnCell.rightAnchor.constraint(equalTo: detailViewOnCell.rightAnchor, constant: -2.5).isActive = true
        CompleteButtonOnCell.leftAnchor.constraint(equalTo: detailLabelOnCell.rightAnchor, constant: -2.5).isActive = true
        CompleteButtonOnCell.centerYAnchor.constraint(equalTo: detailViewOnCell.centerYAnchor).isActive = true
        
        CompleteButtonOnCell.tag = indexPath.row
        CompleteButtonOnCell.addTarget(self, action: #selector(handleGroceriesAssignment(_:)), for: .touchUpInside)
        
        CompleteButtonOnCell.isEnabled = true
        CompleteButtonOnCell.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
        
//        if groceries[indexPath.row]["assignee"] != "Assigned to: \(self.na)" {
//            CompleteButtonOnCell.isEnabled = false
//            CompleteButtonOnCell.backgroundColor = UIColor.gray
//        }
//        else {
//            CompleteButtonOnCell.isEnabled = true
//            CompleteButtonOnCell.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
//        }
        
        if groceriesTableView.rectForRow(at: indexPath).height == EXPAND_HEIGHT {
            detailViewOnCell.isHidden = false
        }
        else {
            detailViewOnCell.isHidden = true
        }
        
        
        return cell
        
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    //        cell.textLabel?.text = groceries[indexPath.row]["item"]
    //        print(groceries[indexPath.row]["item"]!)
    //        return cell
    //    }
    
    
    @objc func handleGroceriesAssignment(_ sender: UIButton) {
        let gvc = GroceryListViewController()
        gvc.groceryID = groceries[sender.tag]["id"]
        gvc.groceryName = groceries[sender.tag]["title"]
        gvc.creator = groceries[sender.tag]["creator"]
        gvc.due_on = groceries[sender.tag]["dueDate"]
        gvc.gvc = self
        self.navigationController?.pushViewController(gvc, animated: true)
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
        self.groceriesTableView.reloadData()
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
    
    //delect a cell in the table row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // swipe to delete grocery
            let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
            
            if groceries[indexPath.row]["creatorID"]! == sessionManager.getUserDetails()["userID"]! {
                groupRef.child("grocery/\(groceries[indexPath.row]["id"]!)").setValue(nil)
                groupRef.child("users/\(groceries[indexPath.row]["payID"]!)/grocery/\(groceries[indexPath.row]["id"]!)").setValue(nil)
                
                previousIndexPath = nil
                self.groceriesTableView.beginUpdates()
                self.groceries.remove(at: indexPath.row)
                self.groceriesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.groceriesTableView.endUpdates()
            }else {
                self.view.makeToast("Only its creator can delete it!")
                self.groceriesTableView.reloadData()
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
        item.title = "Shopping List"
        item.image = #imageLiteral(resourceName: "List-50")
        return item
    }()
    
    let OverdueItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Completed"
        item.image = #imageLiteral(resourceName: "Present-50")
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        groceriesTableView.delegate = self
        groceriesTableView.dataSource = self
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        // add and config the Tabbar to the view.
        view.addSubview(tabbar)
        configTabBar()
        
         getUsername()
        
        view.addSubview(groceriesTableView)
        constrainGroceriesTableView()
        
        self.groceriesTableView.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
        self.groceriesTableView.tableFooterView = UIView()
        view.backgroundColor = UIColor(red: 201/255.0, green:198/255.0 , blue: 170/255.0 ,alpha:1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroceries))
        
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
        } else if gesture.direction == UISwipeGestureRecognizerDirection.left && tabbar.selectedItem == TodoItem {
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
        // tabbar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/7).isActive = true
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
        groceries.removeAll()
        
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/grocery").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    
                    if self.tabbar.selectedItem! == self.TodoItem && self.dateFormatter.date(from: value["due_on"] as! String)!.compare(Date()) == .orderedDescending{
                        
                        let dict = ["title": value["title"],"desc": value["description"],"creator":"Created by: \(value["creator"]!)","dueDate":"Due on: \(value["due_on"]!)", "id": "\(key)", "creatorID": "\(value["creatorID"]!)", "amount": "Total amount is \(value["totalAmount"] ?? self.na)", "payID": "\(value["payID"] ?? self.na)"]
                        self.groceries.append(dict as! [String : String])
                    }
                    
                    if self.tabbar.selectedItem! == self.OverdueItem && self.dateFormatter.date(from: value["due_on"] as! String)!.compare(Date()) != .orderedDescending {
                        let dict = ["title": value["title"],"desc": value["description"],"creator":"Created by: \(value["creator"]!)","dueDate":"Due on: \(value["due_on"]!)", "id": "\(key)", "creatorID": "\(value["creatorID"]!)", "amount": "Total amount is \(value["totalAmount"] ?? self.na)", "payID": "\(value["payID"] ?? self.na)"]
                        self.groceries.append(dict as! [String : String])
                    }
                    self.refreshTableData()
                }
                
            }
            self.refreshControl.endRefreshing()
        })
    }
    
    func refreshTableData() {
        groceriesTableView.reloadData()
        dueDatePicker.date = NSDate() as Date
        titleTextField.text = ""
        descTextField.text = ""
        self.addGroceriesView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
