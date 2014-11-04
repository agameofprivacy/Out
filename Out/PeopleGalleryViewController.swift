//
//  PeopleGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/2/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var peopleTableView:UITableView!
    var people:[AnyObject] = []
    var followRequestsFrom:[AnyObject] = []
    var currentFollowerFollowingObject:PFObject!
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

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add People"
        
        var filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "presentFilterView:")
        filterButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = filterButton
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeAddPeopleView:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        
        self.peopleTableView = UITableView(frame: self.view.frame)
//        self.peopleTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
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
        
//        var viewsDictionary = ["peopleTableView":peopleTableView]
//        var metricsDictionary = ["marginZero":0]
//        
//        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-marginZero-[peopleTableView]-marginZero-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-marginZero-[peopleTableView]-marginZero-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        
//        self.view.addConstraints(horizontalConstraints)
//        self.view.addConstraints(verticalConstraints)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.loadPeople()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as PersonFollowTableViewCell

        var person = self.people[indexPath.row] as PFUser
        cell.userAvatar.backgroundColor = self.colorDictionary[person["color"] as String]
        cell.userAvatar.image = self.avatarImageDictionary[person["avatar"] as String]!
        cell.userAlias.text = person.username
        var personOrientation = person["sexualOrientation"] as String
        var personAge = person["age"] as Int
        cell.userOrientationAge.text = "\(personOrientation) . \(personAge)"
        cell.followButton.addTarget(self, action: "followButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    func loadPeople(){
        self.peopleTableView.hidden = true
        //        self.activityIndicator.startAnimating()
        var queryPeople = PFQuery(className:"_User")
        var objectIdArray:[String] = []
        objectIdArray.append(PFUser.currentUser().objectId)
        for user in PFUser.currentUser()["followingRequested"] as [PFUser]{
            objectIdArray.append(user.objectId)
        }

        queryPeople.whereKey("objectId", notContainedIn:objectIdArray)
        queryPeople.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.people = objects
                self.peopleTableView.reloadData()
                //                self.activityIndicator.stopAnimating()
                self.peopleTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func closeAddPeopleView(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func presentFilterView(sender:UIBarButtonItem){
        println("Present Filter")
    }
    
    func followButtonTapped(sender:UIButton){
        var currentCell = sender.superview?.superview as PersonFollowTableViewCell
        var currentIndexPath:NSIndexPath = self.peopleTableView.indexPathForCell(currentCell)!
        var userToFollow = self.people[currentIndexPath.row] as PFUser
        var currentUserFollowingRequested:[PFUser] = PFUser.currentUser()["followingRequested"] as [PFUser]
        var userToFollowFollowingRequestsFrom:[PFUser] = userToFollow["followingRequestsFrom"] as [PFUser]
        currentUserFollowingRequested.append(userToFollow)
        PFUser.currentUser()["followingRequested"] = currentUserFollowingRequested
        
        var queryFollowRequests = PFQuery(className:"FollowerFollowing")
        queryFollowRequests.whereKey("ownerUser", equalTo: userToFollow)
        queryFollowRequests.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.followRequestsFrom = objects
                var currentFollowerFollowingObject = self.followRequestsFrom[0] as PFObject
                var currentFollowRequestsFrom = currentFollowerFollowingObject["requestsFromUsers"] as [PFUser]
                currentFollowRequestsFrom.append(PFUser.currentUser())
                currentFollowerFollowingObject["requestsFromUsers"] = currentFollowRequestsFrom
                currentFollowerFollowingObject.saveInBackground()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        PFUser.currentUser().saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
            if error == nil{
                self.loadPeople()
                self.peopleTableView.reloadData()
            }
        }
        
        userToFollow.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
            if error == nil{

            }
            else{
            }
        }


    }
    
}
