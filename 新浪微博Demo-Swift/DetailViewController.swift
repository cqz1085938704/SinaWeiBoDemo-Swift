//
//  DetailViewController.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/5.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

let columns: Int = 6

class DetailViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var userInfo: UserModel? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = userInfo?.nickName
        if let theUrl = userInfo?.imageURL
        {
            imageView.setImage(url: theUrl, placeHolder: "placeholder")
        }
        textView.text = userInfo?.title
        nickName.text = userInfo?.nickName
        comments.text = userInfo?.followers_count
        location.text = userInfo?.location
        
        loadPics()
    }
    
    func loadPics()
    {
        if let theUrls = userInfo?.picUrls
        {
            for imageUrl in theUrls
            {
                let thumbnail_pic = (imageUrl as? NSDictionary)?["thumbnail_pic"]
                
                let wh = UIScreen.main.bounds.size.width/CGFloat(columns)
                let index = theUrls.index(of: imageUrl)
                
                let aImageView = UIImageView(frame: CGRect(x: CGFloat(index%columns) * wh, y: comments.bottom() + CGFloat(index/columns) * wh, width: wh, height: wh))
                aImageView.contentMode = .scaleAspectFit
                if let theUrl = thumbnail_pic as? String
                {
                    aImageView.setImage(url: theUrl, placeHolder: "placeholder")
                }
                view.addSubview(aImageView)
            }
        }
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
