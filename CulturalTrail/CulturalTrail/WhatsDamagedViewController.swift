//
//  WhatsDamagedViewController.swift
//  CulturalTrail
//
//  Created by Manasi Goel on 8/2/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit
import Alamofire

class WhatsDamagedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    let json_items: [JSON] = [
        ["main_item": "Light", "damages": ["Graffiti", "Out", "Damaged", "Destroyed"]],
        ["main_item": "Bench", "damages": ["Graffiti", "Loose", "Damaged", "Destroyed"]],
        ["main_item": "Crossing signal", "damages": ["No Hand", "No Walk", "Crooked"]],
        ["main_item": "Trail sign", "damages": ["Graffiti", "Bent", "Broken", "Missing"]],
        ["main_item": "Edging", "damages": ["Loose", "Broken", "Missing"]],
        ["main_item": "Bollard", "damages": ["Graffiti", "Loose", "Impacted", "Destroyed"]],
        ["main_item": "Paver", "damages": ["Soiled", "Broken", "Missing"]],
        ["main_item": "Crossing push button", "damages": ["Graffiti", "No Sound", "No Push"]],
        ["main_item": "Light control box", "damages": ["Graffiti", "Light Sensor", "Damaged", "Destroyed"]],
        ["main_item": "Sprinkler box", "damages": ["Graffiti", "Damaged"]],
        ["main_item": "Curb", "damages": ["Broken"]],
        ["main_item": "Trash can", "damages": ["Graffiti", "Loose", "Latch", "Pin", "Door", "Top", "Destroyed"]],
        ["main_item": "Recycling can", "damages": ["Loose", "Latch", "Pin", "Door", "Top", "Destroyed"]],
        ["main_item": "Glass/Debris", "damages": []],
        ["main_item": "Art Installation", "damages": ["Graffiti"]]
    ]
    
    var item_names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for i in json_items{
            item_names.append(i["main_item"].stringValue)
        }
        
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = item_names[row]

        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "whatsWrong") {
            var svc = segue.destinationViewController as! WhatsWrongViewController;
            
            if let index = tableView.indexPathForSelectedRow()?.row {
                svc.damagedItem = item_names[index]
            }
        }
    }
    
}