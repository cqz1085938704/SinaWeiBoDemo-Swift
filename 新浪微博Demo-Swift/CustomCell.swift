//
//  CustomCell.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/4.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell
{
    var userModel: UserModel? = nil
    {
        didSet
        {
            textLabel?.text = userModel?.nickName
            detailTextLabel?.text = userModel?.title
            
            if let theUrl = userModel?.imageURL
            {
                imageView?.setImage(url: theUrl, placeHolder: "placeholder")
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.numberOfLines = 1
        detailTextLabel?.numberOfLines = 2
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = UIImage(named: "placeholder")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        textLabel?.frame = CGRect(x: (imageView?.right())! + 10, y: 5, width: self.width() - (imageView?.right())! - 5.0 - 10.0, height: 30.0)
        detailTextLabel?.frame = CGRect(x: (textLabel?.x())!, y: (textLabel?.bottom())!, width: (textLabel?.width())!, height: 40)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
