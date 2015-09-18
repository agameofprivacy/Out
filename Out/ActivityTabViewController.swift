//
//  ActivityTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem
import Parse
// Controller for activity tab view
class ActivityTabViewController: UITableViewController {

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
    var notifications:[PFObject] = []
    var moreActivities:Bool = false
    var selectedSegment = "About"
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
        // self.navigationItem.title = "Activities"
        let composeButton = UIBarButtonItem(image: UIImage(named: "compose-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "composeButtonTapped:")
        composeButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = composeButton
        
        let notificationButton = UIBarButtonItem(image: UIImage(named: "notification-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "notificationButtonTapped:")
        notificationButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = notificationButton
        
        let customNotificationButton = UIButton(frame: CGRectMake(0, 0, 25, 25))
        customNotificationButton.addTarget(self, action: "notificationButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        customNotificationButton.setImage(UIImage(named: "notification-icon"), forState: UIControlState.Normal)
        customNotificationButton.tintColor = UIColor.blackColor()
        
        let badgeableNotificationBarButton = BBBadgeBarButtonItem(customUIButton: customNotificationButton)
        badgeableNotificationBarButton.badgeOriginX = 10
        badgeableNotificationBarButton.badgeValue = "\(self.notifications.count)"
        badgeableNotificationBarButton.shouldAnimateBadge = true
        badgeableNotificationBarButton.shouldHideBadgeAtZero = true
        self.navigationItem.leftBarButtonItem = badgeableNotificationBarButton
        self.navigationItem.leftBarButtonItem?.enabled = false
        
        // UITableView init
        self.tableView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.tableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.tableView.registerClass(StatusActivityTableViewCell.self, forCellReuseIdentifier: "StatusActivityTableViewCell")
        self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 0, 0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // noActivityView init and layout
        self.noActivityView = UIView(frame: self.tableView.frame)
        self.noActivityView.center = self.tableView.center
        
        let noActivityViewTitle = UILabel(frame: CGRectMake(0, 1.43 * self.noActivityView.frame.height / 5, self.noActivityView.frame.width, 32))
        noActivityViewTitle.text = "No Activities"
        noActivityViewTitle.textAlignment = NSTextAlignment.Center
        noActivityViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noActivityViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noActivityView.addSubview(noActivityViewTitle)
        
        let noActivityViewSubtitle = UILabel(frame: CGRectMake(0, 1.43 * self.noActivityView.frame.height / 5 + 31, self.noActivityView.frame.width, 60))
        noActivityViewSubtitle.text = "Do some activities or follow\nothers to see their activities"
        noActivityViewSubtitle.textAlignment = NSTextAlignment.Center
        noActivityViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noActivityViewSubtitle.numberOfLines = 2
        noActivityViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noActivityView.addSubview(noActivityViewSubtitle)
        
        self.noActivityView.hidden = true
        self.view.addSubview(self.noActivityView)
        
        self.refreshControl?.beginRefreshing()
        loadActivities("old")
    }
    
    override func viewDidAppear(animated: Bool) {
        (self.tabBarController!.tabBar.items![0] as UITabBarItem).badgeValue = nil
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        (self.tabBarController!.tabBar.items![0] as UITabBarItem).badgeValue = nil
    }

    
    // Reload activities when refresh control activated
    @IBAction func refreshActivityFeed(sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.loadActivities("new")
        self.loadNotifications()
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
            
            let currentChallenge = currentActivity["challenge"] as! PFObject
            let currentUserChallengeData = currentActivity["userChallengeData"] as! PFObject
            let currentUser = currentActivity["ownerUser"] as! PFUser
            var currentChallengeTrackNumber = Int((currentUserChallengeData["challengeTrackNumber"] as! String))!
            currentChallengeTrackNumber = currentChallengeTrackNumber - 1
            
            newVC.activity = self.currentActivity
            newVC.challenge = currentChallenge
            newVC.userChallengeData = currentUserChallengeData
            newVC.user = currentUser
            newVC.challengeTrackNumber = currentChallengeTrackNumber
            
            newVC.parentVC = self
        }
        else if segue.identifier == "showNotifications"{
            let newVC:NotificationsViewController = segue.destinationViewController.childViewControllers[0] as! NotificationsViewController
            newVC.unreadNotifications = self.notifications
        }
        else if segue.identifier == "showActivityExpanded"{
            let newVC:ActivityExpandedTableViewController = segue.destinationViewController as! ActivityExpandedTableViewController
            
            let currentChallenge = currentActivity["challenge"] as! PFObject
            let currentUserChallengeData = currentActivity["userChallengeData"] as! PFObject
            let currentUser = currentActivity["ownerUser"] as! PFUser
            let currentChallengeTrackNumber = Int((currentUserChallengeData["challengeTrackNumber"] as! String))!
            
            newVC.parentVC = self
            newVC.activity = self.currentActivity
            newVC.challenge = currentChallenge
            newVC.userChallengeData = currentUserChallengeData
            newVC.user = currentUser
            newVC.challengeTrackNumber = currentChallengeTrackNumber
            newVC.selectedSegment = self.selectedSegment
        }
        else if segue.identifier == "showPersonDetail"{
            let newVC:PersonDetailViewController = segue.destinationViewController as! PersonDetailViewController
            
            newVC.user = currentActivity["ownerUser"] as! PFUser
        }

    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.loadNotifications()
//        self.loadActivities("update")
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
        if (section == 0){
            print("number of rows called \(self.processedActivities.count)")
            return self.processedActivities.count
        }
        else{
            if self.moreActivities{
                return 1
            }else{
                return 0
            }
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Table view data source method for activities
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
            
            let currentActivityImageString:String = currentActivity["currentActivityImageString"]!
            if (currentActivityImageString != ""){
                let cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as! ActivityTableViewCell
                cell.heroImageView.image = UIImage(named: currentActivityImageString)
                let activityContentPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: "showActivityContentPreviewTapped:")
                cell.contentCanvas.addGestureRecognizer(activityContentPreviewTapRecognizer)
                
                
                cell.reverseTimeLabel.text = currentActivity["timeLabel"]!
                cell.avatarImageView.image = UIImage(named: currentActivity["avatarImageViewImageString"]!)
                
                cell.avatarImageView.backgroundColor = self.colorDictionary[currentActivity["avatarImageViewBackgroundColorString"]!]
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
                let aliastapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.aliasLabel.text = currentActivity["aliasLabel"]!
                cell.aliasLabel.addGestureRecognizer(aliastapGestureRecognizer)
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
                let likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
                cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
                
                let commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
                cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)
                return cell
            }
            else{
                let cell:StatusActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("StatusActivityTableViewCell") as! StatusActivityTableViewCell

                cell.reverseTimeLabel.text = currentActivity["timeLabel"]!
                cell.avatarImageView.image = UIImage(named: currentActivity["avatarImageViewImageString"]!)
                
                cell.avatarImageView.backgroundColor = self.colorDictionary[currentActivity["avatarImageViewBackgroundColorString"]!]
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
                let aliastapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.aliasLabel.text = currentActivity["aliasLabel"]!
                cell.aliasLabel.addGestureRecognizer(aliastapGestureRecognizer)
                cell.actionLabel.text = currentActivity["actionLabelText"]!
                
                cell.likeCountLabel.text = currentActivity["likeCountLabel"]!
                cell.commentsCountLabel.text = currentActivity["commentCountLabel"]!
                
                if (currentActivity["liked"] == "yes"){
                    cell.likeButton.image = UIImage(named: "likeButtonFilled-icon")
                }
                else{
                    cell.likeButton.image = UIImage(named: "likeButton-icon")
                }
                let likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
                cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
                
                let commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
                cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)
                return cell
            }
        
        }
        else
        {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "loadMore")
            cell.textLabel?.text = "loading..."
            cell.textLabel?.textColor = UIColor(white: 0.5, alpha: 1)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.section == 0{
//            var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
//            
//            var currentActivityImageString:String = currentActivity["currentActivityImageString"]!
//            if (currentActivityImageString != ""){
//                return 420
//            }
//            else{
//                return 165
//            }
//        }
//        else{
//            return 64
//        }
//    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath == NSIndexPath(forRow: 0, inSection: 1){
//            loadMoreActivities()
//        }
//    }
    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.section == 0{
//            var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
//
//            var currentActivityImageString:String = currentActivity["currentActivityImageString"]!
//            if (currentActivityImageString == ""){
//                return 155
//            }
//            else{
//                return 500
//            }
//        }
//        else{
//            return 64
//        }
//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
            
            let currentActivityImageString:String = currentActivity["currentActivityImageString"]!
            if (currentActivityImageString != ""){
                var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
                let actionLabelText:String = currentActivity["actionLabelText"]!
                let aliasLabelText:String = currentActivity["aliasLabel"]!
                let narrativeTitleLabelText:String = currentActivity["currentNarrativeTitleString"]!
                let narrativeContentLabelText:String = currentActivity["currentNarrativeContentString"]!
                let commentsCountLabelText:String = currentActivity["commentCountLabel"]!
                let writeACommentLabelText:String = "write a comment"
        
        
                var result:CGFloat = 0.0
                let actionMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 101), height: CGFloat(MAXFLOAT))
                let narrativeContentMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 67), height: CGFloat(MAXFLOAT))
                let narrativeTitleMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 55), height: CGFloat(MAXFLOAT))
                let aliasMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 135), height: CGFloat(MAXFLOAT))
                let commentCountMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 85), height: CGFloat(MAXFLOAT))
                let writeACommentMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 85), height: CGFloat(MAXFLOAT))
        
        
                let actionLabelRect:CGRect = actionLabelText.boundingRectWithSize(actionMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
        
                let narrativeContentLabelRect:CGRect = narrativeContentLabelText.boundingRectWithSize(narrativeContentMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.valueFont!.fontWithSize(13.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
                let narrativeTitleLabelRect:CGRect = narrativeTitleLabelText.boundingRectWithSize(narrativeTitleMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(14.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
                let aliasLabelRect:CGRect = aliasLabelText.boundingRectWithSize(aliasMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
                let commentCountLabelRect:CGRect = commentsCountLabelText.boundingRectWithSize(commentCountMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
                let writeACommentLabelRect:CGRect = writeACommentLabelText.boundingRectWithSize(writeACommentMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.valueFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
        
        
                let actionLabelHeight = actionLabelRect.size.height
                let narrativeContentLabelHeight = narrativeContentLabelRect.size.height
                let narrativeTitleLabelHeight = narrativeTitleLabelRect.size.height
                let aliasLabelHeight = aliasLabelRect.size.height
                let commentCountLabelHeight = commentCountLabelRect.size.height
                let writeACommentLabelHeight = writeACommentLabelRect.size.height
                let currentActivityImageString:String = currentActivity["currentActivityImageString"]!
                var imageHeight:CGFloat = 110 + 12 + 19
                if (currentActivityImageString == ""){
                    imageHeight = 0
                }
                
        //        print("alias label: \(aliasLabelHeight)")
        //        print("action content: \(actionLabelHeight)")
        //        print("narrative title: \(narrativeTitleLabelHeight)")
        //        print("narrative content: \(narrativeContentLabelHeight)")
        //        print("comment count: \(commentCountLabelHeight)")
        //        print("write comment: \(writeACommentLabelHeight)")
                result = 22 + aliasLabelHeight + 4 + actionLabelHeight + 12 + imageHeight + narrativeTitleLabelHeight + 4 + narrativeContentLabelHeight + 12 + 16 + 1 + 8 + commentCountLabelHeight + writeACommentLabelHeight + 10
//                    print("activity card height: \(result)")
                    return CGFloat(result)
            }
            else{
                var currentActivity = self.processedActivities[indexPath.row] as! [String:String!]
                let actionLabelText:String = currentActivity["actionLabelText"]!
                let aliasLabelText:String = currentActivity["aliasLabel"]!
                let commentsCountLabelText:String = currentActivity["commentCountLabel"]!
                let writeACommentLabelText:String = "write a comment"
                
                
                var result:CGFloat = 0.0
                let actionMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 101), height: CGFloat(MAXFLOAT))
                let aliasMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 135), height: CGFloat(MAXFLOAT))
                let commentCountMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 85), height: CGFloat(MAXFLOAT))
                let writeACommentMaxSize:CGSize = CGSize(width: CGFloat(UIScreen.mainScreen().bounds.width - 85), height: CGFloat(MAXFLOAT))
                
                
                let actionLabelRect:CGRect = actionLabelText.boundingRectWithSize(actionMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
                
                let aliasLabelRect:CGRect = aliasLabelText.boundingRectWithSize(aliasMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
                
                let commentCountLabelRect:CGRect = commentsCountLabelText.boundingRectWithSize(commentCountMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.titleFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
                
                let writeACommentLabelRect:CGRect = writeACommentLabelText.boundingRectWithSize(writeACommentMaxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes:NSDictionary(
                    object: self.valueFont!.fontWithSize(16.0),
                    forKey: NSFontAttributeName) as? [String : AnyObject], context:nil)
                
                
                let actionLabelHeight = actionLabelRect.size.height
                let aliasLabelHeight = aliasLabelRect.size.height
                let commentCountLabelHeight = commentCountLabelRect.size.height
                let writeACommentLabelHeight = writeACommentLabelRect.size.height
                
                //        print("alias label: \(aliasLabelHeight)")
                //        print("action content: \(actionLabelHeight)")
                //        print("comment count: \(commentCountLabelHeight)")
                //        print("write comment: \(writeACommentLabelHeight)")
                result = 22 + aliasLabelHeight + 4 + actionLabelHeight + 12 + 16 + 1 + 8 + commentCountLabelHeight + writeACommentLabelHeight + 10 + 5
//                print("status height: \(result)")
                return CGFloat(result)

            }
        }
        else{
            return 44
        }

    }
    
    func loadActivities(context:String){
        let followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser()!)
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                // Found FollowerFollowing object for current user
                let currentUserFollowerFollowingObject = objects![0]
                var currentUserFollowingUsers = currentUserFollowerFollowingObject["followingUsers"] as! [PFUser]
                let activityQuery = PFQuery(className: "Activity")
                
                // Include current user so user's own activities also show up
                currentUserFollowingUsers.append(PFUser.currentUser()!)

                activityQuery.whereKey("ownerUser", containedIn: currentUserFollowingUsers)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                activityQuery.limit = 10
                if context == "old"{
                    print("old time stamp")
                    if !self.currentActivities.isEmpty{
                        activityQuery.whereKey("createdAt", lessThan: (self.currentActivities.last as PFObject!).createdAt!)
                    }
                }
                else if context == "new"{
                    if !self.currentActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThan: (self.currentActivities.first as PFObject!).createdAt!)
                    }
                }
                else if context == "update"{
                    if !self.currentActivities.isEmpty{
                        activityQuery.whereKey("createdAt", greaterThanOrEqualTo: (self.currentActivities.last as PFObject!).createdAt!)
                        activityQuery.whereKey("createdAt", lessThanOrEqualTo: (self.currentActivities.first as PFObject!).createdAt!)
                        activityQuery.limit = 1000
                    }
                }
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects, error) -> Void in
                    if error == nil {

                        // Found activities
                        let currentActivitiesFound = objects!
                        if currentActivitiesFound.isEmpty{
                            self.refreshControl?.endRefreshing()
                        }
                        else{
                            var currentLikedAcitivitiesFoundIdStrings:[String] = []
                            if context == "old"{
                                if (objects!.count == 10){
                                    print("old more activities")
                                    self.moreActivities = true
                                }
                                else{
                                    print("old no more activities")
                                    self.moreActivities = false
                                }
                            }
                            // If activities count is 0, show no activity view, else display activities
                            if context == "old"{
                                print("old extend activities array")
                                self.currentActivities.appendContentsOf(currentActivitiesFound)
                            }
                            else if context == "new"{
                                self.currentActivities.insertContentsOf(currentActivitiesFound, at: 0)
                            }
                            else if context == "update"{
                                self.currentActivities = currentActivitiesFound
                            }
                            
                            if self.currentActivities.count == 0{
                                self.noActivityView.hidden = false
                                self.refreshControl?.endRefreshing()
                            }
                            else{
                                self.noActivityView.hidden = true
                            }
                            
                            
                            // Query activities liked by current user
                            var currentActivitiesFoundCommentCount = Array(count: currentActivitiesFound.count, repeatedValue: 0)
                            var currentActivitiesFoundLikeCount = Array(count: currentActivitiesFound.count, repeatedValue: 0)
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
                                    self.refreshControl?.endRefreshing()
                                }
                            }
                            // Query like count of activities
                            print(currentActivitiesFound.count)
                            for activity in currentActivitiesFound{
                                print("start counting")
                                let queryLikes = PFQuery(className: "_User")
                                queryLikes.whereKey("likedActivity", equalTo: activity)
                                queryLikes.fromLocalDatastore()
                                queryLikes.findObjectsInBackgroundWithBlock{
                                    (objects, error) -> Void in
                                    if error == nil {
                                        let count = objects!.count
                                        print("found like count")
                                        currentActivitiesFoundLikeCount[currentActivitiesFound.indexOf(activity)!] = count
                                        ++likeCountFound
                                        
                                        // Query comment count of activities
                                        let queryComments = PFQuery(className: "Comment")
                                        queryComments.fromLocalDatastore()
                                        queryComments.whereKey("activity", equalTo: activity)
                                        queryComments.findObjectsInBackgroundWithBlock{
                                            (objects, error) -> Void in
                                            if error == nil {
                                                let count = objects!.count
                                                print("found comment count")
                                                currentActivitiesFoundCommentCount[currentActivitiesFound.indexOf(activity)!] = count
                                                ++commentCountFound
                                                if likeCountFound == currentActivitiesFound.count && commentCountFound == currentActivitiesFound.count{
                                                    
                                                    self.prepareDataForTableView(currentActivitiesFound, currentActivitiesFoundCommentCount: currentActivitiesFoundCommentCount, currentActivitiesFoundLikeCount: currentActivitiesFoundLikeCount, currentLikedAcitivitiesFoundIdStrings: currentLikedAcitivitiesFoundIdStrings, context:context)
                                                    print(self.processedActivities)
                                                    self.loadNotifications()
                                                    if self.processedActivities.count == 0{
                                                        
                                                        //                                                        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                                                        self.tableView.reloadData()
                                                    }
                                                    else{
                                                        if context == "update"{
                                                            self.tableView.reloadRowsAtIndexPaths(self.tableView.indexPathsForVisibleRows!, withRowAnimation: UITableViewRowAnimation.None)
                                                        }
                                                        else if context == "old"{
                                                            
                                                            //                                                            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                                                            //                                                            print("reload old")
                                                            //                                                            print(self.processedActivities)
                                                            self.tableView.beginUpdates()
                                                            var indexPaths:[NSIndexPath] = []
                                                            let indexStart = self.tableView.numberOfRowsInSection(0)
                                                            print(indexStart)
                                                            for (var i = indexStart; i < indexStart + currentActivitiesFound.count; i++){
                                                                indexPaths.append(NSIndexPath(forRow: i, inSection: 0))
                                                            }
                                                            print(indexPaths)
                                                            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
                                                            self.tableView.endUpdates()
                                                            print(self.tableView.numberOfRowsInSection(0))
                                                        }
                                                        else if context == "new"{
                                                            //                                                            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)

                                                            self.tableView.reloadData()
                                                        }
                                                    }
                                                    //                                                    print("hello")
                                                    self.refreshControl?.endRefreshing()
                                                    
                                                }
                                            }
                                            else {
                                                // Log details of the failure
                                                NSLog("Error: %@ %@", error!, error!.userInfo)
                                                self.refreshControl?.endRefreshing()
                                                
                                            }
                                        }
                                        
                                    }
                                    else {
                                        // Log details of the failure
                                        NSLog("Error: %@ %@", error!, error!.userInfo)
                                        self.refreshControl?.endRefreshing()
                                    }
                                }
                                
                            }

                    }

                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error!, error!.userInfo)
                        self.refreshControl?.endRefreshing()

                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
                self.refreshControl?.endRefreshing()

            }
        }
        
    }


    func loadMoreActivities(){
     print("load more activities")
        self.loadActivities("old")
    }
    
    
    func prepareDataForTableView(activitiesToAppend:[PFObject], currentActivitiesFoundCommentCount:[Int], currentActivitiesFoundLikeCount:[Int], currentLikedAcitivitiesFoundIdStrings:[String], context:String){
        print("prepare")
//        self.processedActivities.removeAllObjects()
        var activityCount = 0
        if context == "update"{
            self.processedActivities.removeAllObjects()
            self.currentActivitiesLikeCount.removeAll(keepCapacity: false)
            self.currentActivitiesCommentCount.removeAll(keepCapacity: false)
        }

        for activity in activitiesToAppend{
            let currentActivityCreatedTime = activity.createdAt!
            let currentActivityChallenge = activity["challenge"] as! PFObject
            let currentActivityUserChallengeData = activity["userChallengeData"] as! PFObject
            let currentActivityUser = activity["ownerUser"] as! PFUser
            let currentAvatarString = currentActivityUser["avatar"] as! String
            let currentAvatarColor = currentActivityUser["color"] as! String
            let currentAction = currentActivityChallenge["action"] as! String
            var currentChallengeTrackNumber = Int((currentActivityUserChallengeData["challengeTrackNumber"] as! String))!
            currentChallengeTrackNumber = currentChallengeTrackNumber - 1
            let activityCreatedTimeLabel = currentActivityCreatedTime.shortTimeAgoSinceNow()

            
            var currentActivityDictionary = ["timeLabel":activityCreatedTimeLabel, "avatarImageViewImageString":"\(currentAvatarString)-icon", "avatarImageViewBackgroundColorString":currentAvatarColor, "aliasLabel":currentActivityUser.username!, "actionLabelText":currentAction, "currentActivityImageString":"", "currentNarrativeTitleString":"", "currentNarrativeContentString":"", "likeCountLabel":"", "commentCountLabel":"No comment", "liked":"no"]

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

            if currentActivitiesFoundLikeCount.count != 0{
                if currentActivitiesFoundLikeCount[activityCount] > 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundLikeCount[activityCount]) likes", forKey: "likeCountLabel")
                }
                else if currentActivitiesFoundLikeCount[activityCount] == 1{
                    currentActivityDictionary.updateValue("\(currentActivitiesFoundLikeCount[activityCount]) like", forKey: "likeCountLabel")
                }
            }
            
            if currentActivitiesFoundCommentCount.count != 0{
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
    
    // Register current user's liking of an activity on Parse if Like button tapped
    func likeButtonTapped(sender:UITapGestureRecognizer){
        let currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        let likedActivity = self.currentActivities[currentIndexPath.row]
        
        let user = PFUser.currentUser()!
        let relation = user.relationForKey("likedActivity")
        let currentLikeButton = sender.view as! UIImageView
        var currentLikeCount = 0
        let currentLikeCountLabel = sender.view?.superview?.subviews[0] as! UILabel
        let currentLikeCountText:String = currentLikeCountLabel.text!
        
        if currentLikeCountText == ""{
            currentLikeCount = 0
        }
        else{
            currentLikeCount = Int(currentLikeCountText.componentsSeparatedByString(" ")[0])!
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
            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId!)
//            let likedActivityQuery = relation.query()
            relation.removeObject(likedActivity)
            self.currentLikedAcitivitiesIdStrings = self.currentLikedAcitivitiesIdStrings.filter{$0 != likedActivity.objectId}
            user.saveInBackgroundWithBlock{(succeeded, error) -> Void in
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
            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId!)
//            let likedActivityQuery = relation.query()
            relation.addObject(likedActivity)
            user.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                if error == nil{
//                    self.loadActivities()
//                    self.tableView.reloadData()
                    
                    let newLikeNotification = PFObject(className: "Notification")
                    newLikeNotification["sender"] = PFUser.currentUser()
                    newLikeNotification["receiver"] = likedActivity["ownerUser"] as! PFUser
                    newLikeNotification["activity"] = likedActivity
                    newLikeNotification["type"] = "like"
                    newLikeNotification["read"] = false
                    newLikeNotification.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                        if error == nil{
                            // Send iOS Notification
                        }
                    }

                }
            }
        }

    }
    
    func showPersonDetail(sender:UITapGestureRecognizer){
        let currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        let currentActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = currentActivity
        self.performSegueWithIdentifier("showPersonDetail", sender: self)
    }

    
    // Perform segue to show activity detail if comment button tapped
    func commentButtonTapped(sender:UITapGestureRecognizer){
        let currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        
        let toCommentActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = toCommentActivity
        self.selectedSegment = "Comments"
        self.performSegueWithIdentifier("showActivityExpanded", sender: self)
    }
    
    func showActivityContentPreviewTapped(sender:UITapGestureRecognizer){
        let currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        
        let toPreviewActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = toPreviewActivity
        self.selectedSegment = "About"
        self.performSegueWithIdentifier("showActivityExpanded", sender: self)
    }
    
    // Present notification view if Notification button tapped
    func notificationButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showNotifications", sender: self)
    }
    
    // Present compose view if Compose button tapped
    func composeButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showCompose", sender: self)
    }
    
    func loadNotifications(){
        let notificationQuery = PFQuery(className: "Notification")
        notificationQuery.whereKey("receiver", equalTo: PFUser.currentUser()!)
        notificationQuery.whereKey("read", equalTo: false)
        notificationQuery.includeKey("sender")
        notificationQuery.includeKey("receiver")
        notificationQuery.includeKey("activity.challenge")
        notificationQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil{
                self.notifications = objects!
//                for notification in self.notifications{
//                }
                (self.navigationItem.leftBarButtonItem as! BBBadgeBarButtonItem).enabled = true
                (self.navigationItem.leftBarButtonItem as! BBBadgeBarButtonItem).badgeValue = "\(self.notifications.count)"
//                if self.notifications.count != 0 {
//                    (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = "\(self.notifications.count)"
//                }
//                else{
//                    (self.tabBarController?.tabBar.items![0] as! UITabBarItem).badgeValue = nil
//                }
            }
            else{
                print("didn't find any notifications")
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 3, inSection: 0) && self.moreActivities{
            print("load old")
            self.loadActivities("old")
        }
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
