import UIKit

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

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var items = NSMutableArray()
    var imageArray = NSMutableArray()
    var issueNameToPass = String()
    var issueDescriptionToPass = String()
    
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
                self.items.addObject(issue)
                
            }
            NSLog("%d",self.items.count)
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView?.reloadData()
                //self.retrieveImages()
            })
        }
        //self.retrieveImages()
        
    }
    
    func retrieveImages(){
        
        for (var x=0; x<self.items.count; x++) {
            //NSLog("index %@",element.string)
            //let picURL = self.items[index]["picture"].string
            //NSLog("url %@", self.items[index].string)
            var issueImage = UIImageView();
            let url = NSURL(string: self.items[x]["picture"]!!.string)
            if(url != nil)
            {
                let data = NSData(contentsOfURL: url!) //make sure image in this url does exist, otherwise unwrap
                issueImage.image = UIImage(data: data!)
                self.imageArray.addObject(issueImage);
                NSLog("picture in")
            }
            else{
                self.imageArray.addObject(0)
            }
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        let issue:JSON = JSON(self.items[indexPath.row])
        
        let picURL = issue["picture"].string

        var issueImage = UIImageView();
        let url = NSURL(string: picURL!)
        if(url != nil)
        {
            let data = NSData(contentsOfURL: url!) //make sure image in this url does exist, otherwise unwrap
            issueImage.image = UIImage(data: data!)
            
            cell.loadItemWithImage(title: issue["name"].string!, description: issue["description"].string!, image: issueImage.image!, location: issue["description"].string!)
        }
        else{
            cell.loadItem(title: issue["name"].string!, description: issue["description"].string!, location: issue["description"].string!)
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
        issueNameToPass = self.items[indexPath.row]["name"] as! String
        issueDescriptionToPass = self.items[indexPath.row]["description"] as! String
        performSegueWithIdentifier("showIssueDetail", sender: self)

    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showIssueDetail") {
            
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! IssueDetailViewController
            // your new view controller should have property that will store passed value
            viewController.issueName = issueNameToPass
            viewController.issueDescription = issueDescriptionToPass
        }
        
    }
    
    
}