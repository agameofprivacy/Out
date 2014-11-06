//
//  ActivityTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ActivityTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
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

    var activityTableView:TPKeyboardAvoidingTableView!
//    var refreshControl:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Activity"
        
        self.activityTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.activityTableView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.activityTableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        self.activityTableView.contentInset = UIEdgeInsetsMake(12, 0, 0, 0)
        self.activityTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.activityTableView.delegate = self
        self.activityTableView.dataSource = self
        self.activityTableView.rowHeight = UITableViewAutomaticDimension
        self.activityTableView.estimatedRowHeight = 100
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        self.activityTableView.addSubview(refreshControl)

        self.view.addSubview(self.activityTableView)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ActivityTableViewCell = tableView.dequeueReusableCellWithIdentifier("ActivityTableViewCell") as ActivityTableViewCell
        
        cell.reverseTimeLabel.text = "2h ago"
        cell.avatarImageView.image = UIImage(named: "dog-icon")
        cell.avatarImageView.backgroundColor = self.colorDictionary["teal"]
        cell.aliasLabel.text = "dog320"
        cell.actionLabel.text = "Volunteered at an Lesbian, Gay, Bisexual and Transgender community non-profit"
        cell.heroImageView.image = UIImage(named: "glwdActivityHero")
        cell.contentTypeIconImageView.image = UIImage(named: "web-icon")
        cell.narrativeTitleLabel.text = "God's Love We Deliver"
        cell.narrativeContentLabel.text = "God's Love We Deliver prepare and deliver nutritious, high-quality meals to people who, because of their illness, are unable to provide or prepare meals for themselves."
        cell.commentsCountLabel.text = "2 comments"
        cell.writeACommentLabel.text = "write a comment"
        cell.likeCountLabel.text = "4 likes"

        if indexPath.row == 1{
            cell.likeButton.image = UIImage(named: "likeButtonFilled-icon")
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
    
    func refresh(sender:UIRefreshControl){
        println("Start Refreshing")
//        self.refreshControl.endRefreshing()
        println("Refreshing Ended")
    }

}
