//
//  PeopleGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/2/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import Parse
// Controller for people gallery view, displays people avaialable to be followed by current user
class PeopleGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var peopleTableView:UITableView!
    var people:[PFUser] = []
    var followRequestsFrom:[AnyObject] = []
    var currentFollowerFollowingObject:PFObject!
    var noPeopleView:UIView!
    var filterDictionary:[String:[String]] = Dictionary(minimumCapacity: 0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    var user:PFUser!

    let colorDictionary =
    [
        "orange":UIColor(red: 255/255, green: 97/255, blue: 27/255, alpha: 1),
        "brown":UIColor(red: 139/255, green: 87/255, blue: 42/255, alpha: 1),
        "teal":UIColor(red: 34/255, green: 200/255, blue: 165/255, alpha: 1),
        "purple":UIColor(red: 140/255, green: 76/255, blue: 233/255, alpha: 1),
        "pink":UIColor(red: 252/255, green: 52/255, blue: 106/255, alpha: 1),
        "lightBlue":UIColor(red: 30/255, green: 169/255, blue: 238/255, alpha: 1),
        "yellowGreen":UIColor(red: 211/255, green: 206/255, blue: 52/255, alpha: 1),
        "vibrantBlue":UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1),
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    ]
    
    let avatarImageDictionary =
    [
        "elephant":UIImage(named: "elephant-icon"),
        "snake":UIImage(named: "snake-icon"),
        "butterfly":UIImage(named: "butterfly-icon"),
        "snail":UIImage(named: "snail-icon"),
        "horse":UIImage(named: "horse-icon"),
        "bird":UIImage(named: "bird-icon"),
        "turtle":UIImage(named: "turtle-icon"),
        "sheep":UIImage(named: "sheep-icon"),
        "bear":UIImage(named: "bear-icon"),
        "littleBird":UIImage(named: "littleBird-icon"),
        "dog":UIImage(named: "dog-icon"),
        "rabbit":UIImage(named: "rabbit-icon"),
        "caterpillar":UIImage(named: "caterpillar-icon"),
        "crab":UIImage(named: "crab-icon"),
        "fish":UIImage(named: "fish-icon"),
        "cat":UIImage(named: "cat-icon")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UINavigationBar init
        self.navigationItem.title = "Add People"
        
        let filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "presentFilterView:")
        filterButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = filterButton
 
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeAddPeopleView:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.peopleTableView = UITableView(frame: CGRectZero)
        self.peopleTableView.translatesAutoresizingMaskIntoConstraints = false
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 80
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.peopleTableView.registerClass(PersonFollowTableViewCell.self, forCellReuseIdentifier: "PersonFollowTableViewCell")
        self.peopleTableView.delegate = self
        self.peopleTableView.dataSource = self
        self.peopleTableView.contentInset.top = 64
        self.peopleTableView.hidden = true
        self.peopleTableView.layoutMargins = UIEdgeInsetsZero
        self.peopleTableView.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(self.peopleTableView)
        
        let metricsDictionary = ["zero":0]
        let viewsDictionary = ["peopleTableView":self.peopleTableView]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[peopleTableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[peopleTableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)

        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(horizontalConstraints)
        
        // No people view init and layout
        self.noPeopleView = UIView(frame: self.peopleTableView.frame)
        self.noPeopleView.center = self.view.center
        
        let noPeopleViewTitle = UILabel(frame: CGRectMake(0, 2 * self.noPeopleView.frame.height / 5, self.noPeopleView.frame.width, 32))
        noPeopleViewTitle.text = "You've Followed Them All"
        noPeopleViewTitle.textAlignment = NSTextAlignment.Center
        noPeopleViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noPeopleViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noPeopleView.addSubview(noPeopleViewTitle)

        let noPeopleViewSubtitle = UILabel(frame: CGRectMake(0, 2 * self.noPeopleView.frame.height / 5 + 31, self.noPeopleView.frame.width, 30))
        noPeopleViewSubtitle.text = "you're quite a follower indeed"
        noPeopleViewSubtitle.textAlignment = NSTextAlignment.Center
        noPeopleViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noPeopleViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noPeopleView.addSubview(noPeopleViewSubtitle)
        self.noPeopleView.hidden = true
        self.view.addSubview(self.noPeopleView)
        self.loadPeople()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    // Table view data source method
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as! PersonFollowTableViewCell

        let person = self.people[indexPath.row]
        cell.userAvatar.backgroundColor = self.colorDictionary[person["color"] as! String]
        cell.userAvatar.image = self.avatarImageDictionary[person["avatar"] as! String]!
        cell.userAlias.text = person.username
        let personOrientation = person["sexualOrientation"] as! String
        let personAge = person["age"] as! Int
        cell.userOrientationAge.text = "\(personOrientation) . \(personAge)"
        cell.followButton.addTarget(self, action: "followButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
        cell.userAvatar.addGestureRecognizer(tapGestureRecognizer)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.filterDictionary.count > 0{
            var filterLabelText = ""
            for (filterName, values) in self.filterDictionary{
                switch filterName{
                case "Maximum Age":
                    print("Maximum Age: \(values[0])")
                    filterLabelText += "Maximum Age: \(values[0])"
                case "Minimum Age":
                    print("Minimum Age: \(values[0])")
                    filterLabelText += "Minimum Age: \(values[0])"
                case "Gender Identity":
                    print("Gender Identity: \(values[0])")
                    filterLabelText += "Gender Identity: \(values[0])"
                case "Sexual Orientation":
                    print("Sexual Orientation: \(values[0])")
                    filterLabelText += "Sexual Orientation: \(values[0])"
                case "State":
                    print("State: \(values)")
                    filterLabelText += "State: \(values)"
                case "City":
                    print("City: \(values)")
                    filterLabelText += "City: \(values)"
                case "Religion":
                    print("Religion: \(values)")
                    filterLabelText += "Religion: \(values)"
                case "Ethnicity":
                    print("Ethnicity: \(values)")
                    filterLabelText += "Ethnicity: \(values)"
                default:
                    print("nothing")
                }
                filterLabelText += ", "
            }
            let filterMaxSize:CGSize = CGSize(width: CGFloat(360), height: CGFloat(MAXFLOAT))
            let filterLabelRect:CGRect = filterLabelText.boundingRectWithSize(filterMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                object: self.regularFont!.fontWithSize(16.0),
                forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
            return filterLabelRect.size.height + 16
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("header")
        let headerView = UIView()
        let filterLabel = UILabel(frame: CGRectZero)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = self.regularFont
        filterLabel.numberOfLines = 0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "filterHeaderTapped")
        headerView.addGestureRecognizer(tapGestureRecognizer)
        headerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        headerView.addSubview(filterLabel)
        let viewsDictionary = ["filterLabel":filterLabel]
        let metricsDictionary = ["verticalMargin": 8]
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[filterLabel]-7.5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[filterLabel]-verticalMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        headerView.addConstraints(horizontalConstraints)
        headerView.addConstraints(verticalConstraints)
        if self.filterDictionary.count > 0{
            print("return header")
            var filterLabelText = ""
            var counter = 0
            for (filterName, values) in self.filterDictionary{
                switch filterName{
                case "Maximum Age":
                    print("Maximum Age: \(values[0])")
                    filterLabelText += "Maximum Age: \(values[0])"
                case "Minimum Age":
                    print("Minimum Age: \(values[0])")
                    filterLabelText += "Minimum Age: \(values[0])"
                case "Gender Identity":
                    print("Gender Identity: \(values[0])")
                    filterLabelText += "Gender Identity: \(values[0])"
                case "Sexual Orientation":
                    print("Sexual Orientation: \(values[0])")
                    filterLabelText += "Sexual Orientation: \(values[0])"
                case "State":
                    print("State: \(values)")
                    filterLabelText += "State: \(values)"
                case "City":
                    print("City: \(values)")
                    filterLabelText += "City: \(values)"
                case "Religion":
                    print("Religion: \(values)")
                    filterLabelText += "Religion: \(values)"
                case "Ethnicity":
                    print("Ethnicity: \(values)")
                    filterLabelText += "Ethnicity: \(values)"
                default:
                    print("nothing")
                }
                if (counter < self.filterDictionary.count - 1){
                    filterLabelText += ",  "
                    ++counter
                }
                else{
//                    filterLabelText += "."
                }
            }
            filterLabel.text = filterLabelText
            return headerView
        }
        return nil
    }
    
    // Load people data from Parse
    func loadPeople(){
        self.peopleTableView.hidden = true
        let queryPeople = PFQuery(className:"_User")
        var objectIdArray:[String] = []
        objectIdArray.append((PFUser.currentUser()!).objectId!)
        PFUser.currentUser()!.fetchInBackgroundWithBlock{
            (object, error) -> Void in
            if error == nil {
                for user in (PFUser.currentUser()!)["followingRequested"] as! [PFUser]{
                    objectIdArray.append(user.objectId!)
                }
                print(objectIdArray)
                // Filter so only users who current user hasn't sent a follow request to are included
                queryPeople.whereKey("objectId", notContainedIn:objectIdArray)
                if !self.filterDictionary.isEmpty{
                    for (filterName, values) in self.filterDictionary{
                        switch filterName{
                        case "Maximum Age":
                            print("Maximum Age: \(values[0])")
                            queryPeople.whereKey("age", lessThanOrEqualTo: Int(values[0])!)
                        case "Minimum Age":
                            print("Minimum Age: \(values[0])")
                            queryPeople.whereKey("age", greaterThanOrEqualTo: Int(values[0])!)
                        case "Gender Identity":
                            print("Gender Identity: \(values[0])")
                            queryPeople.whereKey("genderIdentity", equalTo: values[0])
                        case "Sexual Orientation":
                            print("Sexual Orientation: \(values[0])")
                            queryPeople.whereKey("sexualOrientation", equalTo: values[0])
                        case "State":
                            print("State: \(values)")
                            queryPeople.whereKey("state", equalTo: values[0])
                        case "City":
                            print("City: \(values)")
                            queryPeople.whereKey("city", equalTo: values[0])
                        case "Religion":
                            print("Religion: \(values)")
                            queryPeople.whereKey("religion", equalTo: values[0])
                        case "Ethnicity":
                            print("Ethnicity: \(values)")
                            queryPeople.whereKey("ethnicity", equalTo: values[0])
                        default:
                            print("nothing")
                        }
                    }
                }
                queryPeople.findObjectsInBackgroundWithBlock {
                    (objects, error) -> Void in
                    if error == nil {
                        // The find succeeded.
                        self.people = objects as! [PFUser]
                        self.peopleTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                        if self.people.count == 0{
                            self.peopleTableView.hidden = true
                            self.noPeopleView.hidden = false
                        }
                        else{
                            self.peopleTableView.hidden = false
                            self.noPeopleView.hidden = true
                        }
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error!, error!.userInfo)
                    }
                }
            }
            else{
            
            }
        }
        // Compile a PFUser array of users already sent following requests to
    }
    

    // Dismiss modal add people view if Close button tapped
    func closeAddPeopleView(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Present modal filter view if Filter button tapped
    func presentFilterView(sender:UIBarButtonItem){
        performSegueWithIdentifier("filterPeople", sender: self)
    }
    
    // Send follow request to user whom current user requests to follow
    func followButtonTapped(sender:UIButton){
        let currentCell = sender.superview?.superview as! PersonFollowTableViewCell
        let currentIndexPath:NSIndexPath = self.peopleTableView.indexPathForCell(currentCell)!
        let userToFollow = self.people[currentIndexPath.row]
        var currentUserFollowingRequested:[PFUser] = (PFUser.currentUser()!)["followingRequested"] as! [PFUser]
//        let userToFollowFollowingRequestsFrom:[PFUser] = userToFollow["followingRequestsFrom"] as! [PFUser]
        currentUserFollowingRequested.append(userToFollow)
        PFUser.currentUser()!.fetchInBackgroundWithBlock{
            (object, error) -> Void in
            if error == nil {
                (PFUser.currentUser()!)["followingRequested"] = currentUserFollowingRequested
                PFUser.currentUser()!.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                    if error == nil{
                        let queryFollowRequests = PFQuery(className:"FollowerFollowing")
                        queryFollowRequests.whereKey("ownerUser", equalTo: userToFollow)
                        queryFollowRequests.findObjectsInBackgroundWithBlock{
                            (objects, error) -> Void in
                            if error == nil {
                                // The find succeeded.
                                self.loadPeople()
                                self.followRequestsFrom = objects!
                                let currentFollowerFollowingObject = self.followRequestsFrom[0] as! PFObject
                                var currentFollowRequestsFrom = currentFollowerFollowingObject["requestsFromUsers"] as! [PFUser]
                                currentFollowRequestsFrom.append(PFUser.currentUser()!)
                                currentFollowerFollowingObject["requestsFromUsers"] = currentFollowRequestsFrom
                                currentFollowerFollowingObject.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                                    if error == nil{
                                        let followRequestSentNotification = PFObject(className: "Notification")
                                        followRequestSentNotification["sender"] = PFUser.currentUser()
                                        followRequestSentNotification["receiver"] = userToFollow
                                        followRequestSentNotification["read"] = false
                                        followRequestSentNotification["type"] = "followRequestSent"
                                        followRequestSentNotification.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                                            if error == nil{
                                                // Send iOS Notification
                                                print("Follow request sent")
                                            }
                                        }
                                        
                                    }
                                    else{
                                        // Log details of the failure
                                        NSLog("Error: %@ %@", error!, error!.userInfo)
                                    }
                                    
                                }
                            } else {
                                // Log details of the failure
                                NSLog("Error: %@ %@", error!, error!.userInfo)
                            }
                        }                        
                    }
                    else{
                    }
                }

                

            }
            else{
            }
        }


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPersonDetail"{
            let newVC = segue.destinationViewController as! PersonDetailViewController
            newVC.user = self.user
        }
    }
    
    func showPersonDetail(sender:UITapGestureRecognizer){
        let currentIndexPath = self.peopleTableView.indexPathForRowAtPoint(sender.locationInView(self.peopleTableView)) as NSIndexPath!
        self.user = self.people[currentIndexPath.row]
        self.performSegueWithIdentifier("showPersonDetail", sender: self)
    }
    
    func filterHeaderTapped(){
        self.filterDictionary.removeAll(keepCapacity: false)
        self.loadPeople()
    }
}
