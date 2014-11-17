//
//  ActivityTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ActivityTabViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var currentActivities:[PFObject] = []
    var currentLikedAcitivitiesIdStrings:[String] = []
    var currentActivity:PFObject!
    var currentActivitiesLikeCount:[Int] = []
    var currentActivitiesCommentCount:[Int] = []
    var likeCount:Int = 0
    var commentCount:Int = 0
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

    
//    var activityTableView:TPKeyboardAvoidingTableView!
//    var refreshControl:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Activity"
        var composeButton = UIBarButtonItem(image: UIImage(named: "compose-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "composeButtonTapped:")
        composeButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = composeButton
        
        var notificationButton = UIBarButtonItem(image: UIImage(named: "notification-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "notificationButtonTapped:")
        notificationButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = notificationButton
        
        
//        self.tableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.tableView.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        self.tableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 0, 0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        self.activityTableView.addSubview(refreshControl)


        loadActivities()

    }
    
    @IBAction func refreshActivityFeed(sender: UIRefreshControl) {
        sender.beginRefreshing()
        self.loadActivities()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showActivityDetail"{
            let newVC: ActivityDetailViewController = segue.destinationViewController as ActivityDetailViewController
            newVC.currentActivity = self.currentActivity
            newVC.parentVC = self
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentActivities.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as ActivityTableViewCell
        
        var likeButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "likeButtonTapped:")
        cell.likeButton.addGestureRecognizer(likeButtonTapGestureRecognizer)
        
        var commentButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commentButtonTapped:")
        cell.commentsButtonArea.addGestureRecognizer(commentButtonTapGestureRecognizer)

        var currentActivity = self.currentActivities[indexPath.row]
        var activityCreatedTime = currentActivity.createdAt
        var currentChallenge = currentActivity["challenge"] as PFObject
        var currentUserChallengeData = currentActivity["userChallengeData"] as PFObject
        var currentUser = currentActivity["ownerUser"] as PFUser

        var avatarString = currentUser["avatar"] as String
        var currentUserColor = currentUser["color"] as String
        var currentAction = currentChallenge["action"] as String
        var currentChallengeTrackNumber = (currentUserChallengeData["challengeTrackNumber"] as String).toInt()!
        currentChallengeTrackNumber = currentChallengeTrackNumber - 1
        var currentActivityImageString:String
        if (currentChallenge["narrativeImages"] as [String]).count > 0{
            currentActivityImageString = (currentChallenge["narrativeImages"] as [String])[currentChallengeTrackNumber] as String
            cell.heroImageView.image = UIImage(named: currentActivityImageString)
        }
        else{
            cell.heroImageView.image = nil
        }

        var activityCreatedTimeLabel = activityCreatedTime.shortTimeAgoSinceNow()
        cell.reverseTimeLabel.text = "\(activityCreatedTimeLabel)"
        cell.avatarImageView.image = UIImage(named: "\(avatarString)-icon")
        cell.avatarImageView.backgroundColor = self.colorDictionary[currentUserColor]
        cell.aliasLabel.text = currentUser.username
        cell.actionLabel.text = currentAction
//        cell.contentTypeIconImageView.image = UIImage(named: "web-icon")
        
        var currentNarrativeTitleString:String
        if (currentChallenge["narrativeTitles"] as [String]).count > 0{
            currentNarrativeTitleString = (currentChallenge["narrativeTitles"] as [String])[currentChallengeTrackNumber] as String
        }
        else{
            currentNarrativeTitleString = ""
        }

        cell.narrativeTitleLabel.text = currentNarrativeTitleString

        var currentNarrativeContentString:String
        if (currentChallenge["narrativeTitles"] as [String]).count > 0{
            currentNarrativeContentString = (currentChallenge["narrativeContents"] as [String])[currentChallengeTrackNumber] as String
        }
        else{
            currentNarrativeContentString = ""
        }

        
        cell.narrativeContentLabel.text = currentNarrativeContentString
        
        if self.currentActivitiesLikeCount.count == 0{
            cell.likeCountLabel.text = ""
        }
        else{
            if self.currentActivitiesLikeCount[indexPath.row] > 1{
                cell.likeCountLabel.text = "\(self.currentActivitiesLikeCount[indexPath.row]) likes"
            }
            else if self.currentActivitiesLikeCount[indexPath.row] == 1{
                cell.likeCountLabel.text = "\(self.currentActivitiesLikeCount[indexPath.row]) like"
            }
            else{
                cell.likeCountLabel.text = ""
            }
        }
        if self.currentActivitiesCommentCount.count == 0{
            cell.commentsCountLabel.text = "No comments"
        }
        else{
            if self.currentActivitiesCommentCount[indexPath.row] > 1{
                cell.commentsCountLabel.text = "\(self.currentActivitiesCommentCount[indexPath.row]) comments"
            }
            else if self.currentActivitiesCommentCount[indexPath.row] == 1{
                cell.commentsCountLabel.text = "\(self.currentActivitiesCommentCount[indexPath.row]) comment"
            }
            else{
                cell.commentsCountLabel.text = "No comments"
            }
        }
        
        if contains(self.currentLikedAcitivitiesIdStrings, currentActivity.objectId){
            cell.likeButton.image = UIImage(named: "likeButtonFilled-icon")
        }
        else{
            cell.likeButton.image = UIImage(named: "likeButton-icon")
        }

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func loadActivities(){
        var followingQuery = PFQuery(className: "FollowerFollowing")
        followingQuery.whereKey("ownerUser", equalTo: PFUser.currentUser())
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                var activityQuery = PFQuery(className: "Activity")
                var currentUserFollowerFollowingObject = objects[0] as PFObject
                var currentUserFollowingUsers = currentUserFollowerFollowingObject["followingUsers"] as [PFUser]
                currentUserFollowingUsers.append(PFUser.currentUser())
                activityQuery.whereKey("ownerUser", containedIn: currentUserFollowingUsers)
                activityQuery.includeKey("challenge")
                activityQuery.includeKey("userChallengeData")
                activityQuery.includeKey("ownerUser")
                activityQuery.orderByDescending("createdAt")
                activityQuery.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        self.currentActivities = objects as [PFObject]
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
                            }
                        }
                        for activity in self.currentActivities{
                            var queryLikes = PFQuery(className: "_User")
                            queryLikes.whereKey("likedActivity", equalTo: activity)
                            queryLikes.findObjectsInBackgroundWithBlock{
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                if error == nil {
                                    var count = objects.count
//                                    if self.currentActivitiesLikeCount.count > index{
////                                        println("likeCount for activity number \(index) is \(count)")
//                                        println(find(self.currentActivities, activity))
                                        self.currentActivitiesLikeCount[find(self.currentActivities, activity)!] = count
                                        ++self.likeCount
                                        if self.likeCount == self.currentActivities.count && self.commentCount == self.currentActivities.count{
                                            self.tableView.reloadData()
                                            self.refreshControl?.endRefreshing()
                                        }

//                                    }
//                                    else{
////                                        println("likeCount for activity number \(index) is \(count)")
//                                        println(find(self.currentActivities, activity))
//                                        self.currentActivitiesLikeCount.append(count)
//                                    }
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error, error.userInfo!)
                                }
                            }
                            var queryComments = PFQuery(className: "Comment")
                            queryComments.whereKey("activity", equalTo: activity)
                            queryComments.findObjectsInBackgroundWithBlock{
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                if error == nil {
                                    var count = objects.count
//                                    if self.currentActivitiesCommentCount.count > index{
//                                        println(find(self.currentActivities, activity))
//                                        println("commentCount for activity number \(index) is \(count)")
                                        self.currentActivitiesCommentCount[find(self.currentActivities, activity)!] = count
                                        ++self.commentCount
                                        if self.likeCount == self.currentActivities.count && self.commentCount == self.currentActivities.count{
                                            self.tableView.reloadData()
                                            self.refreshControl?.endRefreshing()
                                        }

//                                    }
//                                    else{
////                                        println("commentCount for activity number \(index) is \(count)")
//                                        println(find(self.currentActivities, activity))                                        
//                                        self.currentActivitiesCommentCount.append(count)
//                                    }
                                }
                                else {
                                    // Log details of the failure
                                    NSLog("Error: %@ %@", error, error.userInfo!)
                                }
                            }
                        }

                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
    
    func likeButtonTapped(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!

        var likedActivity = self.currentActivities[currentIndexPath.row]
        
        var user = PFUser.currentUser()
        var relation = user.relationForKey("likedActivity")
        var currentLikeButton = sender.view as UIImageView
        var currentLikeCount = 0
        var currentLikeCountLabel = sender.view?.superview?.subviews[0] as UILabel
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
            if currentLikeCount > 1{
                currentLikeCountLabel.text = "\(currentLikeCount) likes"
            }
            else if currentLikeCount == 1{
                currentLikeCountLabel.text = "\(currentLikeCount) like"
            }
            else{
                currentLikeCountLabel.text = ""
            }

            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId)
            var likedActivityQuery = relation.query()
            relation.removeObject(likedActivity)
            self.currentLikedAcitivitiesIdStrings = self.currentLikedAcitivitiesIdStrings.filter{$0 != likedActivity.objectId}
            user.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
                if error == nil{
                }
            }
        }
        else{
            currentLikeButton.image = UIImage(named: "likeButtonFilled-icon")
            ++currentLikeCount
            if currentLikeCount > 1{
                currentLikeCountLabel.text = "\(currentLikeCount) likes"
            }
            else if currentLikeCount == 1{
                currentLikeCountLabel.text = "\(currentLikeCount) like"
            }
            else{
                currentLikeCountLabel.text = ""
            }
            currentLikedAcitivitiesIdStrings.append(likedActivity.objectId)
            var likedActivityQuery = relation.query()
            relation.addObject(likedActivity)
            user.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
                if error == nil{
                }
            }
        }

    }
    

    func commentButtonTapped(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        
        var toCommentActivity = self.currentActivities[currentIndexPath.row]
        self.currentActivity = toCommentActivity

        self.performSegueWithIdentifier("showActivityDetail", sender: self)
    }
    

    func notificationButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showNotifications", sender: self)
    }
    
    func composeButtonTapped(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("showCompose", sender: self)
    }

}
