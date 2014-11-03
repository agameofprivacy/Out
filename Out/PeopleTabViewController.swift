//
//  PeopleTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users:[AnyObject] = []
    
    var peopleTableView:TPKeyboardAvoidingTableView!
    var mentorCellOverlay:UIView!
    var segmentedControlView:UIView!
    var segmentedControl:UISegmentedControl!
    
    var mentorAvatar:UIImageView!
    var mentorRole:UILabel!
    var mentorAlias:UILabel!
    var mentorOrganization:UILabel!
    var mentorLocation:UILabel!
    var mentorButton:UIButton!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
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
        
        self.navigationItem.title = "People"
        
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPeople:")
        addButton.enabled = true
        addButton.tintColor = UIColor.blackColor()
        
        self.navigationItem.rightBarButtonItem = addButton

        
        self.view.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        
        
        self.peopleTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.peopleTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.peopleTableView.contentInset = UIEdgeInsets(top: 130.0, left: 0, bottom:0, right: 0)
        self.peopleTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.peopleTableView.backgroundColor = UIColor.whiteColor()
        self.peopleTableView.frame = self.view.frame
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 80
        self.peopleTableView.delegate = self
        self.peopleTableView.dataSource = self
        self.peopleTableView.layoutMargins = UIEdgeInsetsZero
        self.peopleTableView.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(self.peopleTableView)

        
        self.mentorCellOverlay = UIView(frame: CGRectZero)
        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorCellOverlay.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var toMentorDetailTapRecognizer = UITapGestureRecognizer(target: self, action: "mentorCellTapped:")
        self.mentorCellOverlay.addGestureRecognizer(toMentorDetailTapRecognizer)
        self.view.addSubview(self.mentorCellOverlay)
        
        
        self.mentorAvatar = UIImageView(frame: CGRectZero)
        self.mentorAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAvatar.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
        self.mentorAvatar.layer.cornerRadius = 25
        self.mentorAvatar.clipsToBounds = true
        self.mentorAvatar.image = UIImage(named: "elephant-icon")
        self.mentorAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        self.mentorCellOverlay.addSubview(self.mentorAvatar)
        
        self.mentorRole = UILabel(frame: CGRectZero)
        self.mentorRole.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorRole.textAlignment = NSTextAlignment.Left
        self.mentorRole.font = titleFont?.fontWithSize(17.0)
        self.mentorRole.preferredMaxLayoutWidth = 50
        self.mentorRole.numberOfLines = 1
        self.mentorRole.text = "mentor"
        self.mentorCellOverlay.addSubview(self.mentorRole)

        self.mentorAlias = UILabel(frame: CGRectZero)
        self.mentorAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAlias.textAlignment = NSTextAlignment.Left
        self.mentorAlias.font = regularFont
        self.mentorAlias.preferredMaxLayoutWidth = 50
        self.mentorAlias.numberOfLines = 1
        self.mentorAlias.text = "eleph34"
        self.mentorCellOverlay.addSubview(self.mentorAlias)
        
        self.mentorOrganization = UILabel(frame: CGRectZero)
        self.mentorOrganization.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorOrganization.textAlignment = NSTextAlignment.Right
        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
        self.mentorOrganization.preferredMaxLayoutWidth = 200
        self.mentorOrganization.numberOfLines = 1
        self.mentorOrganization.text = "The Trevor Project"

        
        self.mentorLocation = UILabel(frame: CGRectZero)
        self.mentorLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorLocation.textAlignment = NSTextAlignment.Right
        self.mentorLocation.font = regularFont
        self.mentorLocation.preferredMaxLayoutWidth = 200
        self.mentorLocation.numberOfLines = 1
        self.mentorLocation.text = "New York, NY"
        
        self.mentorButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mentorButton.frame = CGRectZero
        self.mentorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorButton.setImage(UIImage(named: "rightChevron-icon"), forState: UIControlState.Normal)
        self.mentorButton.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        var mentorCellViewsDictionary = ["mentorAvatar":mentorAvatar, "mentorRole":mentorRole, "mentorAlias":mentorAlias, "mentorOrganization":mentorOrganization, "mentorLocation":mentorLocation, "mentorButton":mentorButton]
        var mentorCellMetricsDictionary = ["sideMargin":15, "topMargin":64 + 16, "bottomMargin": 18]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mentorAvatar(50)]-20-[mentorRole]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        

        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAvatar(50)]-15-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-82-[mentorRole]-3-[mentorAlias]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        

        self.mentorCellOverlay.addConstraints(topHorizontalConstraints)
        self.mentorCellOverlay.addConstraints(avatarVerticalConstraints)
        self.mentorCellOverlay.addConstraints(leftVerticalConstraints)
        

        
        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControlView.backgroundColor = UIColor.whiteColor()
        self.segmentedControlView.layer.masksToBounds = false
        self.segmentedControlView.layer.shadowColor = UIColor.blackColor().CGColor
        self.segmentedControlView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.segmentedControlView.layer.shadowOpacity = 0.1
        self.segmentedControlView.layer.shadowRadius = 1
        self.view.addSubview(self.segmentedControlView)

        self.segmentedControl = UISegmentedControl(items: ["Following","Followers"])
        self.segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControl.tintColor = UIColor.blackColor()
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControlView.addSubview(self.segmentedControl)
        
        var viewsDictionary = ["mentorCellOverlay":mentorCellOverlay, "segmentedControlView":segmentedControlView]
        var metricsDiciontary = ["margin":0]
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[mentorCellOverlay(144)]-0-[segmentedControlView(50)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDiciontary, views: viewsDictionary)
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[mentorCellOverlay]-margin-|", options: NSLayoutFormatOptions(0), metrics: metricsDiciontary, views: viewsDictionary)
        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(horizontalConstraints)
        
        var segmentsViewsDictionary = ["segmentedControl":segmentedControl]
        var segmentsMetricsDictionary = ["margin":12]
        
        var segmentsHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[segmentedControl]-margin-|", options: NSLayoutFormatOptions(0), metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        var segmentsVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl]-10-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        
        self.segmentedControlView.addConstraints(segmentsHorizontalConstraints)
        self.segmentedControlView.addConstraints(segmentsVerticalConstraints)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.loadUsers()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
        var user = self.users[indexPath.row] as PFUser
        cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as String]
        cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as String]!
        cell.userAlias.text = user.username
        var userOrientation = user["sexualOrientation"] as String
        var userAge = user["age"] as Int
        cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
        var userCity = user["city"] as String
        var userState = user["state"] as String
        cell.userLocation.text = "\(userCity), \(userState)"

        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mentorCellTapped(sender:UIGestureRecognizer){
        println("mentorButtonTapped!")
    }
    
    
    func loadUsers(){
        self.peopleTableView.hidden = true
//        self.activityIndicator.startAnimating()
        var queryUsers = PFQuery(className:"_User")
        queryUsers.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.users = objects
                self.peopleTableView.reloadData()
//                self.activityIndicator.stopAnimating()
                self.peopleTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func addPeople(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("presentPeopleGallery", sender: self)
    }


}
