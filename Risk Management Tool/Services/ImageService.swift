//
//  ImageService.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 23/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(url:URL, completion: @escaping (_ image:UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var image:UIImage?
            
            if let data = data {
                image = UIImage(data: data)
            }
            
            if image != nil {
                cache.setObject(image!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }
        
        dataTask.resume()
    }
    
    static func getImage(url:URL, completion: @escaping (_ image:UIImage?)->()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(url: url, completion: completion)
        }
    }
}
