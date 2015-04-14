//
//  PersonDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/11/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: PFUser!
    var tableView: TPKeyboardAvoidingTableView!
    var aboutArray:[[String]] = []
    var userActivities:[PFObject] = []
    var processedActivities:NSMutableArray = []
    var currentActivitiesLikeCount:[Int] = []
    var currentActivitiesCommentCount:[Int] = []

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
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.registerClass(PersonDetailTableViewCell.self, forCellReuseIdentifier: "PersonDetailTableViewCell")
        self.tableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.tableView.registerClass(StatusActivityTableViewCell.self, forCellReuseIdentifier: "StatusActivityTableViewCell")

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView)
        
        var viewsDictionary = ["tableView":self.tableView]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)

        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        var age = self.user["age"] as! Int
        var ageString = "\(age)"
        var sexualOrientation = self.user["sexualOrientation"] as! String
        var genderIdentity = self.user["genderIdentity"] as! String
        var ethnicity = self.user["ethnicity"] as! String
        var religion = self.user["religion"] as! String
        var city = self.user["city"] as! String
        var state = self.user["state"] as! String

        self.aboutArray.append(["Age", ageString])
        self.aboutArray.append(["Sexual Orientation", sexualOrientation])
        self.aboutArray.append(["Gender Identity", genderIdentity])
        self.aboutArray.append(["Ethnicity", ethnicity])
        self.aboutArray.append(["Religion", religion])
        self.aboutArray.append(["City", city])
        self.aboutArray.append(["State", state])
        
        // Do any additional setup after loading the view.
        
        self.loadActivities("old")
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
            var numberOfRows = self.aboutArray.count + self.userActivities.count + 2
            return numberOfRows
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            var age = self.user["age"] as! Int
            var basicStatsString = "\(age)" + " · " + (self.user["sexualOrientation"] as! String) + " · " + (self.user["genderIdentity"] as! String)
            var advanceStatsString = (self.user["ethnicity"] as! String) + " · " + (self.user["religion"] as! String) + " · " + (self.user["city"] as! String) + " " + (self.user["state"] as! String)
            var cell = tableView.dequeueReusableCellWithIdentifier("PersonDetailTableViewCell") as! PersonDetailTableViewCell
            
            cell.basicsLabel.text = basicStatsString
            cell.aboutTextView.text = advanceStatsString
            cell.avatarImageView.image = cell.avatarImageDictionary[self.user["avatar"] as! String]!
            cell.avatarImageView.backgroundColor = cell.colorDictionary[self.user["color"] as! String]
            
            return cell
        }
        else if indexPath.section == 1{
            if indexPath.row < self.aboutArray.count{
                var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Value1")
                cell.textLabel!.text = self.aboutArray[indexPath.row][0]
                cell.detailTextLabel!.text = self.aboutArray[indexPath.row][1]
                return cell
            }
            else if indexPath.row < self.aboutArray.count + self.userActivities.count{
                var currentActivity = self.processedActivities[indexPath.row - self.aboutArray.count] as! [String:String!]
                
                var currentActivityImageString:String = currentActivity["currentActivityImageString"]!
                if (currentActivityImageString != ""){
                    var cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as! ActivityTableViewCell
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
                    var cell:StatusActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("StatusActivityTableViewCell") as! StatusActivityTableViewCell
                    
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
                var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
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
            var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            var segmentedControlView = UIView()
            segmentedControlView.backgroundColor = UIColor.whiteColor()
            
            var segmentedControl = UISegmentedControl(items: ["About","Activities", "More"])
            segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
            segmentedControl.tintColor = UIColor.blackColor()
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControlView.addSubview(segmentedControl)
            
            var segmentedControlViewSeparator = UIView(frame: CGRectZero)
            segmentedControlViewSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
            segmentedControlViewSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            segmentedControlView.addSubview(segmentedControlViewSeparator)
            
            var metricsDictionary = ["sideMargin":7.5]
            var viewsDictionary = ["segmentedControl":segmentedControl, "segmentedControlViewSeparator":segmentedControlViewSeparator]
            
            var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl(28)]-8-[segmentedControlViewSeparator(0.5)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[segmentedControl]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            var separatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentedControlViewSeparator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

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
            println("About")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        case 1:
            println("Activities")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.aboutArray.count, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        default:
            println("More")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.tableView.numberOfRowsInSection(1) - 1, inSection: 1), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }

    func loadActivities(context:String){
        var followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser())
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Found FollowerFollowing object for current user
                var activityQuery = PFQuery(className: "Activity")
                // Include current user so user's own activities also show up
                activityQuery.whereKey("ownerUser", equalTo: self.user)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                activityQuery.limit = 10
                if context == "old"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", lessThan: (self.userActivities.last as PFObject!).createdAt)
                    }
                }
                else if context == "new"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThan: (self.userActivities.first as PFObject!).createdAt)
                    }
                }
                else if context == "update"{
                    if !self.userActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThanOrEqualTo: (self.userActivities.last as PFObject!).createdAt)
                        activityQuery.whereKey("createdAt", lessThanOrEqualTo: (self.userActivities.first as PFObject!).createdAt)
                        activityQuery.limit = 1000
                    }
                }
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        
                        // Found activities
                        var userActivitiesFound = objects as! [PFObject]
                        var currentLikedAcitivitiesFoundIdStrings:[String] = []
                        if context == "old"{
                            if objects.count == 10{
//                                self.moreActivities = true
                            }
                            else{
//                                self.moreActivities = false
                            }
                        }
                        // If activities count is 0, show no activity view, else display activities
                        if context == "old"{
                            self.userActivities.extend(userActivitiesFound)
                        }
                        else if context == "new"{
                            self.userActivities.splice(userActivitiesFound, atIndex: 0)
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
                            println("no more activities")
//                            self.refreshControl?.endRefreshing()
                        }
                        // Query activities liked by current user
                        var userActivitiesFoundCommentCount = Array(count: userActivitiesFound.count, repeatedValue: 0)
                        var userActivitiesFoundLikeCount = Array(count: userActivitiesFound.count, repeatedValue: 0)
                        var likeCountFound = 0
                        var commentCountFound = 0
                        var relation = PFUser.currentUser().relationForKey("likedActivity")
                        relation.query().findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil {
                                for object in objects{
                                    currentLikedAcitivitiesFoundIdStrings.append(object.objectId)
                                }
                            }
                            else {
                                // Log details of the failure
                                NSLog("Error: %@ %@", error, error.userInfo!)
//                                self.refreshControl?.endRefreshing()
                            }
                        }
                        
                        // Query like count of activities
                        for activity in userActivitiesFound{
                            var queryLikes = PFQuery(className: "_User")
                            queryLikes.whereKey("likedActivity", equalTo: activity)
                            queryLikes.findObjectsInBackgroundWithBlock{
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                if error == nil {
                                    var count = objects.count
                                    userActivitiesFoundLikeCount[find(userActivitiesFound, activity)!] = count
                                    ++likeCountFound
                                    
                                    // Query comment count of activities
                                    var queryComments = PFQuery(className: "Comment")
                                    queryComments.whereKey("activity", equalTo: activity)
                                    queryComments.findObjectsInBackgroundWithBlock{
                                        (objects: [AnyObject]!, error: NSError!) -> Void in
                                        if error == nil {
                                            var count = objects.count
                                            userActivitiesFoundCommentCount[find(userActivitiesFound, activity)!] = count
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
                                            NSLog("Error: %@ %@", error, error.userInfo!)
//                                            self.refreshControl?.endRefreshing()
                                            
                                        }
                                    }
                                    
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error, error.userInfo!)
//                                    self.refreshControl?.endRefreshing()
                                }
                            }
                            
                        }
                        
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
//                        self.refreshControl?.endRefreshing()
                        
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
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
            var currentActivityCreatedTime = activity.createdAt
            var currentActivityChallenge = activity["challenge"] as! PFObject
            var currentActivityUserChallengeData = activity["userChallengeData"] as! PFObject
            var currentActivityUser = activity["ownerUser"] as! PFUser
            var currentAvatarString = currentActivityUser["avatar"] as! String
            var currentAvatarColor = currentActivityUser["color"] as! String
            var currentAction = currentActivityChallenge["action"] as! String
            var currentChallengeTrackNumber = (currentActivityUserChallengeData["challengeTrackNumber"] as! String).toInt()!
            currentChallengeTrackNumber = currentChallengeTrackNumber - 1
            var activityCreatedTimeLabel = currentActivityCreatedTime.shortTimeAgoSinceNow()
            
            
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
            
            if contains(currentLikedAcitivitiesFoundIdStrings, activity.objectId){
                currentActivityDictionary.updateValue("yes", forKey: "liked")
            }
            if context == "old"{
                self.processedActivities.addObject(currentActivityDictionary)
                self.currentActivitiesLikeCount.extend(currentActivitiesFoundLikeCount)
                self.currentActivitiesCommentCount.extend(currentActivitiesFoundCommentCount)
            }
            else if context == "new"{
                self.processedActivities.insertObject(currentActivityDictionary, atIndex: 0)
                self.currentActivitiesLikeCount.splice(currentActivitiesFoundLikeCount, atIndex: 0)
                self.currentActivitiesCommentCount.splice(currentActivitiesFoundCommentCount, atIndex: 0)
            }
            else if context == "update"{
                self.processedActivities.addObject(currentActivityDictionary)
                self.currentActivitiesLikeCount.extend(currentActivitiesFoundLikeCount)
                self.currentActivitiesCommentCount.extend(currentActivitiesFoundCommentCount)
            }
            ++activityCount
        }
    }
}
