//
//  DetailViewController.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/5.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    var userInfo: UserModel? = nil
    {
        didSet
        {
            
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = userInfo?.nickName
    }
    
    init(userInfo: UserModel?)
    {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init()
    {
        self.init(userInfo: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
}
