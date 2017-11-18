//
//  extensions.swift
//  chatMessage2
//
//  Created by Mo Omar on 8/3/17.
//  Copyright © 2017 Moomar. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {
    func loadImagesUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        // chech cache for image first
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
            
        }
        
        
        //otherWise new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downLoadedimage = UIImage(data: data!) {
                    imageCache.setObject(downLoadedimage, forKey: urlString as AnyObject)
                    self.image = downLoadedimage
                }
            }
        }).resume()
    }
}
