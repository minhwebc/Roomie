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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.edgesForExtendedLayout = []
        
        // Do any additional setup after loading the view.
        self.delegate = self;
        let floaty = Floaty()
        
        floaty.addItem("I got a handler", icon: UIImage.fontAwesomeIcon(name: .plus, textColor: UIColor.black, size: CGSize(width: 30, height: 30)), handler: { item in
            let alert = UIAlertController(title: "Hey", message: "Add a bill", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            floaty.close()
        })
//        floaty.translatesAutoresizingMaskIntoConstraints = false
    
        self.view.addSubview(floaty)
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
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
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
