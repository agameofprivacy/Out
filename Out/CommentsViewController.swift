//
//  CommentsViewController.swift
//  Out
//
//  Created by Eddie Chen on 3/30/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class CommentsViewController: SLKTextViewController {

    var comments:[PFObject] = []
    var activity:PFObject!
    
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
        self.loadComments()
        // Do any additional setup after loading the view.
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        //        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.scrollsToTop = true
        self.bounces = true
        self.keyboardPanningEnabled = true
        self.inverted = true
        
        self.tableView.frame = self.view.frame
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 171
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footer = UIView(frame: CGRectMake(0, 0, 375, 20))
        footer.backgroundColor = UIColor.clearColor()
        return footer
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didPressRightButton(sender: AnyObject!) {
        self.textView.refreshFirstResponder()
        var comment:String = self.textView.text
        self.tableView.beginUpdates()
        
        var newComment = PFObject(className: "Comment")
        newComment["activity"] = self.activity
        newComment["author"] = PFUser.currentUser()
        newComment["content"] = comment
        self.comments.insert(newComment, atIndex: 0)
        newComment.saveInBackground()
        var newCommentNotification = PFObject(className: "Notification")
        newCommentNotification["activity"] = self.activity
        newCommentNotification["sender"] = PFUser.currentUser()
        newCommentNotification["receiver"] = self.activity["ownerUser"] as! PFUser
        newCommentNotification["read"] = false
        newCommentNotification["type"] = "comment"
        newCommentNotification.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
            if error == nil{
                // Send iOS Notification
            }
        }
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        super.didPressRightButton(sender)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
        var comment = self.comments[indexPath.row]
        var author = comment["author"] as! PFUser
        var authorAlias = author.username
        var commentContent = comment["content"] as! String
        var authorAvatarString = author["avatar"] as! String
        var authorAvatar = self.avatarImageDictionary[authorAvatarString]!
        var authorColorString = author["color"] as! String
        var authorColor = self.colorDictionary[authorColorString]
        var timeAgoLabel = ""
        if comment.createdAt != nil{
            timeAgoLabel = comment.createdAt.timeAgoSinceNow()
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
    
    
    // Query Parse for comments associated with current activity
    func loadComments(){
        var commentsQuery = PFQuery(className: "Comment")
        commentsQuery.whereKey("activity", equalTo: self.activity)
        commentsQuery.includeKey("author")
        commentsQuery.orderByDescending("createdAt")
        commentsQuery.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.comments = objects as! [PFObject]
                self.tableView.reloadData()
            }
            else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
}
