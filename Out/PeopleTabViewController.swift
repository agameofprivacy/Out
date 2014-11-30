//
//  PeopleTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var followingRequestedFrom:[PFUser] = []
    var followingUsers:[PFUser] = []
    var followers:[AnyObject] = []
    var following:[AnyObject] = []
    var followerFollowingObject:PFObject = PFObject(className: "FollowerFollowing", dictionary: ["requestsFromUsers":[],"followers":[], "followingUsers":[]])
    
    var followerTableView:TPKeyboardAvoidingTableView!
    var followingTableView:TPKeyboardAvoidingTableView!
    var mentorCellOverlay:UIView!
    var segmentedControlView:UIView!
    var segmentedControl:UISegmentedControl!
    
    var mentorAppointment:UIButton!
    var mentorChat:UIButton!
    var mentorMore:UIButton!
    var mentorAvatar:UIImageView!
    var mentorRole:UILabel!
    var mentorAlias:UILabel!
    var mentorOrganization:UILabel!
    var mentorLocation:UILabel!
    var mentorButton:UIButton!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
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
        
        self.navigationItem.title = "People"
        
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPeople:")
        addButton.enabled = true
        addButton.tintColor = UIColor.blackColor()
        
        self.navigationItem.rightBarButtonItem = addButton

        
        self.view.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        
        
        self.followingTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.followingTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followingTableView.contentInset = UIEdgeInsets(top: 130.0, left: 0, bottom:0, right: 0)
        self.followingTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.followingTableView.backgroundColor = UIColor.whiteColor()
        self.followingTableView.frame = self.view.frame
        self.followingTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.followingTableView.rowHeight = UITableViewAutomaticDimension
        self.followingTableView.estimatedRowHeight = 80
        self.followingTableView.delegate = self
        self.followingTableView.dataSource = self
        self.followingTableView.layoutMargins = UIEdgeInsetsZero
        self.followingTableView.separatorInset = UIEdgeInsetsZero
        self.followingTableView.hidden = true
        self.view.addSubview(self.followingTableView)

        
        self.followerTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.followerTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followerTableView.contentInset = UIEdgeInsets(top: 194.0, left: 0, bottom:49, right: 0)
        self.followerTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.followerTableView.registerClass(PersonFollowTableViewCell.self, forCellReuseIdentifier: "PersonFollowTableViewCell")
        self.followerTableView.backgroundColor = UIColor.whiteColor()
        self.followerTableView.frame = self.view.frame
        self.followerTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.followerTableView.rowHeight = UITableViewAutomaticDimension
        self.followerTableView.estimatedRowHeight = 80
        self.followerTableView.delegate = self
        self.followerTableView.dataSource = self
        self.followerTableView.layoutMargins = UIEdgeInsetsZero
        self.followerTableView.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(self.followerTableView)


        
        
        self.mentorCellOverlay = UIView(frame: CGRectZero)
        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorCellOverlay.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var toMentorDetailTapRecognizer = UITapGestureRecognizer(target: self, action: "mentorCellTapped:")
        self.mentorCellOverlay.addGestureRecognizer(toMentorDetailTapRecognizer)
        self.view.addSubview(self.mentorCellOverlay)
        
        self.mentorAppointment = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorAppointment.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAppointment.tintColor = UIColor.blackColor()
//        self.mentorAppointment.setImage(UIImage(named: "calendar-icon"), forState: UIControlState.Normal)
        self.mentorCellOverlay.addSubview(self.mentorAppointment)
        
        self.mentorChat = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorChat.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorChat.tintColor = UIColor.blackColor()
//        self.mentorChat.setImage(UIImage(named: "chatBubble-icon"), forState: UIControlState.Normal)
        self.mentorCellOverlay.addSubview(self.mentorChat)
        
        self.mentorMore = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorMore.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorMore.setImage(UIImage(named: "more-icon"), forState: UIControlState.Normal)
        self.mentorMore.tintColor = UIColor.blackColor()
        self.mentorCellOverlay.addSubview(self.mentorMore)
        
        self.mentorAvatar = UIImageView(frame: CGRectZero)
        self.mentorAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAvatar.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
        self.mentorAvatar.layer.cornerRadius = 25
        self.mentorAvatar.clipsToBounds = true
        self.mentorAvatar.image = UIImage(named: "elephant-icon")
        self.mentorAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        self.mentorCellOverlay.addSubview(self.mentorAvatar)
        
        self.mentorRole = UILabel(frame: CGRectZero)
        self.mentorRole.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorRole.textAlignment = NSTextAlignment.Left
        self.mentorRole.font = titleFont?.fontWithSize(17.0)
        self.mentorRole.preferredMaxLayoutWidth = 50
        self.mentorRole.numberOfLines = 1
        self.mentorRole.text = "mentor"
        self.mentorCellOverlay.addSubview(self.mentorRole)

        self.mentorAlias = UILabel(frame: CGRectZero)
        self.mentorAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAlias.textAlignment = NSTextAlignment.Left
        self.mentorAlias.font = regularFont
        self.mentorAlias.preferredMaxLayoutWidth = 50
        self.mentorAlias.numberOfLines = 1
        self.mentorAlias.text = "eleph34"
        self.mentorCellOverlay.addSubview(self.mentorAlias)
        
        self.mentorOrganization = UILabel(frame: CGRectZero)
        self.mentorOrganization.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorOrganization.textAlignment = NSTextAlignment.Right
        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
        self.mentorOrganization.preferredMaxLayoutWidth = 200
        self.mentorOrganization.numberOfLines = 1
        self.mentorOrganization.text = "The Trevor Project"

        
        self.mentorLocation = UILabel(frame: CGRectZero)
        self.mentorLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorLocation.textAlignment = NSTextAlignment.Right
        self.mentorLocation.font = regularFont
        self.mentorLocation.preferredMaxLayoutWidth = 200
        self.mentorLocation.numberOfLines = 1
        self.mentorLocation.text = "New York, NY"
        
        self.mentorButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorButton.frame = CGRectZero
        self.mentorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorButton.setImage(UIImage(named: "rightChevron-icon"), forState: UIControlState.Normal)
        self.mentorButton.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        var mentorCellViewsDictionary = ["mentorAvatar":mentorAvatar, "mentorRole":mentorRole, "mentorAlias":mentorAlias, "mentorOrganization":mentorOrganization, "mentorLocation":mentorLocation, "mentorButton":mentorButton, "mentorAppointment":self.mentorAppointment, "mentorChat":self.mentorChat, "mentorMore":self.mentorMore]
        
        var mentorCellMetricsDictionary = ["sideMargin":15, "topMargin":64 + 16, "bottomMargin": 18]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mentorAvatar(50)]-20-[mentorRole]->=26-[mentorAppointment(36)]-32-[mentorChat(36)]-31-[mentorMore(36)]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        

        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAvatar(50)]-15-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        var appointmentVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAppointment(36)]-20-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)

        var chatVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorChat(36)]-19-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)

        var moreVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorMore(36)]-20-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)

        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-82-[mentorRole]-3-[mentorAlias]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        

        self.mentorCellOverlay.addConstraints(topHorizontalConstraints)
        self.mentorCellOverlay.addConstraints(avatarVerticalConstraints)
        self.mentorCellOverlay.addConstraints(leftVerticalConstraints)
        self.mentorCellOverlay.addConstraints(appointmentVerticalConstraints)
        self.mentorCellOverlay.addConstraints(chatVerticalConstraints)
        self.mentorCellOverlay.addConstraints(moreVerticalConstraints)

        
        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControlView.backgroundColor = UIColor.whiteColor()
        self.segmentedControlView.layer.masksToBounds = false
        self.segmentedControlView.layer.shadowColor = UIColor.blackColor().CGColor
        self.segmentedControlView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.segmentedControlView.layer.shadowOpacity = 0.1
        self.segmentedControlView.layer.shadowRadius = 1
        self.view.addSubview(self.segmentedControlView)

        self.segmentedControl = UISegmentedControl(items: ["Followers","Following"])
        self.segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControl.tintColor = UIColor.blackColor()
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.segmentedControlView.addSubview(self.segmentedControl)
        
        var viewsDictionary = ["mentorCellOverlay":mentorCellOverlay, "segmentedControlView":segmentedControlView]
        var metricsDiciontary = ["margin":0]
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[mentorCellOverlay(144)]-0-[segmentedControlView(44)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDiciontary, views: viewsDictionary)
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[mentorCellOverlay]-margin-|", options: NSLayoutFormatOptions(0), metrics: metricsDiciontary, views: viewsDictionary)
        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(horizontalConstraints)
        
        var segmentsViewsDictionary = ["segmentedControl":segmentedControl]
        var segmentsMetricsDictionary = ["margin":7.5]
        
        var segmentsHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[segmentedControl]-margin-|", options: NSLayoutFormatOptions(0), metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        var segmentsVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl]-10-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        
        self.segmentedControlView.addConstraints(segmentsHorizontalConstraints)
        self.segmentedControlView.addConstraints(segmentsVerticalConstraints)
        self.loadPeople()

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == "presentPeopleGallery"{
            var newVC = segue.destinationViewController as PeopleGalleryViewController
            newVC.currentFollowerFollowingObject = self.followerFollowingObject
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.followerTableView{
            return 2
        }
        else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == self.followerTableView{
            if section == 0{
                return self.followingRequestedFrom.count
            }
            else{
                return self.followers.count
            }
        }
        else{
            return self.following.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView == self.followerTableView{
            if(indexPath.section == 1){
                var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
                var followersUsers:[PFUser] = self.followers as [PFUser]
                var user = followersUsers[indexPath.row] as PFUser
//                user.fetchIfNeeded()
                cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as String]
                cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as String]!
                cell.userAlias.text = user.username
                var userOrientation = user["sexualOrientation"] as String
                var userAge = user["age"] as Int
                cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
                var userCity = user["city"] as String
                var userState = user["state"] as String
                cell.userLocation.text = "\(userCity), \(userState)"
                return cell
            }
            else{
                var cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as PersonFollowTableViewCell
                var followingRequestsFromUsers:[PFUser] = self.followingRequestedFrom as [PFUser]
                var user = followingRequestsFromUsers[indexPath.row] as PFUser

//                user.fetchIfNeeded()
                cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as String]
                cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as String]!
                cell.userAlias.text = user.username
                var userOrientation = user["sexualOrientation"] as String
                var userAge = user["age"] as Int
                cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
                var userCity = user["city"] as String
                var userState = user["state"] as String
                cell.followButton.addTarget(self, action: "acceptButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                cell.followButton.setTitle("Accept", forState: UIControlState.Normal)
                return cell
            }
        }
        else if tableView == self.followingTableView{
            var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
            var followingUsers:[PFUser] = self.following as [PFUser]
            var user = followingUsers[indexPath.row] as PFUser
//            user.fetchIfNeeded()
            cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as String]
            cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as String]!
            cell.userAlias.text = user.username
            var userOrientation = user["sexualOrientation"] as String
            var userAge = user["age"] as Int
            cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
            var userCity = user["city"] as String
            var userState = user["state"] as String
            cell.userLocation.text = "\(userCity), \(userState)"
            return cell
        }
        else{
            return tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mentorCellTapped(sender:UIGestureRecognizer){
        println("mentorButtonTapped!")
    }
    
    func valueChanged(segment:UISegmentedControl){
        if segment.selectedSegmentIndex == 0{
            self.followerTableView.hidden = false
            self.followingTableView.hidden = true
//            if (self.followerTableView.numberOfRowsInSection(0) > 0){
//                self.followerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
//            }
//            else if(self.followerTableView.numberOfRowsInSection(1) > 0){
//                self.followerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
//            }
        }
        else{
            self.followerTableView.hidden = true
            self.followingTableView.hidden = false
//            if (self.followingTableView.numberOfRowsInSection(0) > 0){
//                self.followingTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
//            }
        }
    }
    
    
    func acceptButtonTapped(sender:UIButton){
        var currentCell = sender.superview?.superview as PersonFollowTableViewCell
        var currentIndexPath:NSIndexPath = self.followerTableView.indexPathForCell(currentCell)!
        var userToAcceptFollowRequest = self.followingRequestedFrom[currentIndexPath.row] as PFUser
        var currentUserFollowingRequestedFrom = self.followingRequestedFrom
        
        var queryUserFollowRequestedFromFollowerFollowing = PFQuery(className: "FollowerFollowing")
        queryUserFollowRequestedFromFollowerFollowing.whereKey("ownerUser", equalTo:currentUserFollowingRequestedFrom[currentIndexPath.row])
        queryUserFollowRequestedFromFollowerFollowing.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                var userFollowRequestedFrom = objects[0] as PFObject
                var userFollowRequestedFromCurrentlyfollowing:[PFUser] = userFollowRequestedFrom["followingUsers"] as [PFUser]
                userFollowRequestedFromCurrentlyfollowing.append(PFUser.currentUser())
                userFollowRequestedFrom["followingUsers"] = userFollowRequestedFromCurrentlyfollowing
                userFollowRequestedFrom.saveInBackground()
                self.followerTableView.reloadData()
                //                self.activityIndicator.stopAnimating()
                self.followerTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

        var currentUserFollowers:[PFUser] = self.followerFollowingObject["followers"] as [PFUser]
        currentUserFollowers.append(userToAcceptFollowRequest)
        currentUserFollowingRequestedFrom.removeAtIndex(currentIndexPath.row)
        self.followerFollowingObject["requestsFromUsers"] = currentUserFollowingRequestedFrom
        self.followerFollowingObject["followers"] = currentUserFollowers
        self.followerFollowingObject.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
            if error == nil{
                self.loadPeople()
                self.followerTableView.reloadData()
            }
        }
    }

    
    func loadPeople(){
        self.followerTableView.hidden = true
//        self.activityIndicator.startAnimating()
        var queryFollowerFollowing = PFQuery(className:"FollowerFollowing")
        queryFollowerFollowing.whereKey("ownerUser", equalTo: PFUser.currentUser())
        queryFollowerFollowing.includeKey("followingUsers")
        queryFollowerFollowing.includeKey("followers")
        queryFollowerFollowing.includeKey("requestsFromUsers")
        queryFollowerFollowing.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.followerFollowingObject = objects[0] as PFObject
                // Causes long running operation warning
                self.followingRequestedFrom = self.followerFollowingObject["requestsFromUsers"] as [PFUser]
                self.following = self.followerFollowingObject["followingUsers"] as [PFUser]
                self.followers = self.followerFollowingObject["followers"] as [PFUser]
                // Causes long running operation warning
                self.followerTableView.reloadData()
                self.followingTableView.reloadData()
                //                self.activityIndicator.stopAnimating()
                self.followerTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    
    
    func addPeople(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("presentPeopleGallery", sender: self)
    }


}
