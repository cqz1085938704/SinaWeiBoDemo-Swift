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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var geo: UILabel!
    
    var userInfo: UserModel? = nil
    {
        didSet
        {
            imageView.setImageWithURL(userInfo?.imageURL, placeHolder: "placeholder")
            textView.text = userInfo?.title
            nickName.text = userInfo?.nickName
            comments.text = userInfo?.followers_count
            geo.text = userInfo?.geo
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = userInfo?.nickName
    }
    
    init(userInfo: UserModel?)
    {
        super.init(nibName: nil, bundle: nil)
        
        self.userInfo = userInfo
        view.backgroundColor = UIColor.white
    }
    
    convenience init(_ userInfo: UserModel?)
    {
        self.init(userInfo: userInfo)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
}
