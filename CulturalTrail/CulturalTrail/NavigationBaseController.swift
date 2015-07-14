//
//  NavigationBaseController.swift
//  CulturalTrail
//
//  Created by Nausherwan Korai on 7/13/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//


//Creating this purely for visuals. 
import UIKit

class NavigationBaseController: UINavigationController {
    
    override func viewWillAppear(animated: Bool) {
        self.navigationBar.barTintColor = UIColor(red: 2/225, green: 86/225, blue: 138/225, alpha: 1.0)
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 16)!]
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
    
   
}