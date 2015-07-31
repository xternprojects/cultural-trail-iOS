//
//  EditViewController.swift
//  CulturalTrail
//
//  Created by Nausherwan Korai on 7/28/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit
import Alamofire

class EditViewController: UIViewController{

    @IBOutlet var nameTextBox: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    var issueId = String()
    var issueName = String()
    var issueDescription = String()
    
    override func viewWillAppear(animated: Bool) {
        nameTextBox.text = issueName
        descriptionTextView.text = issueDescription
        
        descriptionTextView.layer.borderColor = UIColor.grayColor().CGColor;
        descriptionTextView.layer.borderWidth = 0.2;
        descriptionTextView.layer.cornerRadius = 7.5;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! IssueDetailViewController
            // your new view controller should have property that will store passed value
            viewController.editIssueName = nameTextBox.text
            viewController.editIssueDescription = descriptionTextView.text
            //viewController.issueLocation = issueLocation
        
        let parameters:[String : AnyObject] = [
            "_id": issueId,
            "name": nameTextBox.text,
            "description": descriptionTextView.text
        ]
        
        Alamofire.request(Alamofire.Method.PUT, "http://culturaltrail.herokuapp.com/issues", parameters: parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }
    }
    
    
}