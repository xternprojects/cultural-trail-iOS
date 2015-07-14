//
//  ListViewController.swift
//  CulturalTrail
//
//  Created by Manasi Goel on 7/8/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView?
    var items = NSMutableArray()
    var issueNameToPass = String()
    var issueDescriptionToPass = String()
    
    override func viewWillAppear(animated: Bool) {
        items = NSMutableArray()
        let frame:CGRect = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height-100)
        self.tableView = UITableView(frame: frame)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.rowHeight = 360
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
            //NSLog("%d",self.items.count)
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
        
        let picURL = issue["picture"].string
        NSLog("url: %s",picURL!)
        let url = NSURL(string: picURL!)
        if(url != nil)
        {
            let data = NSData(contentsOfURL: url!)
            var issueImage = UIImageView(frame: CGRectMake(0.0, 0.0, 300.0, 200.0))
            issueImage.image = UIImage(data: data!)
            
            cell!.addSubview(issueImage)
            
            var newLabel = UILabel(frame: CGRectMake(15.0, 215.0, 300.0, 20.0))
            newLabel.text = issue["name"].string
            newLabel.tag = 1
            
            var newLabel1 = UILabel(frame: CGRectMake(15.0, 245.0, 300.0, 20.0))
            newLabel1.text = issue["description"].string
            newLabel1.tag = 2
            
            cell!.addSubview(newLabel)
            cell!.addSubview(newLabel1)
        }
        else
        {
            var newLabel = UILabel(frame: CGRectMake(15.0, 15.0, 300.0, 20.0))
            newLabel.text = issue["name"].string
            newLabel.tag = 1
            
            var newLabel1 = UILabel(frame: CGRectMake(15.0, 45.0, 300.0, 20.0))
            newLabel1.text = issue["description"].string
            newLabel1.tag = 2
            
            cell!.addSubview(newLabel)
            cell!.addSubview(newLabel1)

        }
        
        
        
        //cell?.imageView?.image = UIImage(data: data!)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        
        issueNameToPass = self.items[indexPath!.row]["name"] as! String
        issueDescriptionToPass = self.items[indexPath!.row]["description"] as! String
        performSegueWithIdentifier("showIssueDetail", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showIssueDetail") {
            
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! IssueDetailViewController
            // your new view controller should have property that will store passed value
            viewController.issueName = issueNameToPass
            viewController.issueDescription = issueDescriptionToPass
        }
        
    }

    
}