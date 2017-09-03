//
//  SinaWeiBoWebviewController.swift
//  新浪微博Demo-Swift
//
//  Created by 陈启正 on 17/9/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

//#define WIN_SIZE UIScreen.mainScreen.bounds.size

class SinaWeiBoWebviewController: UIViewController, UIWebViewDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=1478592170&response_type=code&redirect_uri=http://caiyaodemo.com")
        let request = NSURLRequest(url: url as! URL)
        
        let webview = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        webview.delegate = self
        webview.loadRequest(request as URLRequest)
        
        self.view.addSubview(webview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url?.absoluteString
        if (url?.contains("code="))!
        {
            let components = url?.components(separatedBy: "=")
            let code = components?[1]
            if let theCode = code
            {
                let newUrl = "https://api.weibo.com/oauth2/access_token?client_id=1478592170&client_secret=f53fb2cb26339ba279d98105664667af&grant_type=authorization_code&redirect_uri=http://caiyaodemo.com&code=\(theCode)"
                var newRequest = URLRequest(url: NSURL(string: newUrl) as! URL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
                newRequest.httpMethod = "POST"
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let dataTask = session.dataTask(with: newRequest, completionHandler: { (data, response, error) in
                    if let theData = data
                    {
                        let result = try! JSONSerialization.jsonObject(with: theData, options: .mutableContainers) as! NSDictionary
                        let access_token = result["access_token"] as? String
                        
                        let viewCOntroller = ListsViewController()
                        viewCOntroller.token = access_token
                        self.navigationController?.pushViewController(viewCOntroller, animated: true)
                    }
                })
                dataTask.resume()
            }
        }
        return true
    }
}
