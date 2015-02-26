//
//  PeopleGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/2/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for people gallery view, displays people avaialable to be followed by current user
class PeopleGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var peopleTableView:UITableView!
    var people:[AnyObject] = []
    var followRequestsFrom:[AnyObject] = []
    var currentFollowerFollowingObject:PFObject!
    var noPeopleView:UIView!
    
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
        
        var filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "presentFilterView:")
        filterButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = filterButton
 
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeAddPeopleView:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.peopleTableView = UITableView(frame: self.view.frame)
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 80
        self.peopleTableView.frame = self.view.frame
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.peopleTableView.registerClass(PersonFollowTableViewCell.self, forCellReuseIdentifier: "PersonFollowTableViewCell")
        self.peopleTableView.delegate = self
        self.peopleTableView.dataSource = self
        self.peopleTableView.hidden = true
        self.peopleTableView.layoutMargins = UIEdgeInsetsZero
        self.peopleTableView.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(self.peopleTableView)
        
        // No people view init and layout
        self.noPeopleView = UIView(frame: self.peopleTableView.frame)
        self.noPeopleView.center = self.view.center
        
        var noPeopleViewTitle = UILabel(frame: CGRectMake(0, 2 * self.noPeopleView.frame.height / 5, self.noPeopleView.frame.width, 32))
        noPeopleViewTitle.text = "You've Followed Them All"
        noPeopleViewTitle.textAlignment = NSTextAlignment.Center
        noPeopleViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noPeopleViewTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noPeopleView.addSubview(noPeopleViewTitle)

        var noPeopleViewSubtitle = UILabel(frame: CGRectMake(0, 2 * self.noPeopleView.frame.height / 5 + 31, self.noPeopleView.frame.width, 30))
        noPeopleViewSubtitle.text = "you're quite a follower indeed"
        noPeopleViewSubtitle.textAlignment = NSTextAlignment.Center
        noPeopleViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noPeopleViewSubtitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noPeopleView.addSubview(noPeopleViewSubtitle)
        self.noPeopleView.hidden = true
        self.view.addSubview(self.noPeopleView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.loadPeople()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    // Table view data source method
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as! PersonFollowTableViewCell

        var person = self.people[indexPath.row] as! PFUser
        cell.userAvatar.backgroundColor = self.colorDictionary[person["color"] as! String]
        cell.userAvatar.image = self.avatarImageDictionary[person["avatar"] as! String]!
        cell.userAlias.text = person.username
        var personOrientation = person["sexualOrientation"] as! String
        var personAge = person["age"] as! Int
        cell.userOrientationAge.text = "\(personOrientation) . \(personAge)"
        cell.followButton.addTarget(self, action: "followButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    // Load people data from Parse
    func loadPeople(){
        self.peopleTableView.hidden = true
        var queryPeople = PFQuery(className:"_User")
        var objectIdArray:[String] = []
        objectIdArray.append(PFUser.currentUser().objectId)

        // Compile a PFUser array of users already sent following requests to
        for user in PFUser.currentUser()["followingRequested"] as! [PFUser]{
            objectIdArray.append(user.objectId)
        }
        // Filter so only users who current user hasn't sent a follow request to are included
        queryPeople.whereKey("objectId", notContainedIn:objectIdArray)
        queryPeople.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.people = objects
                self.peopleTableView.reloadData()
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
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
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
        var currentCell = sender.superview?.superview as! PersonFollowTableViewCell
        var currentIndexPath:NSIndexPath = self.peopleTableView.indexPathForCell(currentCell)!
        var userToFollow = self.people[currentIndexPath.row] as! PFUser
        var currentUserFollowingRequested:[PFUser] = PFUser.currentUser()["followingRequested"] as! [PFUser]
        var userToFollowFollowingRequestsFrom:[PFUser] = userToFollow["followingRequestsFrom"] as! [PFUser]
        currentUserFollowingRequested.append(userToFollow)
        PFUser.currentUser()["followingRequested"] = currentUserFollowingRequested
        
        var queryFollowRequests = PFQuery(className:"FollowerFollowing")
        queryFollowRequests.whereKey("ownerUser", equalTo: userToFollow)
        queryFollowRequests.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.followRequestsFrom = objects
                var currentFollowerFollowingObject = self.followRequestsFrom[0] as! PFObject
                var currentFollowRequestsFrom = currentFollowerFollowingObject["requestsFromUsers"] as! [PFUser]
                currentFollowRequestsFrom.append(PFUser.currentUser())
                currentFollowerFollowingObject["requestsFromUsers"] = currentFollowRequestsFrom
                currentFollowerFollowingObject.saveInBackground()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        PFUser.currentUser().saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
            if error == nil{
                self.loadPeople()
                self.peopleTableView.reloadData()
            }
        }
        
        userToFollow.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
            if error == nil{

            }
            else{
            }
        }


    }
    
}
