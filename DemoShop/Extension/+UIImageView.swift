//
//  +UIImage.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSURL,UIImage>.init()

extension UIImage {
    
    static func load(url : URL ,completion : @escaping (UIImage , String)->Void )->URLSessionDataTask?{
        
        if let image = imageCache.object(forKey: url as NSURL) {
            completion(image ,url.description)
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(UIImage.init(named: "placeholder")! , "")
            if let data = data{
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url as NSURL )
                    completion(image ,url.description)
                }
            }
            
        }
        
        task.resume()
        return task
        
    }
    
}
