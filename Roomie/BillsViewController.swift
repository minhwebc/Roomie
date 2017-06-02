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

        
        dropDown.dataSource = ["every day", "every month", "every week", "every two weeks"]
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
        addBillView.removeFromSuperview();
    }
    
    // function to add a subview to be able to add a chore
    func addBill()  {
        self.view.addSubview(addBillView)
        constrainAddBillView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        let tabOne = TabOneViewController()
        let tabOneBarItem = UITabBarItem();
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

class TabOneViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 238/255.0, green:163/255.0 , blue: 163/255.0 ,alpha:1)
        self.title = "Current Bills"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class TabTwoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        self.title = "Past Due Bills"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
