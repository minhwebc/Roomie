//
//  User.swift
//  Roomie
//
//  Created by Quan Nguyen on 5/24/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

class User: NSObject {
    public var name : String;
    public var email : String;
    public var password : String;
    
    init(name : String, email : String, password : String) {
        self.name = name;
        self.email = email;
        self.password = password;
    }
}
