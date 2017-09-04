//
//  UserModel.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/4.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

class UserModel: NSObject
{
    var imageURL: String? = nil
    var title: String? = nil
    
    init?(_ infoDic: NSDictionary)
    {
        let user = infoDic["user"] as? NSDictionary
        var image = user?["profile_image_url"] as? String
        image = image?.replacingOccurrences(of: " ", with: "")
        imageURL = image
        title = infoDic["text"] as? String
    }
    
    class func getAllUserModels(_ users: NSArray) -> NSArray
    {
        let results = NSMutableArray()
        for user in users
        {
            let userModel = UserModel(user as! NSDictionary)
            if let theModel = userModel
            {
                results.add(theModel)
            }
        }
        return results
    }
}
