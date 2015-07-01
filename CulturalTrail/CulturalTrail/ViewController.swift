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
        let frame:CGRect = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
        self.tableView = UITableView(frame: frame)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(self.tableView!)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 25, width: self.view.frame.width, height: 50))
        btn.backgroundColor = UIColor.cyanColor()
        btn.setTitle("Add new Dummy", forState: UIControlState.Normal)
        btn.addTarget(self, action: "addDummyData", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func addDummyData() {
        NSLog("PRESS")
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
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        let issue:JSON =  JSON(self.items[indexPath.row])
        
        //let picURL = issue["picture"]["medium"].string
        //let url = NSURL(string: picURL!)
        //let data = NSData(contentsOfURL: url!)
        
        cell!.textLabel?.text = issue["name"].string
        //cell?.imageView?.image = UIImage(data: data!)
        
        return cell!
    }
}
