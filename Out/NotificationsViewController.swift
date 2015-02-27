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
    var notifications:[PFObject] = []
    
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

        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.rowHeight = UITableViewAutomaticDimension
        self.notificationsTableView.estimatedRowHeight = 100
        self.view.addSubview(self.notificationsTableView)
        
        
        
        loadNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:NotificationTableViewCell = self.notificationsTableView.dequeueReusableCellWithIdentifier("notificationCell") as! NotificationTableViewCell
        var sender:PFUser = (self.notifications[indexPath.row] as PFObject)["sender"] as! PFUser
        
        cell.senderLabel.text = sender.username
        cell.senderAvatarImageView.image = self.avatarImageDictionary[sender["avatar"] as! String]!
        cell.senderAvatarImageView.backgroundColor = self.colorDictionary[sender["color"] as! String]
        
        var receiver:PFUser = (self.notifications[indexPath.row] as PFObject)["receiver"] as! PFUser
        cell.receiverLabel.text = receiver.username
        
        // Check for notification type
        if ((self.notifications[indexPath.row] as PFObject)["type"] as! String) == "comment"{
            cell.notificationTypeLabel.text = "Commented"
        }
        else{
            cell.notificationTypeLabel.text = "Liked"
        }
        
        // Check for notification read status
        if ((self.notifications[indexPath.row] as PFObject)["read"] as! Bool){
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor(white: 1, alpha: 1)
        }

        var notificationCreatedTime = self.notifications[indexPath.row].createdAt
        var notificationTimeLabel = notificationCreatedTime.shortTimeAgoSinceNow()
        cell.timeLabel.text = notificationTimeLabel
        return cell
    }
    
    // Dismiss notifications modal
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadNotifications(){
        var notificationQuery = PFQuery(className: "Notification")
        notificationQuery.whereKey("receiver", equalTo: PFUser.currentUser())
        notificationQuery.includeKey("sender")
        notificationQuery.includeKey("receiver")
        notificationQuery.includeKey("activity")
        notificationQuery.orderByDescending("createdAt")
        notificationQuery.orderByAscending("read")
        notificationQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil{
                self.notifications = objects as! [PFObject]
                self.notificationsTableView.reloadData()
            }
            else{
                println("didn't find any notifications")
            }
        }
    }
    
}
