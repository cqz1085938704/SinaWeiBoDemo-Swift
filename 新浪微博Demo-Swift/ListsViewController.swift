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
            HttpRequest.get(url: fianlURL) {[unowned self] (data, response, error) in
                if let theData = data
                {
                    let dic = try? JSONSerialization.jsonObject(with: theData, options: .mutableContainers) as? NSDictionary
                    if let theDic = dic
                    {
                        let statuses = theDic?["statuses"] as? NSArray
                        if let theStatus = statuses
                        {
                            let models = UserModel.getAllUserModels(theStatus)
                            self.records = models
                            DispatchQueue.main.async {[unowned self] in
                                self.tableView.reloadData()
                                self.loadingView.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private lazy var tableView: UITableView =
    {
        let theTable = UITableView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height), style: .plain)
        theTable.delegate = self
        theTable.dataSource = self
        theTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return theTable
    }()
    
    private lazy var loadingView: UIActivityIndicatorView =
    {
        let theLoading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        theLoading.hidesWhenStopped = true
        theLoading.startAnimating()
        return theLoading
    }()
    
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

        self.view.addSubview(self.tableView)
        self.view.addSubview(self.loadingView)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingView.center = self.view.center
    }
    
    //MARK: UITableViewDelegate & UITableViewDataSource
    
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
        var cell: CustomCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? CustomCell
        if cell == nil
        {
            cell = CustomCell(style: .subtitle, reuseIdentifier: cellID)
        }
        
        let model = self.records?[indexPath.row] as? UserModel
        cell?.userModel = model
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.userInfo = self.records?[indexPath.row] as? UserModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
