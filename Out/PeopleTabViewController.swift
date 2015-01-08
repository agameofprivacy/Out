//
//  PeopleTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for people tab view, displays mentor, following, and follower information
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
    
    var noFollowerView:UIView!
    var noFollowingView:UIView!
    
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
        
        // UINavigationBar init and layout
        self.navigationItem.title = "People"

        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPeople:")
        addButton.enabled = true
        addButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = addButton
        
        // followingTableView init
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

        // followerTableView init
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

        // mentorCellOverlay init
        self.mentorCellOverlay = UIView(frame: CGRectZero)
        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorCellOverlay.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var toMentorDetailTapRecognizer = UITapGestureRecognizer(target: self, action: "mentorCellTapped:")
        self.mentorCellOverlay.addGestureRecognizer(toMentorDetailTapRecognizer)
        self.view.addSubview(self.mentorCellOverlay)
        
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
        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
        self.mentorCellOverlay.addSubview(self.mentorOrganization)

        self.mentorLocation = UILabel(frame: CGRectZero)
        self.mentorLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorLocation.textAlignment = NSTextAlignment.Right
        self.mentorLocation.font = regularFont
        self.mentorLocation.preferredMaxLayoutWidth = 200
        self.mentorLocation.numberOfLines = 1
        self.mentorLocation.text = "New York, NY"
        self.mentorLocation.font = valueFont?.fontWithSize(14.0)
        self.mentorCellOverlay.addSubview(self.mentorLocation)
        
        self.mentorButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorButton.frame = CGRectZero
        self.mentorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorButton.setImage(UIImage(named: "rightChevron-icon"), forState: UIControlState.Normal)
        self.mentorButton.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        var mentorCellViewsDictionary = ["mentorAvatar":mentorAvatar, "mentorRole":mentorRole, "mentorAlias":mentorAlias, "mentorOrganization":mentorOrganization, "mentorLocation":mentorLocation, "mentorButton":mentorButton]
        
        var mentorCellMetricsDictionary = ["sideMargin":15, "topMargin":64 + 16, "bottomMargin": 18]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mentorAvatar(50)]-20-[mentorRole]->=26-[mentorOrganization]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        

        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAvatar(50)]-15-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-82-[mentorRole]-3-[mentorAlias]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        var rightVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-87-[mentorOrganization]-3-[mentorLocation]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)


        self.mentorCellOverlay.addConstraints(topHorizontalConstraints)
        self.mentorCellOverlay.addConstraints(avatarVerticalConstraints)
        self.mentorCellOverlay.addConstraints(leftVerticalConstraints)
        self.mentorCellOverlay.addConstraints(rightVerticalConstraints)
        
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
        
        // No follower view init and layout
        self.noFollowerView = UIView(frame: self.followerTableView.frame)
        self.noFollowerView.backgroundColor = UIColor.whiteColor()
        self.noFollowerView.center = self.view.center
        
        var noFollowerViewTitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowerView.frame.height / 5, self.noFollowerView.frame.width, 32))
        noFollowerViewTitle.text = "No Followers"
        noFollowerViewTitle.textAlignment = NSTextAlignment.Center
        noFollowerViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noFollowerViewTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noFollowerView.addSubview(noFollowerViewTitle)
        var noFollowerViewSubtitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowerView.frame.height / 5 + 31, self.noFollowerView.frame.width, 60))
        noFollowerViewSubtitle.text = "you will receive a follow request\nif someone follows you"
        noFollowerViewSubtitle.textAlignment = NSTextAlignment.Center
        noFollowerViewSubtitle.numberOfLines = 2
        noFollowerViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noFollowerViewSubtitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noFollowerView.addSubview(noFollowerViewSubtitle)
        
        self.noFollowerView.hidden = true
        self.followerTableView.addSubview(self.noFollowerView)

        // No following view init and layout
        self.noFollowingView = UIView(frame: self.followingTableView.frame)
        self.noFollowingView.center = self.view.center
        self.noFollowingView.backgroundColor = UIColor.whiteColor()
        
        var noFollowingViewTitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowingView.frame.height / 5, self.noFollowingView.frame.width, 32))
        noFollowingViewTitle.text = "Not Following Anyone"
        noFollowingViewTitle.textAlignment = NSTextAlignment.Center
        noFollowingViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noFollowingViewTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noFollowingView.addSubview(noFollowingViewTitle)
        var noFollowingViewSubtitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowingView.frame.height / 5 + 31, self.noFollowingView.frame.width, 30))
        noFollowingViewSubtitle.text = "tap '+' to add people"
        noFollowingViewSubtitle.textAlignment = NSTextAlignment.Center
        noFollowingViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noFollowingViewSubtitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noFollowingView.addSubview(noFollowingViewSubtitle)
        self.noFollowingView.hidden = true
        self.followingTableView.addSubview(self.noFollowingView)

        // Load people data from Parse
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
        // followerTableView has two sections, one for follow requests and one for approved followers
        if tableView == self.followerTableView{
            return 2
        }
        // followingTableView has one section
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
    
    // Table view data source methods for followerTableView and followingTableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView == self.followerTableView{
            // If section is for displaying follower(s)
            if(indexPath.section == 1){
                var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
                var followersUsers:[PFUser] = self.followers as [PFUser]
                var user = followersUsers[indexPath.row] as PFUser
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
            // If section is for displaying follow requests
            else{
                var cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as PersonFollowTableViewCell
                var followingRequestsFromUsers:[PFUser] = self.followingRequestedFrom as [PFUser]
                var user = followingRequestsFromUsers[indexPath.row] as PFUser
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
        // Display following
        else if tableView == self.followingTableView{
            var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
            var followingUsers:[PFUser] = self.following as [PFUser]
            var user = followingUsers[indexPath.row] as PFUser
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
    }
    
    // Segue to mentor detail view if Mentor Overlay tapped
    func mentorCellTapped(sender:UIGestureRecognizer){
        self.performSegueWithIdentifier("viewMentor", sender: self)
    }
    
    // Switch between follower and following tables with segmented control value change
    func valueChanged(segment:UISegmentedControl){
        if segment.selectedSegmentIndex == 0{
            self.followerTableView.hidden = false
            self.followingTableView.hidden = true
            if self.followers.count == 0 && self.followingRequestedFrom.count == 0{
                self.noFollowerView.hidden = false
            }
            else{
                self.noFollowerView.hidden = true
            }
        }
        else{
            self.followerTableView.hidden = true
            self.followingTableView.hidden = false
            if self.following.count == 0{
                self.noFollowingView.hidden = false
            }
            else{
                self.noFollowingView.hidden = true
            }

        }
    }
    
    // Add PFUser to list of approved followers if Accept button tapped
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
                var userFollowRequestedFrom = objects[0] as PFObject
                var userFollowRequestedFromCurrentlyfollowing:[PFUser] = userFollowRequestedFrom["followingUsers"] as [PFUser]
                userFollowRequestedFromCurrentlyfollowing.append(PFUser.currentUser())
                userFollowRequestedFrom["followingUsers"] = userFollowRequestedFromCurrentlyfollowing
                userFollowRequestedFrom.saveInBackground()
                self.followerTableView.reloadData()
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

    // Load people data from Parse
    func loadPeople(){
        self.followerTableView.hidden = true
        var queryFollowerFollowing = PFQuery(className:"FollowerFollowing")
        queryFollowerFollowing.whereKey("ownerUser", equalTo: PFUser.currentUser())
        queryFollowerFollowing.includeKey("followingUsers")
        queryFollowerFollowing.includeKey("followers")
        queryFollowerFollowing.includeKey("requestsFromUsers")
        queryFollowerFollowing.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.followerFollowingObject = objects[0] as PFObject
                self.followingRequestedFrom = self.followerFollowingObject["requestsFromUsers"] as [PFUser]
                self.following = self.followerFollowingObject["followingUsers"] as [PFUser]
                self.followers = self.followerFollowingObject["followers"] as [PFUser]
                if self.following.count == 0{
                    self.noFollowingView.hidden = false
                }
                else{
                    self.noFollowingView.hidden = true
                }
                if self.followers.count == 0 && self.followingRequestedFrom.count == 0{
                    self.noFollowerView.hidden = false
                }
                else{
                    self.noFollowerView.hidden = true
                }

                self.followerTableView.reloadData()
                self.followingTableView.reloadData()
                self.followerTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    
    // Present people gallery if Add button tapped
    func addPeople(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("presentPeopleGallery", sender: self)
    }


}
