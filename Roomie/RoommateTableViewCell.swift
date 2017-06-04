//
//  roommateTableViewCell.swift
//  Roomie
//
//  Created by iGuest on 6/3/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit
import Firebase

class RoommateTableViewCell: UITableViewCell {
    
    let rootRef = Database.database().reference()
    let storageRef = Storage.storage(url: "gs://checkmateios-d1800.appspot.com").reference()
    let sessionManager = SessionManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configImage(userID: String) {
        // Create a reference to the file you want to download
        let starsRef = storageRef.child("image/\(userID).jpg")
        
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                self.imageView?.image = self.imageWithImage(image: UIImage(named: "User.png")!, scaledToSize: CGSize(width: 30, height: 30))
                print(error)
                return
            }
            self.loadImageUsingCacheWithUrlString(urlString: (url?.absoluteString)!)
        }
        
    }
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!)
                self.imageView?.image = self.imageWithImage(image: UIImage(named: "User.png")!, scaledToSize: CGSize(width: 30, height: 30))
                return
            }
            DispatchQueue.main.async(execute: {
                self.imageView?.image = self.imageWithImage(image: UIImage(data: data!)!, scaledToSize: CGSize(width: 30, height: 30))
            })
        }).resume()
    }
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }

}
