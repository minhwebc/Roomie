//
//  BillsViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Floaty
import FontAwesome_swift
import DropDown
import Firebase

class BillsViewController: UITabBarController, UITabBarControllerDelegate{
    
    var ref: DatabaseReference!
    let dateFormatter = DateFormatter()
    var tabOne = TabOneViewController()
    let tabOneBarItem = UITabBarItem();
    
    
    // view to enter bill details
    let addBillView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    // button to cancel adding a bill
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
    
    // button to save a bill
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
    
    // Title Label
    let titleLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Title:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Title of bill TextField
    let titleTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Title", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Amount Label
    let amountLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Amount:"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Amount of bill TextField
    let amountTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Amount", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Amount Label
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
    
    let dropDownView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Amount of bill TextField
    let dropDownResult:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Frequency", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        return txt
    }()
    
    func textFieldDidChange(_ textField: UITextField) {
        dropDown.show();
    }
    
    let dropDown = DropDown();
    func constrainAddBillView() {
        
        
        addBillView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addBillView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        addBillView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        addBillView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -3).isActive = true
        
        // adding subviews
        addBillView.addSubview(cancelButton)
        addBillView.addSubview(saveButton)
        addBillView.addSubview(titleTextField)
        addBillView.addSubview(amountTextField)
        addBillView.addSubview(amountLabel)
        addBillView.addSubview(titleLabel)
        addBillView.addSubview(dueDatePicker)
        
        addBillView.addSubview(dropDownView)
        dropDownView.addSubview(dropDownResult)
        addBillView.addSubview(dueDateLabel)
        
        
        constrainTitleLabel()
        constrainAmountLabel()
        constrainSaveButton()
        constrainCancelButton()
        constrainAmountTextField()
        constrainTitleTextField()
        constrainDueDatePicker()
        constrainDueDateLabel()
        
        dropDownView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dropDownView.widthAnchor.constraint(equalTo: addBillView.widthAnchor, constant: -24).isActive = true
        dropDownView.leftAnchor.constraint(equalTo: addBillView.leftAnchor, constant: 20).isActive = true
        dropDownView.rightAnchor.constraint(equalTo: addBillView.rightAnchor, constant: -15).isActive = true
        dropDownView.topAnchor.constraint(equalTo: dueDatePicker.bottomAnchor, constant: 20).isActive = true
        
        dropDownResult.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dropDownResult.widthAnchor.constraint(equalTo: dropDownView.widthAnchor, multiplier: 1/2).isActive = true
        dropDownResult.rightAnchor.constraint(equalTo: dropDownView.rightAnchor, constant: -15).isActive = true
        dropDownResult.topAnchor.constraint(equalTo: dropDownView.topAnchor, constant: 10).isActive = true
        
        
        dropDown.dataSource = ["every month", "every 2 months"]
        dropDown.width = 100
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownResult.text = item
            print("Selected item: \(item) at index: \(index)")
        }
        
    }
    
    
    func constrainAmountLabel(){
        amountLabel.topAnchor.constraint(equalTo: amountTextField.topAnchor).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: addBillView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainTitleLabel(){
        titleLabel.topAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: addBillView.leftAnchor, constant: 20).isActive = true
    }
    
    func constrainSaveButton() {
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.rightAnchor.constraint(equalTo: addBillView.rightAnchor, constant:-15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: addBillView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector (handleSave), for: .touchUpInside)
    }
    
    func constrainAmountTextField(){
        amountTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: addBillView.widthAnchor, multiplier: 1/2).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: addBillView.rightAnchor, constant: -15).isActive = true
        amountTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    
    func constrainCancelButton() {
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addBillView.leftAnchor,constant:15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addBillView.bottomAnchor, constant: -10).isActive = true
        cancelButton.addTarget(self, action: #selector (handleCancel), for: .touchUpInside)
    }
    
    func constrainTitleTextField() {
        titleTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: addBillView.widthAnchor, multiplier: 1/2).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: addBillView.rightAnchor, constant: -15).isActive = true
        titleTextField.topAnchor.constraint(equalTo: addBillView.topAnchor, constant: 50).isActive = true
    }
    
    func constrainDueDatePicker() {
        dueDatePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //dueDatePicker.widthAnchor.constraint(equalTo: addBillView.widthAnchor)
        dueDatePicker.widthAnchor.constraint(equalTo: addBillView.widthAnchor, constant: -15).isActive = true
        //dueDatePicker.rightAnchor.constraint(equalTo: addBillView.rightAnchor).isActive = true
        dueDatePicker.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: 10).isActive = true
    }
    func constrainDueDateLabel() {
        dueDateLabel.leftAnchor.constraint(equalTo: amountLabel.leftAnchor).isActive = true
        
        dueDateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10).isActive = true
    }
    func handleCancel() {
        titleTextField.text = ""
        self.addBillView.removeFromSuperview()
    }
    
    func handleSave(){
        let selectedDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: dueDatePicker.date)!)
        let sessionManager : SessionManager = SessionManager()
        var userDetails : [String: String] = sessionManager.getUserDetails()
        let groupName : String = userDetails[sessionManager.groupName]!
        let groupRef = self.ref.child("groups/\(groupName)/bills");
        let key : String = groupRef.childByAutoId().key;
        let billRef = self.ref.child("groups/\(groupName)/bills/\(key)");
        let bill = ["title": self.titleTextField.text!,
                    "amount": self.amountTextField.text!,
                    "frequency": self.dropDownResult.text!,
                    "due": selectedDate]
        billRef.updateChildValues(bill);
        tabOne.refreshTable()
        addBillView.removeFromSuperview();
    }
    
    // function to add a subview to be able to add a chore
    func addBill()  {
        self.view.addSubview(addBillView)
        constrainAddBillView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd MMM yyyy";
        self.edgesForExtendedLayout = []
        
        // Do any additional setup after loading the view.
        self.delegate = self;
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        ref = Database.database().reference()
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hello") as? TabOneViewController {
            tabOne = viewController;
        }
        
        tabOneBarItem.image = UIImage.fontAwesomeIcon(name: .money, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
        tabOne.tabBarItem = tabOneBarItem;
        
        // Create Tab two
        let tabTwo = TabTwoViewController()
        let tabTwoBarItem2 = UITabBarItem()
        tabTwoBarItem2.image = UIImage.fontAwesomeIcon(name: .history, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        let floaty = Floaty()
        
        floaty.addItem("Add a bill for all", icon: UIImage.fontAwesomeIcon(name: .plus, textColor: UIColor.black, size: CGSize(width: 30, height: 30)), handler: { item in
            self.addBill();
            floaty.close()
        })
        //        floaty.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(floaty)
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
    
}

class TabOneViewController: UITableViewController {
    
    let kCloseCellHeight: CGFloat = 75
    let kOpenCellHeight: CGFloat = 120
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    var firebaseRef : DatabaseReference!
    let sessionManager = SessionManager()
    // Array to contain chores
    var bills: [Bill] = []
    var users: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef = Database.database().reference()
        self.title = "Current Bills"
        self.tableView.separatorStyle = .none
        refreshTable()
        setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshTable()
    }
    
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //    ////////////////////////////
    //    //////////////
    //    //// Setup table view to display added bills
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return self.bills.count
    //    }
    
    func refreshTable() {
        self.bills.removeAll()
        self.users.removeAll()
        
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let name = value["name"];
                    if(name != nil){
                        self.users.append(name as! String);
                    }
                }
            }
        })
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let bill = Bill(dueDate : value["due"]! as! String, amount : value["amount"] as! String, frequency : value["frequency"] as! String, title : value["title"] as! String)
                    self.bills.append(bill);
                }
            }
            self.tableView.reloadData()
        })
    }
    
}
// MARK: - TableView
extension TabOneViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as BillCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion:nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        let due:UILabel = {
            let txt = UILabel()
            txt.text = bills[indexPath.row].dueDate
            txt.translatesAutoresizingMaskIntoConstraints = false
            return txt
        }()
        let title:UILabel = {
            let txt = UILabel()
            txt.text = bills[indexPath.row].title
            txt.translatesAutoresizingMaskIntoConstraints = false
            return txt
        }()
        let amount:UILabel = {
            let txt = UILabel()
            txt.text = "$\(bills[indexPath.row].amount)"
            txt.translatesAutoresizingMaskIntoConstraints = false
            return txt
        }()
        cell.foregroundView.backgroundColor = UIColor(red: 238/255.0, green:163/255.0 , blue: 163/255.0 ,alpha:1)
        cell.foregroundView.layer.cornerRadius = 10;
        cell.foregroundView.addSubview(title)
        cell.foregroundView.addSubview(due)
        cell.foregroundView.addSubview(amount)
        
        due.rightAnchor.constraint(equalTo: (cell.foregroundView.rightAnchor), constant: -7).isActive = true
        due.topAnchor.constraint(equalTo: (cell.foregroundView.topAnchor),constant: 25 ).isActive = true
        
        title.leftAnchor.constraint(equalTo: (cell.foregroundView.leftAnchor), constant: 5).isActive = true
        title.topAnchor.constraint(equalTo: (cell.foregroundView.topAnchor),constant: 15 ).isActive = true
        
        amount.leftAnchor.constraint(equalTo: (cell.foregroundView.leftAnchor), constant: 5).isActive = true
        amount.topAnchor.constraint(equalTo: (cell.foregroundView.topAnchor),constant: 35 ).isActive = true
        
        let stackView = UIStackView();
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let average : Double = Double(bills[indexPath.row].amount)! / Double(self.users.count);
        for name in users{
            let amount:UILabel = {
                let txt = UILabel()
                txt.text = "\(name) $\(average)"
                txt.translatesAutoresizingMaskIntoConstraints = false
                return txt
            }()
            stackView.addArrangedSubview(amount)
            print("\(name) $\(average)");
        }
        cell.containerView.layer.cornerRadius = 10;
        cell.containerView.backgroundColor = UIColor.
        cell.containerView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: cell.containerView.topAnchor, constant: 5).isActive = true;
        stackView.leftAnchor.constraint(equalTo: cell.containerView.leftAnchor, constant: 5).isActive = true;
        stackView.rightAnchor.constraint(equalTo: cell.containerView.rightAnchor, constant: 5).isActive = true;

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
}


public class Bill{
    public var dueDate : String;
    public var amount : String;
    public var frequency : String;
    public var title : String;
    public var overdue : Bool;
    init(dueDate : String, amount : String, frequency : String, title : String) {
        self.dueDate = dueDate;
        self.amount = amount;
        self.frequency = frequency;
        self.title = title;
        self.overdue = false;
    }
}

class TabTwoViewController: UITableViewController {
    var firebaseRef : DatabaseReference!
    let sessionManager = SessionManager()
    let dateFormatter = DateFormatter()
    
    
    // Array to contain bills
    var bills: [Bill] = []
    
    
    func refreshTable() {
        self.bills.removeAll()
        
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let bill = Bill(dueDate : value["due"]! as! String, amount : value["amount"] as! String, frequency : value["frequency"] as! String, title : value["title"] as! String)
                    let calendar = NSCalendar.current
                    if(bill.frequency == "every month"){
                        var dueDate = self.dateFormatter.date(from: bill.dueDate);
                        var currentDate = Date()
                        let monthOfDueDate = calendar.component(.month, from: dueDate!)
                        let monthOfCurrentDate = calendar.component(.month, from: currentDate )
                        let distance : Int = monthOfCurrentDate - monthOfDueDate;
                        if(distance > 0){
                            for _ in 1...distance {
                                dueDate = calendar.date(byAdding: Calendar.Component.month, value: 1, to: dueDate!)
                            }
                        }
                        if(currentDate > dueDate!){
                            print("overdue");
                            bill.overdue = true;
                        }
                        if(bill.overdue){
                            self.bills.append(bill);
                        }
                    }else{
                        var dueDate = self.dateFormatter.date(from: bill.dueDate);
                        var currentDate = Date()
                        let monthOfDueDate = calendar.component(.month, from: dueDate!)
                        let monthOfCurrentDate = calendar.component(.month, from: currentDate )
                        var distance : Int = monthOfCurrentDate - monthOfDueDate;
                        if(distance > 0){
                            distance = distance % 2;
                            for _ in 1...distance {
                                dueDate = calendar.date(byAdding: Calendar.Component.month, value: 2, to: dueDate!)
                            }
                        }
                        if(currentDate > dueDate!){
                            print("overdue");
                            bill.overdue = true;
                        }
                        if(bill.overdue){
                            self.bills.append(bill);
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        self.title = "Past Due Bills"
        firebaseRef = Database.database().reference()
        dateFormatter.dateFormat = "dd MMM yyyy";
        refreshTable();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bills.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "billCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "billCell")
        }
        
        cell!.textLabel?.text = bills[indexPath.row].title
        cell!.detailTextLabel?.text = bills[indexPath.row].amount
        // Title Label
        let label:UILabel = {
            let txt = UILabel()
            txt.text = bills[indexPath.row].dueDate
            txt.translatesAutoresizingMaskIntoConstraints = false
            return txt
        }()
        cell!.contentView.addSubview(label)
        
        label.rightAnchor.constraint(equalTo: (cell?.rightAnchor)!).isActive = true
        label.topAnchor.constraint(equalTo: (cell?.textLabel?.bottomAnchor)!,constant:1 ).isActive = true
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


