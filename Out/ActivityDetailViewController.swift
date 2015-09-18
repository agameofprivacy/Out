//
//  ActivityDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/12/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import SlackTextViewController
import Parse
// Controller for activity detail view
class ActivityDetailViewController: SLKTextViewController {

    var parentVC:ActivityTabViewController!
    var currentActivity:PFObject!
    
    var activityCardView:UIView!
    var activityHeroImageView:UIImageView!
    var activityTitle:UILabel!
    var activityAlias:UILabel!
    var activityAvatar:UIImageView!
    var comments:[PFObject] = []
    
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

    
    override class func tableViewStyleForCoder(decoder: NSCoder) -> UITableViewStyle {
        return UITableViewStyle.Plain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadComments()
        
        self.navigationItem.title = "Comments"
        
        self.activityCardView = UIView(frame: CGRectZero)
        self.activityCardView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityCardView)
        
        self.activityHeroImageView = UIImageView(frame: CGRectZero)
        self.activityHeroImageView.translatesAutoresizingMaskIntoConstraints = false
        self.activityCardView.addSubview(self.activityHeroImageView)
        
        self.activityTitle = UILabel(frame: CGRectZero)
        self.activityTitle.translatesAutoresizingMaskIntoConstraints = false
        self.activityCardView.addSubview(self.activityTitle)
        
        self.activityAlias = UILabel(frame: CGRectZero)
        self.activityAlias.translatesAutoresizingMaskIntoConstraints = false
        self.activityCardView.addSubview(self.activityAlias)
        
        self.activityAvatar = UIImageView(frame: CGRectZero)
        self.activityAvatar.translatesAutoresizingMaskIntoConstraints = false
        self.activityCardView.addSubview(self.activityAvatar)
        
        self.bounces = true
        self.keyboardPanningEnabled = true
        self.inverted = true

        self.tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.textView.placeholder = "Comment"
        self.textView.placeholderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        self.textView.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1).CGColor
        self.textView.pastableMediaTypes = SLKPastableMediaType.None
        self.rightButton.setTitle("Post", forState: UIControlState.Normal)
        
        self.textInputbar.autoHideRightButton = true
        self.textInputbar.maxCharCount = 140
        self.textInputbar.counterStyle = SLKCounterStyle.Split
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.textView.resignFirstResponder()
    }
    
    // Store new comment if Post button tapped
    override func didPressRightButton(sender: AnyObject!) {
        self.textView.refreshFirstResponder()
        
        let comment:String = self.textView.text
        
        self.tableView.beginUpdates()
        let newComment = PFObject(className: "Comment")
        newComment["activity"] = self.currentActivity
        newComment["author"] = PFUser.currentUser()
        newComment["content"] = comment
        self.comments.insert(newComment, atIndex: 0)
        newComment.saveInBackgroundWithBlock(nil)
        let newCommentNotification = PFObject(className: "Notification")
        newCommentNotification["activity"] = self.currentActivity
        newCommentNotification["sender"] = PFUser.currentUser()
        newCommentNotification["receiver"] = self.currentActivity["ownerUser"] as! PFUser
        newCommentNotification["read"] = false
        newCommentNotification["type"] = "comment"
        newCommentNotification.saveInBackgroundWithBlock{(succeeded, error) -> Void in
            if error == nil{
                // Send iOS Notification
            }
        }
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()

        self.tableView.slk_scrollToTopAnimated(true)
        super.didPressRightButton(sender)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    // Table view data source method
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
        let comment = self.comments[indexPath.row]
        let author = comment["author"] as! PFUser
        let authorAlias = author.username
        let commentContent = comment["content"] as! String
        let authorAvatarString = author["avatar"] as! String
        let authorAvatar = self.avatarImageDictionary[authorAvatarString]!
        let authorColorString = author["color"] as! String
        let authorColor = self.colorDictionary[authorColorString]
        var timeAgoLabel = ""
        if comment.createdAt != nil{
            timeAgoLabel = comment.createdAt!.shortTimeAgoSinceNow()
        }
        else{
            timeAgoLabel = "just now"
        }
        cell.aliasLabel.text = authorAlias
        cell.avatarImageView.image = authorAvatar
        cell.avatarImageView.backgroundColor = authorColor
        cell.commentLabel.text = commentContent
        cell.timeAgoLabel.text = timeAgoLabel
        cell.transform = self.tableView.transform
        return cell
    }
    
    override func viewDidDisappear(animated: Bool) {
//        self.parentVC.loadActivities("new")
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Query Parse for comments associated with current activity
    func loadComments(){
        let commentsQuery = PFQuery(className: "Comment")
        commentsQuery.whereKey("activity", equalTo: self.currentActivity)
        commentsQuery.includeKey("author")
        commentsQuery.orderByDescending("createdAt")
        commentsQuery.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil {
                self.comments = objects!
                self.tableView.reloadData()
            }
            else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
    }
    
}
