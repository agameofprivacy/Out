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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar init and layout
        self.navigationItem.title = "Notifications"
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        
        self.notificationsTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.notificationsTableView.registerClass(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationCell")
//        self.notificationsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
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
        println(self.notifications.count)
        return self.notifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:NotificationTableViewCell = self.notificationsTableView.dequeueReusableCellWithIdentifier("notificationCell") as! NotificationTableViewCell
        var sender:PFUser = (self.notifications[indexPath.row] as PFObject)["sender"] as! PFUser
        cell.senderLabel.text = sender.username
        cell.senderAvatarImageView.image = UIImage(named: "dog-icon")
        cell.senderAvatarImageView.backgroundColor = UIColor.blackColor()
        cell.receiverLabel.text = "Planets"
        cell.notificationTypeLabel.text = "Commented"
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
        notificationQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil{
                self.notifications = objects as! [PFObject]
                self.notificationsTableView.reloadData()
                println(self.notifications)
            }
            else{
                println("didn't find any notifications")
            }
        }
    }
    
}
