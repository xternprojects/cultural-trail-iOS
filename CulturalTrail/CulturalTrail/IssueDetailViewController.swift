//
//  IssueDetailViewController.swift
//  CulturalTrail
//
//  Created by Nausherwan Korai on 7/13/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit
import Alamofire

class IssueDetailViewController: UIViewController {
    
    @IBOutlet var issueNameLabel: UILabel!
    @IBOutlet var issueDescriptionLabel: UILabel!
    @IBOutlet var issueLocationLabel: UILabel!
    @IBOutlet var navigationBar: UINavigationItem!
    
    var issueId = String()
    var issueName = String()
    var issueDescription = String()
    var issueLocation = String()
    
    var editIssueName = String()
    var editIssueDescription = String()
    
    override func viewWillAppear(animated: Bool) {
        issueNameLabel.text = issueName
        issueDescriptionLabel.text = issueDescription
        issueLocationLabel.text = issueLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
        let sourceViewController: EditViewController = sender.sourceViewController as! EditViewController
        // Pull any data from the view controller which initiated the unwind segue.
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
         if (segue.identifier == "showEditView") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! EditViewController
            // your new view controller should have property that will store passed value
            viewController.issueName = issueName
            viewController.issueDescription = issueDescription
            viewController.issueId = issueId
        }
    }

    
}
