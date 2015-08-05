//
//  CreateViewController.swift
//  CulturalTrail
//
//  Created by Manasi Goel on 7/8/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit
import Alamofire

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var issueDescription: UITextField!
    @IBOutlet weak var issuePriority: UISegmentedControl!
  
    @IBOutlet weak var imageView: UIImageView!
    
    var images = [UIImage]()
    var priority = 0
    
    @IBOutlet weak var descriptionCharCount: UILabel!

    
    override func viewDidLoad() {
        issuePriority.tintColor = UIColor.orangeColor()
        let descriptionBorder = CALayer()
        let descriptionWidth = CGFloat(1.0)
        descriptionBorder.borderColor = UIColor.darkGrayColor().CGColor
        descriptionBorder.frame = CGRect(x: 0, y: issueDescription.frame.size.height - descriptionWidth, width:  issueDescription.frame.size.width, height: issueDescription.frame.size.height)
        descriptionBorder.borderWidth = descriptionWidth
        issueDescription.layer.addSublayer(descriptionBorder)
        issueDescription.layer.masksToBounds = true
    }
    
    @IBAction func createIssueClicked(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("issue_created", sender: self)
        
    }
    
    @IBAction func descriptionChanged(sender: AnyObject) {
        var descriptionLength = count(issueDescription.text)
        descriptionCharCount.text = "\(descriptionLength)/240"
        if(descriptionLength > 240){
            issueDescription.deleteBackward()
        }
    }
    
    @IBAction func changePriority(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: //low priority
            issuePriority.tintColor = UIColor.orangeColor()
            priority = 0
        case 1: //high priority
            issuePriority.tintColor = UIColor.redColor()
            priority = 1
        default:
            break
        }
    }
    
    @IBAction func addImages(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = .Camera
        }else{
            imagePicker.sourceType = .PhotoLibrary
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(chosenImage)
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = images[images.count - 1]
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "create_to_list"){
            return true
        }
            let parameters:[String : AnyObject] = [
                "name": "Issue Name",
                "description": issueDescription.text,
                "reported": "iOS",
                "request": "",
                "picture": "",
                "location": [
                    "lng": 30.0,
                    "lat": 30.0
                ],
                "priority": priority,
                "open": true
            ]
            
            Alamofire.request(Alamofire.Method.POST, "http://culturaltrail.herokuapp.com/issues", parameters: parameters, encoding: .JSON)
                .responseJSON { (_, _, JSON, _) in
                    println(JSON)
            }
        
        return true
    }
    
    


    
}