import UIKit
import CoreLocation
import Alamofire

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var issueImage: UIImageView?
    @IBOutlet var issueTitle: UILabel?
    @IBOutlet var issueDescription: UILabel?
    @IBOutlet var issueLocation: UILabel?
    
    func loadItem(#title: String, description: String, location: String) {
        issueTitle!.text = title
        issueDescription!.text = description
        issueLocation!.text = location
        
    }
    func loadItemWithImage(#title: String, description: String, image: UIImage, location: String) {
        issueTitle!.text = title
        issueDescription!.text = description
        issueImage!.image = image
        issueLocation!.text = location

    }
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var JSONitems = NSMutableArray()
    var imageArray = NSMutableArray()
    var locationArray = NSMutableArray()
    var issueNameToPass = String()
    var issueDescriptionToPass = String()
    var issueLocation = String()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        retrieveData()
        
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        
    }

    func retrieveData() {
        RestApiManager.sharedInstance.getIssues { json in
            let results = json
            
            for (index: String, subJson: JSON) in results {
                let issue: AnyObject = subJson.object
                self.JSONitems.addObject(issue)
                
                
                if let location = issue["location"] as? [String: AnyObject] {
                    if let lat = location["lat"] as? Double {
                        if let lng = location["lng"] as? Double {
                            var locationString = self.findLocation(lat, longi: lng)
                        }
                    }
                }
                
                self.retrieveImage(issue["picture"] as! String)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                })
            }
            NSLog("%d",self.JSONitems.count)
            
        }
        /*Alamofire.request(.GET, "http://culturaltrail.herokuapp.com/issues?pageSize=100")
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }*/
        
    }
    
    func retrieveImage(urlString: String){
        
            var issueImage = UIImageView();
            let url = NSURL(string: urlString)
            if(url != nil)
            {
                let data = NSData(contentsOfURL: url!) //make sure image in this url does exist, otherwise unwrap
                issueImage.image = UIImage(data: data!)
                self.imageArray.addObject(issueImage)
                NSLog("picture in")
            }
            else{
                self.imageArray.addObject(issueImage)
            }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return JSONitems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        let issue:JSON = JSON(self.JSONitems[indexPath.row])
        
        let picURL = issue["picture"].string

        var issueImage = UIImageView();
        let url = NSURL(string: picURL!)
        if(url != nil)
        {
        //findLocation(issue["location"]["lat"].doubleValue, longi: issue["location"]["lng"].doubleValue)
            issueImage = self.imageArray[indexPath.row] as! UIImageView
            
            cell.loadItemWithImage(title: issue["name"].string!, description: issue["description"].string!, image: issueImage.image!, location: "hey")
        }
        else{
            cell.loadItem(title: issue["name"].string!, description: issue["description"].string!, location: "hey")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        /*
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        */
        issueNameToPass = self.JSONitems[indexPath.row]["name"] as! String
        issueDescriptionToPass = self.JSONitems[indexPath.row]["description"] as! String
        issueLocation = self.locationArray[indexPath.row] as! String
        performSegueWithIdentifier("showIssueDetail", sender: self)

    }
    
    func findLocation(lati: Double, longi: Double) -> String{
        let location = CLLocation(latitude: lati as CLLocationDegrees, longitude: longi as CLLocationDegrees)
        let geocoder = CLGeocoder()
        var locationString = String()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, e) -> Void in
            if let error = e {
                println("Error:  \(e.localizedDescription)")
            } else {
                let placemark = placemarks.last as! CLPlacemark
                
                let userInfo = [
                    "detail":  placemark.subThoroughfare,
                    "street":   placemark.thoroughfare
                ]
                
                locationString = userInfo["detail"]! + userInfo["street"]!
                
                println("Location:  \(locationString)")
                println(self.locationArray)
                
            }
            self.locationArray.addObject(locationString)
        })
        
        return locationString
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showIssueDetail") {
            
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! IssueDetailViewController
            // your new view controller should have property that will store passed value
            viewController.issueName = issueNameToPass
            viewController.issueDescription = issueDescriptionToPass
            viewController.issueLocation = issueLocation
        }
        
    }
    
    
}