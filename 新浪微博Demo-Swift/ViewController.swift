//
//  ViewController.swift
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/1.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginWithSinaWeiBo(_ sender: UIButton)
    {
        let controller = SinaWeiBoWebviewController();
        self.navigationController?.pushViewController(controller, animated: true);
    }
}

