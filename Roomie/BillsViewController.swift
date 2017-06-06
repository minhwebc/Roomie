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
import ChameleonFramework
import Toast_Swift

class BillsViewController: UITabBarController, UITabBarControllerDelegate{
    var ref: DatabaseReference!
    let dateFormatter = DateFormatter()
    var tabOne = TabOneViewController()
    let tabOneBarItem = UITabBarItem();
    var userEmails = [String]()
    
    
    // view to enter bill details
    let addBillView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 1
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
    
    // Amount Label
    let frequencyLabel:UILabel = {
        let txt = UILabel()
        txt.text = "Frequency:"
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
        addBillView.addSubview(frequencyLabel)
        
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
        
        frequencyLabel.leftAnchor.constraint(equalTo: addBillView.leftAnchor, constant: 20).isActive = true
        frequencyLabel.topAnchor.constraint(equalTo: dropDownView.topAnchor, constant: 10).isActive = true
        
        dropDown.dataSource = ["every month", "every 2 months"]
        dropDown.width = 200
        
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
        if(Double(self.amountTextField.text!) == nil){
            let alert = UIAlertController(title: "Alert", message: "Amount can't be letters", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
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
        for userID in tabOne.usersID{
            let billUserRef = self.ref.child("groups/\(groupName)/bills/\(key)/users/\(userID)");
            let paid = ["paid":false]
            billUserRef.updateChildValues(paid)
        }
        
        for email in userEmails{
            sendEmailNotification(email, self.amountTextField.text!,self.titleTextField.text!);
        }
        
        //Toast to notify all users
        self.view.makeToast("Notified users")
        

        tabOne.refreshTable()
        addBillView.removeFromSuperview();
    }
    func sendEmailNotificationForAllBills(_ email : String){
        var url : String = "http://ec2-54-212-232-252.us-west-2.compute.amazonaws.com/form.php?email=\(email)"
        var index = 0;
        for bill in tabOne.bills{
            url += "&arr\(index)=\(bill.title)%20:%20$\(Double(bill.amount)!/Double(userEmails.count))%20,%20due%20on%20\(bill.dueDate)"
            index += 1
        }
        url += "&ios=hello&count=\(tabOne.bills.count)"
        url = url.replacingOccurrences(of: " ", with: "%20")
        let req = NSMutableURLRequest(url: NSURL(string:url)! as URL)
        req.httpMethod = "GET"
        req.httpBody = "key=\"value\"".data(using: String.Encoding.utf8) //This isn't for GET requests, but for POST requests so you would need to change `HTTPMethod` property
        URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            if error != nil {
                //Your HTTP request failed.
                print(error?.localizedDescription)
            } else {
                //Your HTTP request succeeded
                print(response)
            }
            }.resume()
        

    }
    //send emails to all users
    func sendEmailNotification(_ email : String, _ amount : String, _ title : String){
        let userDetails : [String : String] = SessionManager().getUserDetails();
        let name = userDetails["name"];
        let req = NSMutableURLRequest(url: NSURL(string:"http://ec2-54-212-232-252.us-west-2.compute.amazonaws.com/form.php?email=\(email)&bill_amount=\(amount)&ios=yes&bill_title=\(title)&from=\(name!)")! as URL)
        req.httpMethod = "GET"
        req.httpBody = "key=\"value\"".data(using: String.Encoding.utf8) //This isn't for GET requests, but for POST requests so you would need to change `HTTPMethod` property
        URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            if error != nil {
                //Your HTTP request failed.
                print(error?.localizedDescription)
            } else {
                //Your HTTP request succeeded
                print("success")
            }
            }.resume()
        
    }
    
    // function to add a subview to be able to add a chore
    func addBill()  {
        self.view.addSubview(addBillView)
        constrainAddBillView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firebaseRef : DatabaseReference! = Database.database().reference()
        let sessionManager = SessionManager()

        dateFormatter.dateFormat = "dd MMM yyyy";
        self.edgesForExtendedLayout = []
        
        // Do any additional setup after loading the view.
        self.delegate = self;
        self.userEmails.removeAll()
        
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let name = value["email"];
                    if(name != nil){
                        self.userEmails.append(name as! String);
                    }
                }
            }
        })
        
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
        floaty.addItem("Notify users ", icon: UIImage.fontAwesomeIcon(name: .bullhorn, textColor: UIColor.black, size: CGSize(width: 30, height: 30)), handler: { item in
            self.notifyAllUsers();
            floaty.close()
        })
        
        self.view.addSubview(floaty)
        self.viewControllers = [tabOne, tabTwo]
    }
    
    func notifyAllUsers(){
        for email in userEmails {
            sendEmailNotificationForAllBills(email);
        }
        self.view.makeToast("Notified users")
        
    }
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
    
}

class TabOneViewController: UITableViewController {
    let dateFormatter = DateFormatter()
    let kCloseCellHeight: CGFloat = 75
    let kOpenCellHeight: CGFloat = 160
    var kRowsCount = 10
    var cellHeights: [CGFloat] = []
    var firebaseRef : DatabaseReference!
    let sessionManager = SessionManager()
    // Array to contain chores
    var bills: [Bill] = []
    var users: [String] = []
    var usersID : [String] = []
    
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

    
    func refreshTable() {
        dateFormatter.dateFormat = "dd MMM yyyy";
        self.bills.removeAll()
        self.users.removeAll()
        
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let name = value["name"];
                    if(name != nil){
                        self.users.append(name as! String);
                        self.usersID.append(key as! String);
                    }
                }
            }
        })
        firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    let bill = Bill(dueDate : value["due"]! as! String, amount : value["amount"] as! String, frequency : value["frequency"] as! String, title : value["title"] as! String,paid: false, id: key as! String)
                    let calendar = NSCalendar.current
                    if(bill.frequency == "every month"){
                        var dueDate = self.dateFormatter.date(from: bill.dueDate);
                        let currentDate = Date()
                        let monthOfDueDate = calendar.component(.month, from: dueDate!)
                        let monthOfCurrentDate = calendar.component(.month, from: currentDate )
                        let distance : Int = monthOfCurrentDate - monthOfDueDate;
                        if(distance > 0){
                            for _ in 1...distance {
                                dueDate = calendar.date(byAdding: Calendar.Component.month, value: 1, to: dueDate!)
                            }
                        }
                        if(currentDate > dueDate!){
                            bill.overdue = true;
                        }else{
                            bill.dueDate = self.dateFormatter.string(from: dueDate!)
                            self.bills.append(bill);
                        }
                    }else{
                        var dueDate = self.dateFormatter.date(from: bill.dueDate);
                        let currentDate = Date()
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
                        }else{
                            bill.dueDate = self.dateFormatter.string(from: dueDate!)
                            self.bills.append(bill);
                        }
                    }
                }
            }
            
            self.kRowsCount = self.bills.count
            self.tableView.reloadData()
            self.setup()
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
    
    // MARK: Button Action
    func payButtonPressed(_ button: UIButton) {
        
        let billID = button.title(for: UIControlState.disabled)!;
        let billRef = firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills/\(billID)/users/\(sessionManager.getUserDetails()["userID"]!)")
        let paid = ["paid" : true]
        billRef.updateChildValues(paid);
        button.setTitle("Paid", for: UIControlState.normal)
        button.backgroundColor = UIColor(hexString: "#98FB98")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.foregroundView.subviews.forEach({ $0.removeFromSuperview() })
        cell.containerView.subviews.forEach({ $0.removeFromSuperview() })
        
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
            txt.backgroundColor = UIColor(hexString: "#00CD66")
            txt.textColor = UIColor(hexString: "#8E8E93");
            return txt
        }()
        let button:UIButton = {
            let but = UIButton()
            
            var paid : Bool = false;
            firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills/\(bills[indexPath.row].id)/users/\(sessionManager.getUserDetails()["userID"]!)").observeSingleEvent(of: .value, with: { (snap) in
                if let values = snap.value as? NSDictionary {
                    print(values["paid"] as! Bool)
                    paid = values["paid"] as! Bool
                }
                if(paid){
                    self.bills[indexPath.row].paid = true;
                    but.setTitle("Paid", for: UIControlState.normal)
                    but.backgroundColor = UIColor(hexString: "#98FB98")
                }else{
                    but.setTitle("Pay", for: UIControlState.normal)
                    but.backgroundColor = UIColor(hexString: "#CD3700")
                }
            })
            but.layer.cornerRadius = 10;
            but.translatesAutoresizingMaskIntoConstraints = false
            but.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
            but.setTitle(self.bills[indexPath.row].id, for: UIControlState.disabled)
            but.addTarget(self, action: #selector(self.payButtonPressed(_:)), for: .touchUpInside)
            return but
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
        cell.containerView.addSubview(stackView)
        cell.containerView.backgroundColor = UIColor(hexString:"#e74c3c");
        cell.containerView.addSubview(button)

        stackView.topAnchor.constraint(equalTo: cell.containerView.topAnchor, constant: 5).isActive = true;
        stackView.leftAnchor.constraint(equalTo: cell.containerView.leftAnchor, constant: 5).isActive = true;
        stackView.rightAnchor.constraint(equalTo: cell.containerView.rightAnchor, constant: 5).isActive = true;
        
        button.bottomAnchor.constraint(equalTo: cell.containerView.bottomAnchor, constant: -10).isActive = true;
        button.leftAnchor.constraint(equalTo: cell.containerView.leftAnchor, constant: 1).isActive = true;
        button.rightAnchor.constraint(equalTo: cell.containerView.rightAnchor, constant: 1).isActive = true;
        
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
    public var paid : Bool;
    public var id : String;
    init(dueDate : String, amount : String, frequency : String, title : String, paid : Bool, id : String) {
        self.dueDate = dueDate;
        self.amount = amount;
        self.frequency = frequency;
        self.title = title;
        self.overdue = false;
        self.paid = paid;
        self.id = id;
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
                    var paid : Bool = false;
                    self.firebaseRef.child("groups/\(self.sessionManager.getUserDetails()["groupName"]!)/bills/\(key)/users/\(self.sessionManager.getUserDetails()["userID"]!)").observeSingleEvent(of: .value, with: { (snap) in
                        if let values1 = snap.value as? NSDictionary {
                            paid = values1["paid"] as! Bool
                        }
                        if(!paid){
                            let bill = Bill(dueDate : value["due"]! as! String, amount : value["amount"] as! String, frequency : value["frequency"] as! String, title : value["title"] as! String, paid: false, id : key as! String)
                            let calendar = NSCalendar.current
                            if(bill.frequency == "every month"){
                                var dueDate = self.dateFormatter.date(from: bill.dueDate);
                                let currentDate = Date()
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
                                let currentDate = Date()
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
                        self.tableView.reloadData()
                    })
                }
            }
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(hexString: "#FF3B3F")
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let billRef = firebaseRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills/\(bills[indexPath.row].id)/users/\(sessionManager.getUserDetails()["userID"]!)")
            let paid = ["paid" : true]
            billRef.updateChildValues(paid);
            self.tableView.beginUpdates()
            self.bills.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.tableView.endUpdates()
            self.tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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


