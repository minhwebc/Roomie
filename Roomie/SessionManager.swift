//
//  SessionManager.swift
//  Roomie
//
//  Created by Quan Nguyen on 5/24/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

//Session manager use to keep track of user session
class SessionManager: NSObject {
    public static var loggedIn : Bool = false;
    
    //public variable to have a uniform way of accessing user details
    public var groupName : String = "groupName";
    public var userName : String = "userName";
    public var userID : String = "userID";
    public var userEmail : String = "userEmail";
    
    //return whether or not the user is logged in
    public func isLoggedIn() -> Bool{
        return SessionManager.loggedIn;
    }
    
    
    //Get back user information such as their group, their name, their email and their ID on firebase
    public func getUserDetails() -> [String: String]{
        var details = [String : String]();
        details[self.groupName] = UserDefaults.standard.string(forKey: self.groupName)
        details[self.userName] = UserDefaults.standard.string(forKey: self.userName)
        details[self.userID] = UserDefaults.standard.string(forKey: self.userID)
        details[self.userEmail] = UserDefaults.standard.string(forKey: self.userEmail)
        return details;
    }
    
    //insert user info into shared preference
    public func insertUserDetails(_ groupName : String, _ userName : String, _ email : String, _ id : String){
        UserDefaults.standard.set(groupName, forKey: self.groupName)
        UserDefaults.standard.set(userName, forKey: self.userName)
        UserDefaults.standard.set(email, forKey: self.userEmail)
        UserDefaults.standard.set(id, forKey: self.userID)
    }
    
    //If user logged in, updated the state
    public func userLoggedIn(){
        SessionManager.loggedIn = true;
    }
    
    public func userLoggedOut(){
        SessionManager.loggedIn = false;
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }

}
