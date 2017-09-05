//
//  SinaWeiBoWebviewController.swift
//  新浪微博Demo-Swift
//
//  Created by 陈启正 on 17/9/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

let appid: String = "1478592170"
let appsecret: String = "f53fb2cb26339ba279d98105664667af"
let callbackuri: String = "http://caiyaodemo.com"
let codeURL: String = "https://api.weibo.com/oauth2/authorize?client_id=\(appid)&response_type=code&redirect_uri=\(callbackuri)"

class SinaWeiBoWebviewController: UIViewController, UIWebViewDelegate
{
    private lazy var loadingView: UIActivityIndicatorView =
    {
       var theLoading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        theLoading.hidesWhenStopped = true
        theLoading.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        theLoading.center = self.view.center
        return theLoading
    }()
    
    private lazy var webView: UIWebView =
    {
        let theWeb = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        theWeb.delegate = self
        theWeb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return theWeb
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.addSubview(self.webView)
        self.view.addSubview(self.loadingView)
        
        startLoading()
    }

    func startLoading()
    {
        let url = URL(string: codeURL)
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.loadingView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.loadingView.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        let url = request.url?.absoluteString
        if (url?.contains("code="))!
        {
            let components = url?.components(separatedBy: "=")
            let code = components?[1]
            if let theCode = code
            {
                let newUrl = "https://api.weibo.com/oauth2/access_token?client_id=\(appid)&client_secret=\(appsecret)&grant_type=authorization_code&redirect_uri=\(callbackuri)&code=\(theCode)"
                var newRequest = URLRequest(url: URL(string: newUrl)!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
                newRequest.httpMethod = "POST"
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let dataTask = session.dataTask(with: newRequest, completionHandler: { (data, response, error) in
                    if let theData = data
                    {
                        let result = try! JSONSerialization.jsonObject(with: theData, options: .mutableContainers) as! NSDictionary
                        let access_token = result["access_token"] as? String
                        
                        let viewCOntroller = ListsViewController()
                        viewCOntroller.token = access_token
                        
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(viewCOntroller, animated: true)
                        }
                    }
                })
                dataTask.resume()
            }
        }
        return true
    }
}
