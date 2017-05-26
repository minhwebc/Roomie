//
//  ChoresViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class ChoresViewController: UIViewController {
    
    let addChoreView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
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
    
    func constrainAddChoreView() {
        addChoreView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addChoreView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        addChoreView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -150).isActive = true
        addChoreView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -80).isActive = true
        addChoreView.addSubview(cancelButton)
        addChoreView.addSubview(saveButton)
        constrainSaveButton()
        constrainCancelButton()
    }
    
    func constrainSaveButton() {
        saveButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        saveButton.rightAnchor.constraint(equalTo: addChoreView.rightAnchor, constant:-20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: addChoreView.bottomAnchor, constant: -20).isActive = true
    }
    
    
    func constrainCancelButton() {
        cancelButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addChoreView.leftAnchor,constant:20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addChoreView.bottomAnchor, constant: -20).isActive = true
        cancelButton.addTarget(self, action: #selector (handleCancel), for: .touchUpInside)
    }
    
    func addChore()  {
        print("Hello")
        self.view.addSubview(addChoreView)
        constrainAddChoreView()
        
    }
    
    func handleCancel() {
        //        UIView.transition(with: self.addChoreView, duration: 0.5, options: UIViewAnimationOptions.,
        //                          animations: nil, completion: { _ in
        //        self.addChoreView.removeFromSuperview()
        //        })
        self.addChoreView.removeFromSuperview()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red: 233/255.0, green:92/255.0 , blue: 111/255.0 ,alpha:1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChore))
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
