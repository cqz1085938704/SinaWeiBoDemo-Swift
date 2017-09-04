//
//  ListsViewController.swift
//  新浪微博Demo-Swift
//
//  Created by 陈启正 on 17/9/3.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

import UIKit

let cellID: String = "cellID"

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var token: String? = nil
    {
        didSet
        {
            let fianlURL = "https://api.weibo.com/2/statuses/public_timeline.json?access_token=\(self.token!)"
            let finalRequest = URLRequest(url: URL(string: fianlURL)!)
            //finalRequest.httpMethod = "POST"
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let dataTask = session.dataTask(with: finalRequest) { (data, response, error) in
                if let theData = data
                {
                    let dic = try? JSONSerialization.jsonObject(with: theData, options: .mutableContainers) as? NSDictionary
                    if let theDic = dic
                    {
                        let statuses = theDic?["statuses"] as? NSArray
                        if let theStatus = statuses
                        {
                            self.records = theStatus
                            self.tableView.reloadData()
                        }
                    }
                    
                    
                }
            }
            dataTask.resume()
        }
    }
    private var tableView: UITableView!
    private var records: NSArray? = nil

    init(_ token: String)
    {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init()
    {
        self.init("")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.token = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView = UITableView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view .addSubview(tableView)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let theRecords = self.records
        {
            return theRecords.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        let infoDic = self.records?[indexPath.row] as? NSDictionary
        cell?.textLabel?.text = infoDic?["text"] as? String
        
        return cell!
    }
}
