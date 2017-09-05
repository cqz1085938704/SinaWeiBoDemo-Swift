//
//  HttpRequest.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/5.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

class HttpRequest
{
    class func request(urlString: String?, method: String!) -> URLRequest?
    {
        var request: URLRequest? = nil
        if let theUrl = urlString
        {
            let url = URL(string: theUrl)
            request = URLRequest(url: url!)
            
            if method == "POST"
            {
                request?.httpMethod = method
            }
        }
        return request
    }
    
    class func get(url: String?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
    {
        let request = self.request(urlString: url, method: "GET")
        self.createTask(request: request!, completionHandler: completionHandler)
    }
    
    class func post(url: String?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
    {
        let request = self.request(urlString: url, method: "POST")
        self.createTask(request: request!, completionHandler: completionHandler)
    }
    
    class func createTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
    {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
}
