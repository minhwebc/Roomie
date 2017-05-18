//
//  HomeViewController.swift
//  Roomie
//
//  Created by Muhaamed Drammeh on 5/18/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //////////////////////////////////////////
    /////////////////////////
    ////// SET UP THE BUTTONS TO CLICK AND GO TO OTHER VIEWS
    let ButtonsContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    func setupButtonsContainer() {
        // contraint inputContainer
        ButtonsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ButtonsContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ButtonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ButtonsContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

    }

    
    let choreButton:UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("Chores", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupChoreButton() {
        choreButton.leftAnchor.constraint(equalTo: ButtonsContainer.leftAnchor).isActive = true
        choreButton.topAnchor.constraint(equalTo: ButtonsContainer.topAnchor).isActive = true
        choreButton.widthAnchor.constraint(equalTo: ButtonsContainer.widthAnchor, multiplier: 1/2).isActive = true
        choreButton.heightAnchor.constraint(equalTo: ButtonsContainer.heightAnchor, multiplier: 1/3).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = UIColor.blue
        view.addSubview(ButtonsContainer)
        setupButtonsContainer()
        ButtonsContainer.addSubview(choreButton)
        setupChoreButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
