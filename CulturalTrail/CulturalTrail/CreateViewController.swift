//
//  CreateViewController.swift
//  CulturalTrail
//
//  Created by Manasi Goel on 7/8/15.
//  Copyright (c) 2015 Indy Cultural Trail. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var issueName: UITextField!
    @IBOutlet weak var issueDescription: UITextField!
    @IBOutlet weak var issuePriority: UISegmentedControl!
    
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    var images = [UIImage]()
    
    @IBOutlet weak var titleCharCount: UILabel!
    @IBOutlet weak var descriptionCharCount: UILabel!

    
    override func viewDidLoad() {
        errorMessage.hidden = true
        issuePriority.tintColor = UIColor.orangeColor()
        let titleBorder = CALayer()
        let titleWidth = CGFloat(1.0)
        titleBorder.borderColor = UIColor.darkGrayColor().CGColor
        titleBorder.frame = CGRect(x: 0, y: issueName.frame.size.height - titleWidth, width:  issueName.frame.size.width, height: issueName.frame.size.height)
        titleBorder.borderWidth = titleWidth
        issueName.layer.addSublayer(titleBorder)
        issueName.layer.masksToBounds = true
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
    
    @IBAction func titleChanged(sender: AnyObject) {
        var titleLength = count(issueName.text)
        titleCharCount.text = "\(titleLength)/50"
        if(titleLength > 50){
            issueName.deleteBackward()
        }
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
        case 1: //high priority
            issuePriority.tintColor = UIColor.redColor()
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
        //POST
        for image in images{
            println(image)
        }
        return true
    }
    /*
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
    }*/

    
}