//
//  PersonDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/11/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import Parse
class PersonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: PFUser!
    var tableView: TPKeyboardAvoidingTableView!
    var aboutArray:[[String]] = []
    var userActivities:[PFObject] = []
    var processedActivities:NSMutableArray = []
    var currentActivitiesLikeCount:[Int] = []
    var currentActivitiesCommentCount:[Int] = []
    var currentUserFollowingId:[String] = []
    var currentUserFollowerId:[String] = []
    var followingRequestedId:[String] = []
    var followStatusChecked:Bool = false
    
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
        self.navigationItem.title = self.user.username
        self.tableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.contentInset.bottom = 49.5
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.registerClass(PersonDetailTableViewCell.self, forCellReuseIdentifier: "PersonDetailTableViewCell")
        self.tableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.tableView.registerClass(StatusActivityTableViewCell.self, forCellReuseIdentifier: "StatusActivityTableViewCell")

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView)
        
        let viewsDictionary = ["tableView":self.tableView]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)

        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        let age = self.user["age"] as! Int
        let ageString = "\(age)"
        let sexualOrientation = self.user["sexualOrientation"] as! String
        let genderIdentity = self.user["genderIdentity"] as! String
        let ethnicity = self.user["ethnicity"] as! String
        let religion = self.user["religion"] as! String
        let city = self.user["city"] as! String
        let state = self.user["state"] as! String

        self.aboutArray.append(["Age", ageString])
        self.aboutArray.append(["Sexual Orientation", sexualOrientation])
        self.aboutArray.append(["Gender Identity", genderIdentity])
        self.aboutArray.append(["Ethnicity", ethnicity])
        self.aboutArray.append(["Religion", religion])
        self.aboutArray.append(["City", city])
        self.aboutArray.append(["State", state])
        
        // Do any additional setup after loading the view.
        
        self.loadActivities("old")
        self.loadFollowerFollowing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            let numberOfRows = self.aboutArray.count + self.userActivities.count + 2
            return numberOfRows
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            let age = self.user["age"] as! Int
            let basicStatsString = "\(age)" + " · " + (self.user["sexualOrientation"] as! String) + " · " + (self.user["genderIdentity"] as! String)
//            var advanceStatsString = (self.user["ethnicity"] as! String) + " · " + (self.user["religion"] as! String) + " · " + (self.user["city"] as! String) + " " + (self.user["state"] as! String)
            
            let advanceStatsString = self.user["shortBio"] as! String
            
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonDetailTableViewCell") as! PersonDetailTableViewCell
            
            
            
            cell.basicsLabel.text = basicStatsString
            cell.aboutTextView.text = advanceStatsString
            cell.avatarImageView.image = cell.avatarImageDictionary[self.user["avatar"] as! String]!
            cell.avatarImageView.backgroundColor = cell.colorDictionary[self.user["color"] as! String]
            if self.followStatusChecked{
                if self.currentUserFollowingId.contains(self.user.objectId!){
                    cell.followButton.setTitle("Unfollow", forState: UIControlState.Normal)
                }
                else if self.followingRequestedId.contains(PFUser.currentUser()!.objectId!){
                    cell.followButton.setTitle("Requested", forState: UIControlState.Normal)
                }
//                else if contains(self.currentUserFollowerId, self.user.objectId){
//                    cell.followButton.setTitle("Follow", forState: UIControlState.Normal)
//                }
                else{
                    cell.followButton.setTitle("Follow", forState: UIControlState.Normal)                
                }
                cell.followButton.enabled = true
            }
            let followButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "followButtonTapped:")
            cell.followButton.addGestureRecognizer(followButtonTapGestureRecognizer)
            return cell
        }
        else if indexPath.section == 1{
            if indexPath.row < self.aboutArray.count{
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Value1")
                cell.textLabel!.text = self.aboutArray[indexPath.row][0]
                cell.detailTextLabel!.text = self.aboutArray[indexPath.row][1]
                return cell
            }
            else if indexPath.row < self.aboutArray.count + self.userActivities.count && self.processedActivities.count > 0{
                var currentActivity = self.processedActivities[indexPath.row - self.aboutArray.count] as! [String:String!]
                
                let currentActivityImageString:String = currentActivity["currentActivityImageString"]!
                if (currentActivityImageString != ""){
                    let cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as! ActivityTableViewCell
                    cell.heroImageView.image = UIImage(named: currentActivityImageString)
//                    var activityContentPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: "showActivityContentPreviewTapped:")
//                    cell.contentCanvas.addGestureRecognizer(activityContentPreviewTapRecognizer)
                    
                    
                    cell.reverseTimeLabel.text = currentActivity["timeLabel"]!
                    cell.avatarImageView.image = UIImage(named: currentActivity["avatarImageViewImageString"]!)
                    
                    cell.avatarImageView.backgroundColor = self.colorDictionary[currentActivity["avatarImageViewBackgroundColorString"]!]
//                    var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
//                    cell.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
//                    var aliastapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                    cell.aliasLabel.text = currentActivity["aliasLabel"]!
//                    cell.aliasLabel.addGestureRecognizer(aliastapGestureRecognizer)
                    cell.actionLabel.text = currentActivity["actionLabelText"]!
                    
                    cell.narrativeTitleLabel.text = currentActivity["currentNarrativeTitleString"]!
                    cell.narrativeContentLabel.text = currentActivity["currentNarrativeContentString"]!
                    
                    cell.likeCountLabel.text = currentActivity["likeCountLabel"]!
                    cell.commentsCountLabel.text = currentActivity["commentCountLabel"]!
                    
                    if (currentActivity["liked"] == "yes"){
                        cell.likeButton.image = UIImage(named: "likeButtonFilled-icon")
                    }
                    else{
                        cell.likeButton.image = UIImage(named: "likeButton-icon")
                    }
//                    var likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
//                    cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
//                    
//                    var commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
//                    cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)
                    return cell
                }
                else{
                    let cell:StatusActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("StatusActivityTableViewCell") as! StatusActivityTableViewCell
                    
                    cell.reverseTimeLabel.text = currentActivity["timeLabel"]!
                    cell.avatarImageView.image = UIImage(named: currentActivity["avatarImageViewImageString"]!)
                    cell.avatarImageView.backgroundColor = self.colorDictionary[currentActivity["avatarImageViewBackgroundColorString"]!]
                    
//                    var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
//                    cell.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
//                    var aliastapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                    cell.aliasLabel.text = currentActivity["aliasLabel"]!
//                    cell.aliasLabel.addGestureRecognizer(aliastapGestureRecognizer)
                    cell.actionLabel.text = currentActivity["actionLabelText"]!
                    
                    cell.likeCountLabel.text = currentActivity["likeCountLabel"]!
                    cell.commentsCountLabel.text = currentActivity["commentCountLabel"]!
                    
                    if (currentActivity["liked"] == "yes"){
                        cell.likeButton.image = UIImage(named: "likeButtonFilled-icon")
                    }
                    else{
                        cell.likeButton.image = UIImage(named: "likeButton-icon")
                    }
//                    var likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
//                    cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
//                    
//                    var commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
//                    cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)
                    return cell
                }
            }
            else{
                let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
                if indexPath.row == self.tableView.numberOfRowsInSection(1) - 2{
                    cell.textLabel!.text = "Report for Spam"
                    cell.detailTextLabel!.text = "Report this user for spam activity"
                }
                else{
                    cell.textLabel!.text = "Block"
                    cell.detailTextLabel!.text = "Block any contact with this user"
                }
                return cell
            }
        }
        else{
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let segmentedControlView = UIView()
            segmentedControlView.backgroundColor = UIColor.whiteColor()
            
            let segmentedControl = UISegmentedControl(items: ["About","Activities", "More"])
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.tintColor = UIColor.blackColor()
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControlView.addSubview(segmentedControl)
            
            let segmentedControlViewSeparator = UIView(frame: CGRectZero)
            segmentedControlViewSeparator.translatesAutoresizingMaskIntoConstraints = false
            segmentedControlViewSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            segmentedControlView.addSubview(segmentedControlViewSeparator)
            
            let metricsDictionary = ["sideMargin":7.5]
            let viewsDictionary = ["segmentedControl":segmentedControl, "segmentedControlViewSeparator":segmentedControlViewSeparator]
            
            let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl(28)]-8-[segmentedControlViewSeparator(0.5)]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
            let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[segmentedControl]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
            let separatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentedControlViewSeparator]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)

            segmentedControlView.addConstraints(verticalConstraints)
            segmentedControlView.addConstraints(horizontalConstraints)
            segmentedControlView.addConstraints(separatorHorizontalConstraints)
            
            return segmentedControlView
        }
        else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 44.5
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            return 150
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    
    func valueChanged(segment:UISegmentedControl){
        switch segment.selectedSegmentIndex{
        case 0:
            print("About")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        case 1:
            print("Activities")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.aboutArray.count, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        default:
            print("More")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.tableView.numberOfRowsInSection(1) - 1, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
    }

    func loadActivities(context:String){
        let followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser()!)
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                // Found FollowerFollowing object for current user
                let activityQuery = PFQuery(className: "Activity")
                // Include current user so user's own activities also show up
                activityQuery.whereKey("ownerUser", equalTo: self.user)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                activityQuery.limit = 10
                if context == "old"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", lessThan: (self.userActivities.last as PFObject!).createdAt!)
                    }
                }
                else if context == "new"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThan: (self.userActivities.first as PFObject!).createdAt!)
                    }
                }
                else if context == "update"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThanOrEqualTo: (self.userActivities.last as PFObject!).createdAt!)
                        activityQuery.whereKey("createdAt", lessThanOrEqualTo: (self.userActivities.first as PFObject!).createdAt!)
                        activityQuery.limit = 1000
                    }
                }
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects, error) -> Void in
                    if error == nil {
                        
                        // Found activities
                        let userActivitiesFound = objects!
                        var currentLikedAcitivitiesFoundIdStrings:[String] = []
                        if context == "old"{
                            if (objects!.count == 10){
//                                self.moreActivities = true
                            }
                            else{
//                                self.moreActivities = false
                            }
                        }
                        // If activities count is 0, show no activity view, else display activities
                        if context == "old"{
                            self.userActivities.appendContentsOf(userActivitiesFound)
                        }
                        else if context == "new"{
                            self.userActivities.insertContentsOf(userActivitiesFound, at: 0)
                        }
                        else if context == "update"{
                            self.userActivities = userActivitiesFound
                        }
                        if self.userActivities.count == 0{
//                            self.noActivityView.hidden = false
//                            self.refreshControl?.endRefreshing()
                        }
                        else{
//                            self.noActivityView.hidden = true
                        }
                        if userActivitiesFound.isEmpty{
                            print("no more activities")
//                            self.refreshControl?.endRefreshing()
                        }
                        // Query activities liked by current user
                        var userActivitiesFoundCommentCount = Array(count: userActivitiesFound.count, repeatedValue: 0)
                        var userActivitiesFoundLikeCount = Array(count: userActivitiesFound.count, repeatedValue: 0)
                        var likeCountFound = 0
                        var commentCountFound = 0
                        let relation = PFUser.currentUser()!.relationForKey("likedActivity")
                        relation.query()!.findObjectsInBackgroundWithBlock{
                            (objects, error) -> Void in
                            if error == nil {
                                for object in objects!{
                                    currentLikedAcitivitiesFoundIdStrings.append(object.objectId!)
                                }
                            }
                            else {
                                // Log details of the failure
                                NSLog("Error: %@ %@", error!, error!.userInfo)
//                                self.refreshControl?.endRefreshing()
                            }
                        }
                        
                        // Query like count of activities
                        for activity in userActivitiesFound{
                            let queryLikes = PFQuery(className: "_User")
                            queryLikes.whereKey("likedActivity", equalTo: activity)
                            queryLikes.findObjectsInBackgroundWithBlock{
                                (objects, error) -> Void in
                                if error == nil {
                                    let count = objects!.count
                                    userActivitiesFoundLikeCount[userActivitiesFound.indexOf(activity)!] = count
                                    ++likeCountFound
                                    
                                    // Query comment count of activities
                                    let queryComments = PFQuery(className: "Comment")
                                    queryComments.whereKey("activity", equalTo: activity)
                                    queryComments.findObjectsInBackgroundWithBlock{
                                        (objects, error) -> Void in
                                        if error == nil {
                                            let count = objects!.count
                                            userActivitiesFoundCommentCount[userActivitiesFound.indexOf(activity)!] = count
                                            ++commentCountFound
                                            if likeCountFound == userActivitiesFound.count && commentCountFound == userActivitiesFound.count{
                                                self.prepareDataForTableView(userActivitiesFound, currentActivitiesFoundCommentCount: userActivitiesFoundCommentCount, currentActivitiesFoundLikeCount: userActivitiesFoundLikeCount, currentLikedAcitivitiesFoundIdStrings: currentLikedAcitivitiesFoundIdStrings, context:context)
                                                
                                                if self.tableView.numberOfRowsInSection(0) != 0{
                                                    //                                                        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                                                    self.tableView.reloadData()
                                                }
                                                else{
                                                    self.tableView.reloadData()
                                                }
                                                
//                                                self.refreshControl?.endRefreshing()
                                                
                                            }
                                        }
                                        else {
                                            // Log details of the failure
                                            NSLog("Error: %@ %@", error!, error!.userInfo)
//                                            self.refreshControl?.endRefreshing()
                                            
                                        }
                                    }
                                    
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error!, error!.userInfo)
//                                    self.refreshControl?.endRefreshing()
                                }
                            }
                            
                        }
                        
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error!, error!.userInfo)
//                        self.refreshControl?.endRefreshing()
                        
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
//                self.refreshControl?.endRefreshing()
                
            }
        }
        
    }
    
    func prepareDataForTableView(activitiesToAppend:[PFObject], currentActivitiesFoundCommentCount:[Int], currentActivitiesFoundLikeCount:[Int], currentLikedAcitivitiesFoundIdStrings:[String], context:String){
        //        self.processedActivities.removeAllObjects()
        var activityCount = 0
        if context == "update"{
            self.processedActivities.removeAllObjects()
            self.currentActivitiesLikeCount.removeAll(keepCapacity: false)
            self.currentActivitiesCommentCount.removeAll(keepCapacity: false)
        }
        
        for activity in activitiesToAppend{
            let currentActivityCreatedTime = activity.createdAt
            let currentActivityChallenge = activity["challenge"] as! PFObject
            let currentActivityUserChallengeData = activity["userChallengeData"] as! PFObject
            let currentActivityUser = activity["ownerUser"] as! PFUser
            let currentAvatarString = currentActivityUser["avatar"] as! String
            let currentAvatarColor = currentActivityUser["color"] as! String
            let currentAction = currentActivityChallenge["action"] as! String
            var currentChallengeTrackNumber = Int((currentActivityUserChallengeData["challengeTrackNumber"] as! String))!
            currentChallengeTrackNumber = currentChallengeTrackNumber - 1
            let activityCreatedTimeLabel = currentActivityCreatedTime!.shortTimeAgoSinceNow()
            
            
            var currentActivityDictionary = ["timeLabel":activityCreatedTimeLabel, "avatarImageViewImageString":"\(currentAvatarString)-icon", "avatarImageViewBackgroundColorString":currentAvatarColor, "aliasLabel":currentActivityUser.username, "actionLabelText":currentAction, "currentActivityImageString":"", "currentNarrativeTitleString":"", "currentNarrativeContentString":"", "likeCountLabel":"", "commentCountLabel":"No comment", "liked":"no"]
            
            var currentActivityImageString:String
            
            if (currentActivityChallenge["narrativeImages"] as! [String]).count > 0{
                currentActivityImageString = (currentActivityChallenge["narrativeImages"] as! [String])[currentChallengeTrackNumber] as String
                currentActivityDictionary.updateValue(currentActivityImageString, forKey: "currentActivityImageString")
            }
            
            var currentNarrativeTitleString:String
            if (currentActivityChallenge["narrativeTitles"] as! [String]).count > 0{
                currentNarrativeTitleString = (currentActivityChallenge["narrativeTitles"] as! [String])[currentChallengeTrackNumber] as String
                currentActivityDictionary.updateValue(currentNarrativeTitleString, forKey: "currentNarrativeTitleString")
            }
            
            
            var currentNarrativeContentString:String
            if (currentActivityChallenge["narrativeTitles"] as! [String]).count > 0{
                currentNarrativeContentString = (currentActivityChallenge["narrativeContents"] as! [String])[currentChallengeTrackNumber] as String
                currentActivityDictionary.updateValue(currentNarrativeContentString, forKey: "currentNarrativeContentString")
            }
            
            
            
            if currentActivitiesFoundLikeCount.count == 0{
            }
            else{
                if currentActivitiesFoundLikeCount[activityCount] > 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundLikeCount[activityCount]) likes", forKey: "likeCountLabel")
                }
                else if currentActivitiesFoundLikeCount[activityCount] == 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundLikeCount[activityCount]) like", forKey: "likeCountLabel")
                }
            }
            if currentActivitiesFoundCommentCount.count == 0{
            }
            else{
                if currentActivitiesFoundCommentCount[activityCount] > 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundCommentCount[activityCount]) comments", forKey: "commentCountLabel")
                }
                else if currentActivitiesFoundCommentCount[activityCount] == 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundCommentCount[activityCount]) comment", forKey: "commentCountLabel")
                }
            }
            
            if currentLikedAcitivitiesFoundIdStrings.contains(activity.objectId!){
                currentActivityDictionary.updateValue("yes", forKey: "liked")
            }
            if context == "old"{
                self.processedActivities.addObject(currentActivityDictionary)
                self.currentActivitiesLikeCount.appendContentsOf(currentActivitiesFoundLikeCount)
                self.currentActivitiesCommentCount.appendContentsOf(currentActivitiesFoundCommentCount)
            }
            else if context == "new"{
                self.processedActivities.insertObject(currentActivityDictionary, atIndex: 0)
                self.currentActivitiesLikeCount.insertContentsOf(currentActivitiesFoundLikeCount, at: 0)
                self.currentActivitiesCommentCount.insertContentsOf(currentActivitiesFoundCommentCount, at: 0)
            }
            else if context == "update"{
                self.processedActivities.addObject(currentActivityDictionary)
                self.currentActivitiesLikeCount.appendContentsOf(currentActivitiesFoundLikeCount)
                self.currentActivitiesCommentCount.appendContentsOf(currentActivitiesFoundCommentCount)
            }
            ++activityCount
        }
    }
    
    func loadFollowerFollowing(){
        let followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser()!)
//        followingQuery.includeKey("followers")
//        followingQuery.includeKey("followingUsers")
        followingQuery.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    for user in object["followers"] as! [PFUser]{
                        self.currentUserFollowerId.append(user.objectId!)
                    }
                    for user in object["followingUsers"] as! [PFUser]{
                        self.currentUserFollowingId.append(user.objectId!)
                    }
                    
                    let followingRequestQuery = PFQuery(className: "FollowerFollowing")
                    followingRequestQuery.whereKey("ownerUser", equalTo: self.user)
                    followingRequestQuery.findObjectsInBackgroundWithBlock{
                        (objects, error) -> Void in
                        if error == nil{
                            for object in objects!{
                                for user in object["requestsFromUsers"] as! [PFUser]{
                                    self.followingRequestedId.append(user.objectId!)
                                }
                                print(self.followingRequestedId)
                                self.followStatusChecked = true
                                self.tableView.reloadData()
                            }
                        }
                        else{
                        
                        }
                    }

//                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                }
            }
            else{
            }
        }
    }
    
    func followButtonTapped(sender:UITapGestureRecognizer){
        let followButton = sender.view as! UIButton
        if followButton.titleLabel?.text == "Follow"{
            print("Follow")
            let userToFollow = self.user
            var currentUserFollowingRequested:[PFUser] = (PFUser.currentUser()!)["followingRequested"] as! [PFUser]
//            let userToFollowFollowingRequestsFrom:[PFUser] = userToFollow["followingRequestsFrom"] as! [PFUser]
            currentUserFollowingRequested.append(userToFollow)
            PFUser.currentUser()!.fetchInBackgroundWithBlock{
                (object, error) -> Void in
                if error == nil {
                    (PFUser.currentUser()!)["followingRequested"] = currentUserFollowingRequested
                    (PFUser.currentUser()!).saveInBackgroundWithBlock{(succeeded, error) -> Void in
                        if error == nil{
                            let queryFollowRequests = PFQuery(className:"FollowerFollowing")
                            queryFollowRequests.whereKey("ownerUser", equalTo: userToFollow)
                            queryFollowRequests.findObjectsInBackgroundWithBlock{
                                (objects, error) -> Void in
                                if error == nil {
                                    // The find succeeded.
                                    var followRequestsFrom = objects!
                                    let currentFollowerFollowingObject = followRequestsFrom[0] as PFObject
                                    var currentFollowRequestsFrom = currentFollowerFollowingObject["requestsFromUsers"] as! [PFUser]
                                    currentFollowRequestsFrom.append(PFUser.currentUser()!)
                                    currentFollowerFollowingObject["requestsFromUsers"] = currentFollowRequestsFrom
                                    currentFollowerFollowingObject.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                                        if error == nil{
                                            self.loadFollowerFollowing()
                                            if (self.parentViewController?.childViewControllers[0].isKindOfClass(PeopleGalleryViewController) != nil){
                                                let peopleGallery = self.parentViewController?.childViewControllers[0] as! PeopleGalleryViewController
                                                peopleGallery.loadPeople()
                                            }
                                            //                            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
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
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error!, error!.userInfo)
                                }
                            }
                        }
                        else{
                        }
                    }
                    
                }
                else if followButton.titleLabel?.text == "Unfollow"{
                    print("Unfollow")
                }
                else if followButton.titleLabel?.text == "Requested"{
                    print("Requested")
                }

                else{
                }
            }
        }
    }
}
