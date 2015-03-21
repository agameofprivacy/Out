//
//  NotificationsViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for notifications view
class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var notificationsTableView:TPKeyboardAvoidingTableView!
    var unreadNotifications:[PFObject] = []
    var readNotifications:[PFObject] = []
    
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
        self.navigationItem.title = "Notifications"
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        
        self.notificationsTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.notificationsTableView.registerClass(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationCell")
        self.notificationsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.notificationsTableView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.rowHeight = UITableViewAutomaticDimension
        self.notificationsTableView.estimatedRowHeight = 100
        self.view.addSubview(self.notificationsTableView)
        
        
        
        loadAdditionalNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.unreadNotifications.count
        }
        else{
            return self.readNotifications.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:NotificationTableViewCell = self.notificationsTableView.dequeueReusableCellWithIdentifier("notificationCell") as! NotificationTableViewCell
        var notification:PFObject

        if (indexPath.section == 0){
            notification = self.unreadNotifications[indexPath.row] as PFObject
        }
        else{
            notification = self.readNotifications[indexPath.row] as PFObject
        }
        
        var sender = notification["sender"] as! PFUser
        var receiver = notification["receiver"] as! PFUser
        var challenge = (notification["activity"] as! PFObject)["challenge"] as! PFObject
        var notificationCreatedTime = notification.createdAt
        var notificationTimeLabel = notificationCreatedTime.timeAgoSinceNow()
        
        
        var challengeTitleString = challenge["title"] as! String
        var narrativeActionString:String
        if notification["type"] as! String == "comment"{
            narrativeActionString = " commented on "
        }
        else{
            narrativeActionString = " liked "
        }
        var notificationString = sender.username + narrativeActionString + "your activity " + challengeTitleString + "."
        
        var notificationTextViewAttributedString = NSMutableAttributedString(string: notificationString)
        var textViewParagraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        textViewParagraphStyle.lineSpacing = 0

//        notificationTextViewAttributedString.addAttribute(NSParagraphStyleAttributeName, value: textViewParagraphStyle, range: (notificationString as NSString).rangeOfString(notificationString))
        
        notificationTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: 15)!, range: (notificationString as NSString).rangeOfString(notificationString))

        notificationTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: (notificationString as NSString).rangeOfString(sender.username))
        notificationTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: (notificationString as NSString).rangeOfString(challengeTitleString))

        cell.notificationTextView.attributedText = notificationTextViewAttributedString
        cell.senderAvatarImageView.image = self.avatarImageDictionary[sender["avatar"] as! String]!
        cell.senderAvatarImageView.backgroundColor = self.colorDictionary[sender["color"] as! String]
        cell.timeLabel.text = notificationTimeLabel

        // Check for notification read status
        if (indexPath.section == 1){
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor(white: 1, alpha: 1)
        }
        
        var notificationCellTappedGestureReconizer = UITapGestureRecognizer(target: self, action: "notificationCellTapped:")
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

//    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        var activityToBeRead = self.notifications[indexPath.row] as PFObject
//        activityToBeRead["read"] = true
//        activityToBeRead.saveInBackgroundWithBlock(nil)
//    }
    
    // Dismiss notifications modal
    func closeButtonTapped(){
        for activity in self.unreadNotifications{
            activity["read"] = true
            activity.saveInBackgroundWithBlock(nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            println("View notified activity: \(indexPath.row)")
        }
        else{
            println("View notified activity: \(indexPath.row)")
        }
    }
    
    func notificationCellTapped(tappedGestureRecognizer:UITapGestureRecognizer){
        
    }
    
    func loadAdditionalNotifications(){
        var notificationQuery = PFQuery(className: "Notification")
        notificationQuery.whereKey("receiver", equalTo: PFUser.currentUser())
        notificationQuery.whereKey("read", equalTo: true)
        notificationQuery.includeKey("sender")
        notificationQuery.includeKey("receiver")
        notificationQuery.includeKey("activity.challenge")
        notificationQuery.orderByDescending("createdAt")
        notificationQuery.limit = 15
        notificationQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil{
                self.readNotifications.extend(objects as! [PFObject])
                self.notificationsTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            else{
                println("didn't find any notifications")
            }
        }
    }
    
}
