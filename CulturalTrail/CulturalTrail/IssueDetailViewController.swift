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
    
    var issueName = String()
    var issueDescription = String()
    
    override func viewWillAppear(animated: Bool) {
        issueNameLabel.text = issueName
        issueDescriptionLabel.text = issueDescription
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
