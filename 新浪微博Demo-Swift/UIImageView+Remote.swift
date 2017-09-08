//
//  UIImageView+Remote.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/6.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

let kSession = "session"
let kDataTask = "dataTask"
let kCachedImages = "cachedImages"

extension UIImageView
{
    private var session: URLSession?
    {
        set
        {
            objc_setAssociatedObject(self, kSession, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return objc_getAssociatedObject(self, kSession) as? URLSession
        }
    }
    
    private var dataTask: URLSessionDataTask?
    {
        set
        {
            objc_setAssociatedObject(self, kDataTask, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get
        {
            return objc_getAssociatedObject(self, kDataTask) as? URLSessionDataTask
        }
    }
    
    private func imageExists(name: String) ->Bool
    {
        var exists = false
        
        let imagePath = pathOfImage(name: name)
        if FileManager.default.fileExists(atPath: imagePath)
        {
            exists = true
        }
        return exists
    }
    
    private func pathOfImage(name: String) -> String
    {
        var path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        path = path.appending("/\(kCachedImages)")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path)
        {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
        path = path.appending("/\(name)")
        return path
    }
    
    private func generateImageName(url: String) -> String
    {
        var imageName = url.replacingOccurrences(of: "/", with: "")
        imageName = imageName.replacingOccurrences(of: "//", with: "")
        imageName = imageName.replacingOccurrences(of: ":", with: "")
        return imageName
    }
    
    private func saveImage(data: Data, toPath path: String) -> Bool
    {
        return FileManager.default.createFile(atPath: path, contents: data)
    }
    
    func setImage(url: String, placeHolder: String?)
    {        
        dataTask?.cancel()
        session?.invalidateAndCancel()
        
        let imageName = generateImageName(url: url)
        if imageExists(name: imageName)
        {
            DispatchQueue.global().async {[unowned self] in
                let imagePath = self.pathOfImage(name: imageName)
                let cachedImage = UIImage(contentsOfFile: imagePath)
                DispatchQueue.main.async {[unowned self] in
                    self.image = cachedImage
                }
            }
        }
        else
        {
            if let theName = placeHolder
            {
                image = UIImage(named: theName)
            }
        }
        
        session = URLSession(configuration: URLSessionConfiguration.default)
        dataTask = session?.dataTask(with: URL(string: url)!, completionHandler: {[unowned self] (data, response, error) in
            if let theRes = response, let theData = data
            {
                if (theRes as? HTTPURLResponse)?.statusCode == 200
                {
                    let _ = self.saveImage(data: theData, toPath: self.pathOfImage(name: imageName))
                    let image = UIImage(data: theData)
                    DispatchQueue.main.async {[unowned self] in
                        self.image = image
                    }
                }
            }
        })
        dataTask?.resume()
    }
}
