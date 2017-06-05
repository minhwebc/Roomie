//
//  Extension.swift
//  Roomie
//
//  Created by iGuest on 6/4/17.
//  Copyright © 2017 Muhaamed Drammeh. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {
    
    
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        if let downloadImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = downloadImage
        }
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async(execute: {
                    let image = UIImage(named: "User.png")
                    imageCache.setObject(image!, forKey: urlString as AnyObject)
                    self.image = image
                })
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(UIImage(data: data!)!, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            })
        }).resume()
    }

}
