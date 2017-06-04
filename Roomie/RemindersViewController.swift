//
//  RemindersViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 6/4/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let bills = [["title":"rent","amountDue":"500","dueDate":"10 Jun 2017","creator":"show"],["title":"tv","amountDue":"70","dueDate":"07 Jun 2017","creator":"show"],["title":"internet","amountDue":"700","dueDate":"09 Jun 2017","creator":"show"],["title":"phone","amountDue":"800","dueDate":"11 Jun 2017","creator":"show"],["title":"extra","amountDue":"50","dueDate":"07 Jun 2017","creator":"show"]]
    
    let chores = [["title":"clean","amountDue":"500","dueDate":"10 Jun 2017","creator":"show"],["title":"dog","amountDue":"70","dueDate":"07 Jun 2017","creator":"show"],["title":"bro","amountDue":"700","dueDate":"09 Jun 2017","creator":"show"],["title":"sis","amountDue":"800","dueDate":"11 Jun 2017","creator":"show"],["title":"extra","amountDue":"50","dueDate":"07 Jun 2017","creator":"show"]]
    
    let reminderTableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return  bills.count
        }
        else {
            return chores.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        if indexPath.section == 0{
            let dueDateLabelOnCell:UILabel = {
                let label = UILabel()
                label.textAlignment = NSTextAlignment.right
                label.textColor = UIColor.white
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            dueDateLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
            dueDateLabelOnCell.text = "Due on: " + bills[indexPath.row]["dueDate"]!
            cell.addSubview(dueDateLabelOnCell)
            dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.textLabel?.topAnchor)!).isActive = true
            dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -5).isActive = true
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = bills[indexPath.row]["title"]
            cell.detailTextLabel?.text = "$"+bills[indexPath.row]["amountDue"]!
        }
        if indexPath.section == 1{
//            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = chores[indexPath.row]["title"]
        }

        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Upcoming bills"
        }
        else {
            return "Upcoming chores"
        }
        
    }
    
    func constrainRemindersTableView() {
        reminderTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        reminderTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 141/255.0, green:172/255.0 , blue: 154/255.0 ,alpha:1)
        view.addSubview(reminderTableView)
        constrainRemindersTableView()
        self.reminderTableView.backgroundColor = UIColor(red: 141/255.0, green:172/255.0 , blue: 154/255.0 ,alpha:1)
        self.reminderTableView.tableFooterView = UIView()
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
