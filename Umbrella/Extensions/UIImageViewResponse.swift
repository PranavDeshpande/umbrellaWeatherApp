//
//  UIImageViewResponse.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadFromURL(_ URL:String, contentMode mode: UIViewContentMode) {
        
      
        guard
            let url = Foundation.URL(string: URL)
            else {return}
        
      
        contentMode = mode
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let dataTask = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard
              
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data, error == nil,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
               
                self.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
            
        }) 
        
      
        dataTask.resume()
        
    }
}
