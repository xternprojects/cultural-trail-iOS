//
//  IssueDetailViewController.swift
//  CulturalTrail
//
//  Created by Nausherwan Korai on 7/13/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    @IBOutlet var issueNameLabel: UILabel!
    @IBOutlet var issueDescriptionLabel: UILabel!
    @IBOutlet var issueLocationLabel: UILabel!
    @IBOutlet var navigationBar: UINavigationItem!
    
    var issueName = String()
    var issueDescription = String()
    var issueLocation = String()
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
        let sourceViewController: AnyObject = sender.sourceViewController
        // Pull any data from the view controller which initiated the unwind segue.
    }
    
}
