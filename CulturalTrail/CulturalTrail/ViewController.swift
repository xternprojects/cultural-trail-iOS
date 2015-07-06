//
//  ViewController.swift
//  CulturalTrail
//
//  Created by Andy Shi on 6/19/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView?
    var items = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        let frame:CGRect = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height-100)
        self.tableView = UITableView(frame: frame)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.rowHeight = 100
        self.view.addSubview(self.tableView!)
        
        retrieveData();
    }
    
    func retrieveData() {
        RestApiManager.sharedInstance.getIssues { json in
            let results = json
            
            for (index: String, subJson: JSON) in results {
                let issue: AnyObject = subJson.object
                self.items.addObject(issue)
                dispatch_async(dispatch_get_main_queue(),{
                    tableView?.reloadData()
                })
            }
            NSLog("%d",self.items.count)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
    
        
        let issue:JSON = JSON(self.items[indexPath.row])
        
        //let picURL = issue["picture"]["medium"].string
        //let url = NSURL(string: picURL!)
        //let data = NSData(contentsOfURL: url!)
        
        var newLabel = UILabel(frame: CGRectMake(15.0, 15.0, 300.0, 20.0))
        newLabel.text = issue["name"].string
        newLabel.tag = 1
        
        var newLabel1 = UILabel(frame: CGRectMake(15.0, 45.0, 300.0, 20.0))
        newLabel1.text = issue["description"].string
        newLabel1.tag = 1
    
        cell!.addSubview(newLabel)
        cell!.addSubview(newLabel1)
        
        //cell?.imageView?.image = UIImage(data: data!)
        
        return cell!
    }
    
}
