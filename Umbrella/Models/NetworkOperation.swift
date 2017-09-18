//
//  NetworkOperation.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation
import UIKit

enum NetworkResult {
    case success([String : AnyObject])
    case error(NSError)
}

class NetworkOperation {
    
    lazy var config: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.config)
    let queryURL: URL
    var errorMsg: String?
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> String
    
    init(url: URL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(_ completion: @escaping (_ result: NetworkResult) -> Void) -> Void {
        
  
        let request: URLRequest = URLRequest(url: queryURL)
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
         
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                    case 200 :
                        do {
                            
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                            completion(NetworkResult.success(jsonDictionary))
                        } catch let error {
                            print("JSON Serialization failed. Error: \(error)")
                        }
                    default:
                        print("GET request not successful.  HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                completion(NetworkResult.error(error! as NSError))
            }
        }) 
        
        
        dataTask.resume()
        
    }
    
}
