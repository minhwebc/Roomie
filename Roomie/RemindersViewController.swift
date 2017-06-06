//
//  RemindersViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 6/4/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class RemindersViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let rootRef = Database.database().reference()
    let storageRef = Storage.storage(url: "gs://checkmateios-d1800.appspot.com").reference()
    let sessionManager = SessionManager()
    var userID: String = ""

    
    ////////////////////
    //////
    // Sample data to display
    var bills = [["title":"rent","amountDue":"500","dueDate":"10 Jun 2017","creator":"show"],["title":"tv","amountDue":"70","dueDate":"07 Jun 2017","creator":"show"],["title":"internet","amountDue":"700","dueDate":"09 Jun 2017","creator":"show"],["title":"phone","amountDue":"800","dueDate":"11 Jun 2017","creator":"show"],["title":"extra","amountDue":"50","dueDate":"07 Jun 2017","creator":"show"]]
    
    var chores = [["title":"clean","dueDate":"10 Jun 2017","creator":"show","assignee":"Bro"],["title":"dog","dueDate":"07 Jun 2017","creator":"show","assignee":"Bro"],["title":"bro","dueDate":"09 Jun 2017","creator":"show","assignee":"Bro"],["title":"sis","dueDate":"11 Jun 2017","creator":"show","assignee":"Bro"],["title":"extra","dueDate":"07 Jun 2017","creator":"show","assignee":"Bro"]]
    
    // table view to display data
    let reminderTableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    ////////////////////
    //////
    // Setup TableVieew
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
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let dueDateLabelOnCell:UILabel = {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.right
            label.textColor = UIColor.white
            label.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        cell.addSubview(dueDateLabelOnCell)
        dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.textLabel?.topAnchor)!).isActive = true
        dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -5).isActive = true
        
        // cells for bills
        if indexPath.section == 0{
            dueDateLabelOnCell.text = "Due on: " + bills[indexPath.row]["dueDate"]!
            cell.textLabel?.text = bills[indexPath.row]["title"]
            cell.detailTextLabel?.text = "$"+bills[indexPath.row]["amountDue"]!
        }
        // cells for chores
        if indexPath.section == 1{
            let assigneeLabelOnCell:UILabel = {
                let label = UILabel()
                label.textAlignment = NSTextAlignment.right
                label.textColor = UIColor.white
                label.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)!)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            cell.addSubview(assigneeLabelOnCell)
            assigneeLabelOnCell.topAnchor.constraint(equalTo: (cell.detailTextLabel?.topAnchor)!).isActive = true
            assigneeLabelOnCell.rightAnchor.constraint(equalTo: dueDateLabelOnCell.rightAnchor).isActive = true
            
            cell.textLabel?.text = chores[indexPath.row]["title"]
            dueDateLabelOnCell.text = "Due on: " + chores[indexPath.row]["dueDate"]!
            assigneeLabelOnCell.text = "Assigned to : " + chores[indexPath.row]["assignee"]!
            cell.detailTextLabel?.text = "Created by: "+chores[indexPath.row]["creator"]!
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
    
    // constrain table view
    func constrainRemindersTableView() {
        reminderTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        reminderTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    // Method to sort the an Array by dueDate
    func sortArrayByDueDate(arrayObj:inout [ Dictionary<String, String>]) {
        var array:[Date] = []
        var array2 : [String] = []
        for i in arrayObj{
            let isoDate = i["dueDate"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date = dateFormatter.date(from:isoDate!)!
            array.append(date)
            
        }
        let ready = array.sorted(by: { $0.compare($1) == .orderedAscending })
        for i in ready{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let now = dateFormatter.string(from: i)
            array2.append(now)
        }
        
        if array2.count < 1 {
            return
        }
        
        for i in 0...array2.count-1{
            for j in 0...arrayObj.count-1{
                if arrayObj[j]["dueDate"] == array2[i]{
                    let obj = arrayObj[j]
                    arrayObj.remove(at: j)
                    arrayObj.insert(obj, at: i)
                }
            }
        }
        
    }

    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM yyyy"
        initChoresData()
        
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 141/255.0, green:172/255.0 , blue: 154/255.0 ,alpha:1)
        view.addSubview(reminderTableView)
        constrainRemindersTableView()
        self.reminderTableView.backgroundColor = UIColor(red: 141/255.0, green:172/255.0 , blue: 154/255.0 ,alpha:1)
        self.reminderTableView.tableFooterView = UIView()
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        
        // sorting by date
        sortArrayByDueDate(arrayObj: &bills)
        sortArrayByDueDate(arrayObj: &chores)
    }
    
    let na = "N/A"
    func initChoresData() {
        // ["title":"clean","dueDate":"10 Jun 2017","creator":"show","assignee":"Bro"]
        chores.removeAll()
        
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/chores").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                for key in values.allKeys{
                    let value = values[key] as! NSDictionary
                    if self.dateFormatter.date(from: value["due_on"] as! String)!.compare(Date()) == .orderedDescending {
                        let dict = ["title": value["title"],"desc": value["description"],"creator":"\(value["creator"]!)","assignee":"\(value["assignTo"] ?? self.na)","dueDate":"\(value["due_on"]!)", "id": "\(key)", "creatorID": "\(value["creatorID"]!)", "assigneeID": "\(value["assigneeID"] ?? self.na)"]
                        self.chores.append(dict as! [String : String])
                    }
                    self.reminderTableView.reloadData()
                }
            }
        })

    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}