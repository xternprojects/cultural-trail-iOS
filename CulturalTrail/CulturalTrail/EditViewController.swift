//
//  EditViewController.swift
//  CulturalTrail
//
//  Created by Nausherwan Korai on 7/28/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class EditViewController: UIViewController{

    
    @IBAction func cancelButton(segue:UIStoryboardSegue) {
        // initialize new view controller and cast it as your view controller
        var viewController = segue.destinationViewController as! IssueDetailViewController
        // your new view controller should have property that will store passed value
        //viewController.issueName = issueNameToPass
        //viewController.issueDescription = issueDescriptionToPass
        //viewController.issueLocation = issueLocation
    }
    
    @IBAction func saveButton(segue:UIStoryboardSegue) {
        
    }
}