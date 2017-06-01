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

class BillsViewController: UITabBarController, UITabBarControllerDelegate {

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
    
    // Title of bill TextField
    let titleTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Title", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // Title of bill TextField
    let amountTextField:UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string:"Amount", attributes:[NSForegroundColorAttributeName: UIColor.lightGray])
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
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
        
        constrainSaveButton()
        constrainCancelButton()
        constrainAmountTextField()
        constrainTitleTextField()
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
        amountTextField.topAnchor.constraint(equalTo: addBillView.topAnchor, constant: 40).isActive = true
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
        titleTextField.topAnchor.constraint(equalTo: addBillView.topAnchor, constant: 40).isActive = true
    }
    
    func handleCancel() {
        titleTextField.text = ""
        self.addBillView.removeFromSuperview()
    }
    
    func handleSave(){
        print("save bill here");
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
        
//        floaty.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true
//        floaty.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
//        floaty.widthAnchor.constraint(equalToConstant: 10).isActive = true
//        floaty.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
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
