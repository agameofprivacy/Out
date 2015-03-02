//
//  ActivityTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for activity tab view
class ActivityTabViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
 
    
    var currentActivities:[PFObject] = []
    var currentLikedAcitivitiesIdStrings:[String] = []
    var currentActivity:PFObject!
    var currentActivitiesLikeCount:[Int] = []
    var currentActivitiesCommentCount:[Int] = []
    var likeCount:Int = 0
    var commentCount:Int = 0
    var noActivityView:UIView!
    var processedActivities:NSMutableArray = []
    
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
        self.navigationItem.title = "Activities"
        var composeButton = UIBarButtonItem(image: UIImage(named: "compose-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "composeButtonTapped:")
        composeButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = composeButton
        
        var notificationButton = UIBarButtonItem(image: UIImage(named: "notification-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "notificationButtonTapped:")
        notificationButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = notificationButton
        
        // UITableView init
        self.tableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.tableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 0, 0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.delegate = self
        self.tableView.dataSource = self

//        self.tableView.estimatedRowHeight = 358
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // noActivityView init and layout
        self.noActivityView = UIView(frame: self.tableView.frame)
        self.noActivityView.center = self.tableView.center
        
        var noActivityViewTitle = UILabel(frame: CGRectMake(0, 1.43 * self.noActivityView.frame.height / 5, self.noActivityView.frame.width, 32))
        noActivityViewTitle.text = "No Activity"
        noActivityViewTitle.textAlignment = NSTextAlignment.Center
        noActivityViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noActivityViewTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noActivityView.addSubview(noActivityViewTitle)
        
        var noActivityViewSubtitle = UILabel(frame: CGRectMake(0, 1.43 * self.noActivityView.frame.height / 5 + 31, self.noActivityView.frame.width, 60))
        noActivityViewSubtitle.text = "take on some challenges or follow others\nin People to see their activities"
        noActivityViewSubtitle.textAlignment = NSTextAlignment.Center
        noActivityViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noActivityViewSubtitle.numberOfLines = 2
        noActivityViewSubtitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.noActivityView.addSubview(noActivityViewSubtitle)
        
        self.noActivityView.hidden = true
        self.view.addSubview(self.noActivityView)

        self.refreshControl?.beginRefreshing()
        loadActivitiesOnViewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = nil
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = nil
    }

    
    // Reload activities when refresh control activated
    @IBAction func refreshActivityFeed(sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.loadActivities()
    }
    
    // Prepare for show activity detail segue, pass tapped activity to destination vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showActivityDetail"{
            let newVC: ActivityDetailViewController = segue.destinationViewController as! ActivityDetailViewController
            newVC.currentActivity = self.currentActivity
            newVC.parentVC = self
        }
        else if segue.identifier == "showActivityContentPreview"{
            let newVC: ActivityContentPreviewViewController = segue.destinationViewController as! ActivityContentPreviewViewController
            
            var currentChallenge = currentActivity["challenge"] as! PFObject
            var currentUserChallengeData = currentActivity["userChallengeData"] as! PFObject
            var currentUser = currentActivity["ownerUser"] as! PFUser
            var currentChallengeTrackNumber = (currentUserChallengeData["challengeTrackNumber"] as! String).toInt()!
            currentChallengeTrackNumber = currentChallengeTrackNumber - 1
            
            newVC.activity = self.currentActivity
            newVC.challenge = currentChallenge
            newVC.userChallengeData = currentUserChallengeData
            newVC.user = currentUser
            newVC.challengeTrackNumber = currentChallengeTrackNumber
            
            newVC.parentVC = self
        }

    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Return the count of rows from the count of current activities
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return self.currentActivities.count
        }
        else{
            return 1
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Table view data source method for activities
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        var cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as! ActivityTableViewCell

        var activityContentPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: "showActivityContentPreviewTapped:")
        cell.contentCanvas.addGestureRecognizer(activityContentPreviewTapRecognizer)
        
        var likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
        cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
        
        var commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
        cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)

        var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
        
        var currentActivityImageString:String = currentActivity["currentActivityImageString"]!
        if (currentActivityImageString != ""){
            cell.heroImageView.image = UIImage(named: currentActivityImageString)
        }
        else{
            cell.heroImageView.image = nil
        }
        
        cell.reverseTimeLabel.text = currentActivity["timeLabel"]!
        cell.avatarImageView.image = UIImage(named: currentActivity["avatarImageViewImageString"]!)
        
        cell.avatarImageView.backgroundColor = self.colorDictionary[currentActivity["avatarImageViewBackgroundColorString"]!]
        cell.aliasLabel.text = currentActivity["aliasLabel"]!
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

        return cell
        }
        else
        {
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "loadMore")
            cell.textLabel?.text = "Load More..."
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 380
    }

//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
//        var actionLabelText:String = currentActivity["actionLabelText"]!
//        var aliasLabelText:String = currentActivity["aliasLabel"]!
//        var narrativeTitleLabelText:String = currentActivity["currentNarrativeTitleString"]!
//        var narrativeContentLabelText:String = currentActivity["currentNarrativeContentString"]!
//        var commentsCountLabelText:String = currentActivity["commentCountLabel"]!
//        var writeACommentLabelText:String = "write a comment"
//        
//        
//        var result:CGFloat = 0.0
//        var actionMaxSize:CGSize = CGSize(width: CGFloat(274), height: CGFloat(MAXFLOAT))
//        var narrativeContentMaxSize:CGSize = CGSize(width: CGFloat(320), height: CGFloat(MAXFLOAT))
//        var narrativeTitleMaxSize:CGSize = CGSize(width: CGFloat(320), height: CGFloat(MAXFLOAT))
//        var aliasMaxSize:CGSize = CGSize(width: CGFloat(240), height: CGFloat(MAXFLOAT))
//        var commentCountMaxSize:CGSize = CGSize(width: CGFloat(290), height: CGFloat(MAXFLOAT))
//        var writeACommentMaxSize:CGSize = CGSize(width: CGFloat(290), height: CGFloat(MAXFLOAT))
//
//        
//        var actionLabelRect:CGRect = actionLabelText.boundingRectWithSize(actionMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.titleFont!.fontWithSize(16.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//
//        
//        var narrativeContentLabelRect:CGRect = narrativeContentLabelText.boundingRectWithSize(narrativeContentMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.valueFont!.fontWithSize(14.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//
//        var narrativeTitleLabelRect:CGRect = narrativeTitleLabelText.boundingRectWithSize(narrativeTitleMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.titleFont!.fontWithSize(15.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//        
//        var aliasLabelRect:CGRect = aliasLabelText.boundingRectWithSize(aliasMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.titleFont!.fontWithSize(16.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//
//        var commentCountLabelRect:CGRect = commentsCountLabelText.boundingRectWithSize(commentCountMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.titleFont!.fontWithSize(16.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//    
//        var writeACommentLabelRect:CGRect = writeACommentLabelText.boundingRectWithSize(writeACommentMaxSize, options: .UsesLineFragmentOrigin | .UsesFontLeading, attributes:NSDictionary(
//            object: self.valueFont!.fontWithSize(16.0),
//            forKey: NSFontAttributeName) as [NSObject : AnyObject], context:nil)
//        
//        
//        var actionLabelHeight = actionLabelRect.size.height
//        var narrativeContentLabelHeight = narrativeContentLabelRect.size.height
//        var narrativeTitleLabelHeight = narrativeTitleLabelRect.size.height
//        var aliasLabelHeight = aliasLabelRect.size.height
//        var commentCountLabelHeight = commentCountLabelRect.size.height
//        var writeACommentLabelHeight = writeACommentLabelRect.size.height
//        var currentActivityImageString:String = currentActivity["currentActivityImageString"]!
//        var imageHeight:CGFloat = 110 + 9.5 + 2 + 11.9
//        if (currentActivityImageString == ""){
//            imageHeight = 0
//        }
//        
////        println("alias label: \(aliasLabelHeight)")
////        println("action content: \(actionLabelHeight)")
////        println("narrative title: \(narrativeTitleLabelHeight)")
////        println("narrative content: \(narrativeContentLabelHeight)")
////        println("comment count: \(commentCountLabelHeight)")
////        println("write comment: \(writeACommentLabelHeight)")
//        result = 22 + aliasLabelHeight + 4 + actionLabelHeight + imageHeight + 8 + narrativeTitleLabelHeight + 4 + narrativeContentLabelHeight + 16 + 1 + 8 + 46 + 10
//        return CGFloat(result)
//    }
    
    func loadActivities(){
        var followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser())
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Found FollowerFollowing object for current user
                var currentUserFollowerFollowingObject = objects[0] as! PFObject
                var currentUserFollowingUsers = currentUserFollowerFollowingObject["followingUsers"] as! [PFUser]
                var activityQuery = PFQuery(className: "Activity")
                // Include current user so user's own activities also show up
                currentUserFollowingUsers.append(PFUser.currentUser())

                activityQuery.whereKey("ownerUser", containedIn: currentUserFollowingUsers)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                 activityQuery.limit = 15
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        // Found activities
                        self.currentActivities = objects as! [PFObject]
                        // If activities count is 0, show no activity view, else display activities
                        if self.currentActivities.count == 0{
                            self.noActivityView.hidden = false
                            self.refreshControl?.endRefreshing()
                        }
                        else{
                            self.noActivityView.hidden = true
                        }

                        // Query activities liked by current user
                        self.currentActivitiesCommentCount = Array(count: self.currentActivities.count, repeatedValue: 0)
                        self.currentActivitiesLikeCount = Array(count: self.currentActivities.count, repeatedValue: 0)
                        self.likeCount = 0
                        self.commentCount = 0
                        var relation = PFUser.currentUser().relationForKey("likedActivity")
                        relation.query().findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil {
                                for object in objects{
                                    self.currentLikedAcitivitiesIdStrings.append(object.objectId)
                                }
                            }
                            else {
                                // Log details of the failure
                                NSLog("Error: %@ %@", error, error.userInfo!)
                                self.refreshControl?.endRefreshing()
                            }
                        }
                        
                        // Query like count of activities
                        for activity in self.currentActivities{
                            var queryLikes = PFQuery(className: "_User")
                            queryLikes.whereKey("likedActivity", equalTo: activity)
                            queryLikes.findObjectsInBackgroundWithBlock{
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                if error == nil {
                                    var count = objects.count
                                        self.currentActivitiesLikeCount[find(self.currentActivities, activity)!] = count
                                        ++self.likeCount
                                    
                                        // Query comment count of activities
                                        var queryComments = PFQuery(className: "Comment")
                                        queryComments.whereKey("activity", equalTo: activity)
                                        queryComments.findObjectsInBackgroundWithBlock{
                                            (objects: [AnyObject]!, error: NSError!) -> Void in
                                            if error == nil {
                                                var count = objects.count
                                                self.currentActivitiesCommentCount[find(self.currentActivities, activity)!] = count
                                                ++self.commentCount
                                                if self.likeCount == self.currentActivities.count && self.commentCount == self.currentActivities.count{
                                                    self.prepareDataForTableView()
                                                    (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = "3"
                                                    self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                                                    self.refreshControl?.endRefreshing()
                                                }
                                            }
                                            else {
                                                // Log details of the failure
                                                NSLog("Error: %@ %@", error, error.userInfo!)
                                                self.refreshControl?.endRefreshing()
                                                
                                            }
                                        }

                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error, error.userInfo!)
                                    self.refreshControl?.endRefreshing()
                                }
                            }
                            
                        }

                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
                        self.refreshControl?.endRefreshing()

                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
                self.refreshControl?.endRefreshing()

            }
        }
        
    }

    func loadActivitiesOnViewDidLoad(){
        var followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser())
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Found FollowerFollowing object for current user
                var currentUserFollowerFollowingObject = objects[0] as! PFObject
                var currentUserFollowingUsers = currentUserFollowerFollowingObject["followingUsers"] as! [PFUser]
                var activityQuery = PFQuery(className: "Activity")
                // Include current user so user's own activities also show up
                currentUserFollowingUsers.append(PFUser.currentUser())
                
                activityQuery.whereKey("ownerUser", containedIn: currentUserFollowingUsers)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                 activityQuery.limit = 15
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        // Found activities
                        self.currentActivities = objects as! [PFObject]
                        // If activities count is 0, show no activity view, else display activities
                        if self.currentActivities.count == 0{
                            self.noActivityView.hidden = false
                            self.refreshControl?.endRefreshing()
                        }
                        else{
                            self.noActivityView.hidden = true
                        }
                        
                        // Query activities liked by current user
                        self.currentActivitiesCommentCount = Array(count: self.currentActivities.count, repeatedValue: 0)
                        self.currentActivitiesLikeCount = Array(count: self.currentActivities.count, repeatedValue: 0)
                        self.likeCount = 0
                        self.commentCount = 0
                        var relation = PFUser.currentUser().relationForKey("likedActivity")
                        relation.query().findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil {
                                for object in objects{
                                    self.currentLikedAcitivitiesIdStrings.append(object.objectId)
                                }
                            }
                            else {
                                // Log details of the failure
                                NSLog("Error: %@ %@", error, error.userInfo!)
                                self.refreshControl?.endRefreshing()
                            }
                        }
                        
                        // Query like count of activities
                        for activity in self.currentActivities{
                            var queryLikes = PFQuery(className: "_User")
                            queryLikes.whereKey("likedActivity", equalTo: activity)
                            queryLikes.findObjectsInBackgroundWithBlock{
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                if error == nil {
                                    var count = objects.count
                                    self.currentActivitiesLikeCount[find(self.currentActivities, activity)!] = count
                                    ++self.likeCount
                                    
                                    // Query comment count of activities
                                    var queryComments = PFQuery(className: "Comment")
                                    queryComments.whereKey("activity", equalTo: activity)
                                    queryComments.findObjectsInBackgroundWithBlock{
                                        (objects: [AnyObject]!, error: NSError!) -> Void in
                                        if error == nil {
                                            var count = objects.count
                                            self.currentActivitiesCommentCount[find(self.currentActivities, activity)!] = count
                                            ++self.commentCount
                                            if self.likeCount == self.currentActivities.count && self.commentCount == self.currentActivities.count{
                                                self.prepareDataForTableView()
                                                (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = "3"
                                                self.tableView.reloadData()
                                                self.refreshControl?.endRefreshing()
                                            }
                                        }
                                        else {
                                            // Log details of the failure
                                            NSLog("Error: %@ %@", error, error.userInfo!)
                                            self.refreshControl?.endRefreshing()
                                            
                                        }
                                    }
                                    
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error, error.userInfo!)
                                    self.refreshControl?.endRefreshing()
                                }
                            }
                            
                        }
                        
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
                        self.refreshControl?.endRefreshing()
                        
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
                self.refreshControl?.endRefreshing()
                
            }
        }
        
    }

    
    func prepareDataForTableView(){
        var activityCount = 0
        for activity in self.currentActivities{
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



            if self.currentActivitiesLikeCount.count == 0{
            }
            else{
                if self.currentActivitiesLikeCount[activityCount] > 1{
                    currentActivityDictionary.updateValue("\(self.currentActivitiesLikeCount[activityCount]) likes", forKey: "likeCountLabel")
                }
                else if self.currentActivitiesLikeCount[activityCount] == 1{
                    currentActivityDictionary.updateValue("\(self.currentActivitiesLikeCount[activityCount]) like", forKey: "likeCountLabel")
                }
            }
            if self.currentActivitiesCommentCount.count == 0{
            }
            else{
                if self.currentActivitiesCommentCount[activityCount] > 1{
                    currentActivityDictionary.updateValue("\(self.currentActivitiesCommentCount[activityCount]) comments", forKey: "commentCountLabel")
                }
                else if self.currentActivitiesCommentCount[activityCount] == 1{
                    currentActivityDictionary.updateValue("\(self.currentActivitiesCommentCount[activityCount]) comment", forKey: "commentCountLabel")
                }
            }

            if contains(self.currentLikedAcitivitiesIdStrings, activity.objectId){
                currentActivityDictionary.updateValue("yes", forKey: "liked")
            }

            self.processedActivities.addObject(currentActivityDictionary)
            ++activityCount
        }
    }
    
    // Register current user's liking of an activity on Parse if Like button tapped
    func likeButtonTapped(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        var likedActivity = self.currentActivities[currentIndexPath.row]
        
        var user = PFUser.currentUser()
        var relation = user.relationForKey("likedActivity")
        var currentLikeButton = sender.view as! UIImageView
        var currentLikeCount = 0
        var currentLikeCountLabel = sender.view?.superview?.subviews[0] as! UILabel
        var currentLikeCountText:String = currentLikeCountLabel.text!
        
        if currentLikeCountText == ""{
            currentLikeCount = 0
        }
        else{
            currentLikeCount = currentLikeCountText.componentsSeparatedByString(" ")[0].toInt()!
        }
        if currentLikeButton.image == UIImage(named: "likeButtonFilled-icon"){
            currentLikeButton.image = UIImage(named: "likeButton-icon")
            --currentLikeCount
            var currentLikeCountLabelString:String
            if currentLikeCount > 1{
                currentLikeCountLabelString = "\(currentLikeCount) likes"
            }
            else if currentLikeCount == 1{
                currentLikeCountLabelString = "\(currentLikeCount) like"
            }
            else{
                currentLikeCountLabelString = ""
            }
            --self.currentActivitiesLikeCount[currentIndexPath.row]
            var currentActivityDictionary = self.processedActivities[currentIndexPath.row] as! [String:String]
            currentActivityDictionary.updateValue("no", forKey: "liked")
            currentActivityDictionary.updateValue(currentLikeCountLabelString, forKey: "likeCountLabel")
            self.processedActivities.replaceObjectAtIndex(currentIndexPath.row, withObject: currentActivityDictionary)
            self.tableView.reloadData()
            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId)
            var likedActivityQuery = relation.query()
            relation.removeObject(likedActivity)
            self.currentLikedAcitivitiesIdStrings = self.currentLikedAcitivitiesIdStrings.filter{$0 != likedActivity.objectId}
            user.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                if error == nil{
//                    self.loadActivities()
//                    self.tableView.reloadData()
                }
            }
        }
        else{
            currentLikeButton.image = UIImage(named: "likeButtonFilled-icon")
            ++currentLikeCount
            var currentLikeCountLabelString:String
            if currentLikeCount > 1{
                currentLikeCountLabelString = "\(currentLikeCount) likes"
            }
            else if currentLikeCount == 1{
                currentLikeCountLabelString = "\(currentLikeCount) like"
            }
            else{
                currentLikeCountLabelString = ""
            }
            ++self.currentActivitiesLikeCount[currentIndexPath.row]
            var currentActivityDictionary = self.processedActivities[currentIndexPath.row] as! [String:String]
            currentActivityDictionary.updateValue("yes", forKey: "liked")
            currentActivityDictionary.updateValue(currentLikeCountLabelString, forKey: "likeCountLabel")
            self.processedActivities.replaceObjectAtIndex(currentIndexPath.row, withObject: currentActivityDictionary)
            self.tableView.reloadData()
            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId)
            var likedActivityQuery = relation.query()
            relation.addObject(likedActivity)
            user.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                if error == nil{
//                    self.loadActivities()
//                    self.tableView.reloadData()
                    
                    var newLikeNotification = PFObject(className: "Notification")
                    newLikeNotification["sender"] = PFUser.currentUser()
                    newLikeNotification["receiver"] = likedActivity["ownerUser"] as! PFUser
                    newLikeNotification["activity"] = likedActivity
                    newLikeNotification["type"] = "like"
                    newLikeNotification["read"] = false
                    newLikeNotification.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                        if error == nil{
                            // Send iOS Notification
                        }
                    }

                }
            }
        }

    }
    
    // Perform segue to show activity detail if comment button tapped
    func commentButtonTapped(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        
        var toCommentActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = toCommentActivity

        self.performSegueWithIdentifier("showActivityDetail", sender: self)
    }
    
    func showActivityContentPreviewTapped(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        
        var toPreviewActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = toPreviewActivity
        
        self.performSegueWithIdentifier("showActivityContentPreview", sender: self)
    }
    
    // Present notification view if Notification button tapped
    func notificationButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showNotifications", sender: self)
    }
    
    // Present compose view if Compose button tapped
    func composeButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showCompose", sender: self)
    }
    
    // Launch challenge preview view with URL from cell
//    func launchChallengePreviewView(sender:UITapGestureRecognizer!){
//        var cell:LaunchWebViewTableViewCell = sender.view as LaunchWebViewTableViewCell
//        var collectionView = self.superview as UICollectionView
//        var baseClass = collectionView.delegate as ChallengesTabViewController
//        var urlFromCell = cell.fieldValue.text
//        var urlObject = cell.launchURL
//        baseClass.presentWebView(urlObject!)
//    }

}
