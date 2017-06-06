//
//  ProfileViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    ////////////////////////////
    //////////////
    //// Define UI elements
    let dateFormatter = DateFormatter()
    // this is just sample data for testing purposes
    var chores: [Dictionary<String,String>] = [["title":"clean bath room","creator":"Mo","dueDate":"29 May 2017"],["title":"clean bath room","creator":"Mo","dueDate":"29 May 2017"],["title":"clean bath room","creator":"Mo","dueDate":"29 May 2017"],["title":"clean bath","creator":"Mo","dueDate":"29 May 2017"],["title":"clean room","creator":"Mo","dueDate":"29 May 2017"],["title":"bath room","creator":"Mo","dueDate":"29 May 2017"]]
    var group = ["Mo","Quan","Fan","Victoria"]
    var groceries: [Dictionary<String,String>] = [["title":"meat","creator":"Mo","amount":"13"],["title":"vege","creator":"Mo","amount":"4"],["title":"fish","creator":"Mo","amount":"11"]]
    var bills = ["rent","light","water","sewage","tv","internet"]
    
    let rootRef = Database.database().reference()
    let storageRef = Storage.storage(url: "gs://checkmateios-d1800.appspot.com").reference()
    let sessionManager = SessionManager()
    var userID: String = ""
    
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let name = UILabel()
        name.text = "username"
        name.font = UIFont(name: name.font.fontName, size: 30)
        name.textColor = UIColor.white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let profileTableView:UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ////////////////////////////
    //////////////
    //// Constrain UI Elements
    
    func constrainProfileImageView() {
        profileImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 10).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        
        // add tap Gesture for profile picture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func constrainProfileTableView()  {
        profileTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        profileTableView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        profileTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
    // UserName Label
    func constrainNameLabel() {
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor ,constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
    }
    
    ////////////////////////////
    //////////////
    //// Table view Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return  chores.count
        }
        if section == 1{
            return   group.count
        }
        if section == 2{
            return bills.count
        }
        else {
            return groceries.count
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
            dueDateLabelOnCell.text = chores[indexPath.row]["dueDate"]!
            cell.addSubview(dueDateLabelOnCell)
            dueDateLabelOnCell.topAnchor.constraint(equalTo: (cell.textLabel?.topAnchor)!).isActive = true
            dueDateLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = chores[indexPath.row]["title"]
            cell.detailTextLabel?.text = chores[indexPath.row]["creator"]!
        }
        if indexPath.section == 1{
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = group[indexPath.row]
        }
        if indexPath.section == 2{
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = bills[indexPath.row]
        }
        if indexPath.section == 3{
            let amountLabelOnCell:UILabel = {
                let label = UILabel()
                label.textAlignment = NSTextAlignment.right
                label.textColor = UIColor.white
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            amountLabelOnCell.font = UIFont(name: (cell.detailTextLabel?.font.fontName)!, size: (cell.detailTextLabel?.font.pointSize)! + 4)
            amountLabelOnCell.text = "$ " + groceries[indexPath.row]["amount"]!
            print("amount is \(groceries[indexPath.row]["amount"]!) ")
            cell.addSubview(amountLabelOnCell)
            amountLabelOnCell.topAnchor.constraint(equalTo: (cell.textLabel?.topAnchor)!).isActive = true
            amountLabelOnCell.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -15).isActive = true
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.textLabel?.text = groceries[indexPath.row]["title"]
            cell.detailTextLabel?.text = groceries[indexPath.row]["creator"]!
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "My Roommates"
        }
        if section == 1{
            return   "My Chores"
        }
        if section == 2{
            return "My Bills"
        }
        else {
            return "My Grocecies"
        }
        
    }
    
    ////////////////////////////
    //////////////
    //// Profile picture functions
    
    // Tab profile image to change image
    func imageTapped(gesture: UIGestureRecognizer) {
        print("Image view tabbed")
        let image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = false
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                image.sourceType = UIImagePickerControllerSourceType.camera
                self.present(image, animated: true)
            }else{
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(image, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    // after image has been selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImageFromPicker = image
        }else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = image
        }
        
        if let selectImage = selectedImageFromPicker {
            profileImageView.image = selectImage
            
            let imgRef = storageRef.child("image/\(userID).jpg")
            let imageData = UIImagePNGRepresentation(selectImage)!
            
            imgRef.putData(imageData, metadata: nil) { metadata, error in
                if let _ = error {
                    print("Error happened while uploading!")
                }
            }
            
            imgRef.downloadURL { url, error in
                if let error = error {
                    // Handle any errors
                    print(error)
                    return
                }
                self.saveProfileURL(url: (url?.absoluteString)!)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveProfileURL(url: String) {
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/users/\(userID)/profileImageURL").setValue(url)
    }
    
    
    ////////////////////////////
    //////////////
    //// View did load to call major functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = sessionManager.getUserDetails()["userID"]!
        nameLabel.text = sessionManager.getUserDetails()["name"]
        
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 45/255.0, green:35/255.0 , blue: 53/255.0 ,alpha:1)
        self.profileTableView.backgroundColor = UIColor(red: 45/255.0, green:35/255.0 , blue: 53/255.0 ,alpha:1)
        self.view.addSubview(profileImageView)
        self.view.addSubview(nameLabel)
        
        initChoresData()
        initBillData()
        initGroceryData()
        constrainProfileImageView()
        constrainNameLabel()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
        self.view.addSubview(profileTableView)
        constrainProfileTableView()
    }
    
    func initBillData(){
        //["title":"rent","amountDue":"500","dueDate":"10 Jun 2017","creator":"show"]
        bills.removeAll();
        dateFormatter.dateFormat = "dd MMM yyyy"
        rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)/bills").observeSingleEvent(of: .value, with: { (snap) in
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
                            self.bills.append(bill.title);
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
                            self.bills.append(bill.title);
                        }
                    }
                }
            }
            self.profileTableView.reloadData()
        })
    }
    
    func initChoresData() {
        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
        
        // fetch user data
        groupRef.child("users").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                self.group.removeAll()
                self.chores.removeAll()
                for key in values.allKeys{
                    if let value = values[key] as? NSDictionary {
                        if let name = value["name"] as? String {
                            self.group.append(name)
                        }
                        // fetch chore data
                        if key as! String == self.userID, let chores = value["chores"] as? NSDictionary{
                            
                            // fetch profile image
                            self.profileImageView.loadImageUsingCacheWithUrlString(urlString:  "\(value["profileImageURL"] ?? "")")
                            
                            // ["title":"clean bath room","creator":"Mo","dueDate":"29 May 2017"]
                            for ckey in chores.allKeys {
                                let chore = chores[ckey] as! NSDictionary
                                let dict = ["title": chore["title"] ?? "","creator":chore["creator"] ?? "","dueDate":chore["due_on"] ?? ""]
                                self.chores.append(dict as! [String: String])
                            }
                        }
                    }
                }
                self.profileTableView.reloadData()
            }
            else {
                print("user list is empty!")
                return
            }
        })
    }
    
    func initGroceryData() {
        let groupRef = rootRef.child("groups/\(sessionManager.getUserDetails()["groupName"]!)")
        
        // fetch user data
        groupRef.child("users").observeSingleEvent(of: .value, with: { (snap) in
            if let values = snap.value as? NSDictionary {
                self.group.removeAll()
                self.groceries.removeAll()
                for key in values.allKeys{
                    if let value = values[key] as? NSDictionary {
                        if let name = value["name"] as? String {
                            self.group.append(name)
                        }
                        if key as! String == self.userID, let groceries = value["grocery"] as? NSDictionary{
                            
                            self.profileImageView.loadImageUsingCacheWithUrlString(urlString:  "\(value["profileImageURL"] ?? "")")

                            for ckey in groceries.allKeys {
                                let grocery = groceries[ckey] as! NSDictionary
                                let dict = ["title": grocery["title"] ?? "","creator":grocery["creator"] ?? "","amount":grocery["amount"] ?? ""]
                                self.groceries.append(dict as! [String: String])
                            }
                        }
                    }
                }
                self.profileTableView.reloadData()
            }
            else {
                print("user list is empty!")
                return
            }
        })
    }
    
}
