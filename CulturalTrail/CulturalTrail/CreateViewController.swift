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
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var issueName: UITextField!
    @IBOutlet weak var issueDescription: UITextField!
    @IBOutlet weak var issuePriority: UISegmentedControl!
    
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        //Center navigationBar.title
        errorMessage.hidden = true
        issuePriority.tintColor = UIColor.orangeColor()
        //var statusBarStyle: UIStatusBarStyle
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    @IBAction func createIssueClicked(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("issue_created", sender: self)
        
        let parameters:[String : AnyObject] = [
            "name": "Naush POSTed from the app",
            "description": "It's pretty cool",
            "reported": "Tickle me ballz",
            "request": "",
            "picture": "",
            "location": [
                "lng": 30.0,
                "lat": 30.0
            ],
            "priority": 1,
            "open": true
        ]
        
        Alamofire.request(Alamofire.Method.POST, "http://culturaltrail.herokuapp.com/issues", parameters: parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
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
    
    


    
}