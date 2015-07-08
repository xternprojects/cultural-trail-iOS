//
//  CreateViewController.swift
//  CulturalTrail
//
//  Created by Manasi Goel on 7/8/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var issueName: UITextField!
    @IBOutlet weak var issueDescription: UITextField!
    
    
    override func viewDidLoad() {
        navigationBar.barTintColor = UIColor(red: 2/225, green: 86/225, blue: 138/225, alpha: 1.0)
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.topItem?.title = "Create Issue"
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 16)!]
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //Center navigationBar.title
        errorMessage.hidden = true
        //var statusBarStyle: UIStatusBarStyle
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    @IBAction func createIssueClicked(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("issue_created", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "create_to_list"){
            return true
        }
        if(issueName.text.isEmpty){
            errorMessage.text = "Please enter a name for this issue"
            errorMessage.textColor = UIColor.redColor()
            errorMessage.hidden = false
            return false
        }
        if(issueDescription.text.isEmpty){
            errorMessage.text = "Please enter a brief description for this issue"
            errorMessage.textColor = UIColor.redColor()
            errorMessage.hidden = false
            return false
        }
        return true
    }
    
}




