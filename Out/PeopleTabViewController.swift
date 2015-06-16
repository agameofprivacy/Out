//
//  PeopleTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import Parse
// Controller for people tab view, displays mentor, following, and follower information
class PeopleTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var followingRequestedFrom:[PFUser] = []
    var followingUsers:[PFUser] = []
    var followers:[PFUser] = []
    var following:[PFUser] = []
    var followerFollowingObject:PFObject = PFObject(className: "FollowerFollowing", dictionary: ["requestsFromUsers":[],"followers":[], "followingUsers":[]])
    var user:PFUser!
    
    var FollowingTableViewController:UITableViewController = UITableViewController()
    var FollowerTableViewController:UITableViewController = UITableViewController()

    
    var followerTableView = TPKeyboardAvoidingTableView()
    var followingTableView = TPKeyboardAvoidingTableView()
    
    var mentorCellOverlay:UIView!
    var segmentedControlView:UIView!
    var segmentedControlViewSeparator:UIView!
    var segmentedControl:UISegmentedControl!
    
    var noFollowerView:UIView!
    var noFollowingView:UIView!
    
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

        self.addChildViewController(self.FollowingTableViewController)
        self.addChildViewController(self.FollowerTableViewController)
        // UINavigationBar init and layout
        self.navigationItem.title = "People"

        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPeople:")
        addButton.enabled = true
        addButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = addButton
        
        let chatButton = UIBarButtonItem(image: UIImage(named: "chatIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "showPeerChat")
        self.navigationItem.leftBarButtonItem = chatButton
        
        // followingTableView init
        self.followingTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.followingTableView.translatesAutoresizingMaskIntoConstraints = false
        self.followingTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.followingTableView.backgroundColor = UIColor.whiteColor()
        self.followingTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.followingTableView.separatorColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
//        self.followingTableView.contentInset.bottom = 49
//        self.followingTableView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 44.5)
        self.followingTableView.rowHeight = UITableViewAutomaticDimension
        self.followingTableView.estimatedRowHeight = 80
        self.followingTableView.delegate = self
        self.followingTableView.dataSource = self
//        self.followingTableView.layoutMargins = UIEdgeInsetsZero
//        self.followingTableView.separatorInset = UIEdgeInsetsZero
        self.followingTableView.hidden = true
        self.view.addSubview(self.followingTableView)
        self.FollowingTableViewController.tableView = self.followingTableView
        self.FollowingTableViewController.refreshControl = UIRefreshControl()
        self.FollowingTableViewController.refreshControl!.addTarget(self, action: "loadPeople", forControlEvents: UIControlEvents.ValueChanged)

        // followerTableView init
        self.followerTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.followerTableView.translatesAutoresizingMaskIntoConstraints = false
        self.followerTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.followerTableView.registerClass(PersonFollowTableViewCell.self, forCellReuseIdentifier: "PersonFollowTableViewCell")
        self.followerTableView.backgroundColor = UIColor.whiteColor()
//        self.followerTableView.frame.origin.y = 44.5 + 64
//        self.followerTableView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 44.5 - 64)
        self.followerTableView.contentInset.bottom = 49
        self.followerTableView.contentInset.top = 44.5 + 64
        self.followerTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.followerTableView.separatorColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.followerTableView.rowHeight = UITableViewAutomaticDimension
        self.followerTableView.estimatedRowHeight = 80
        self.followerTableView.delegate = self
        self.followerTableView.dataSource = self
//        self.followerTableView.layoutMargins = UIEdgeInsetsZero
//        self.followerTableView.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(self.followerTableView)

        self.FollowerTableViewController.tableView = self.followerTableView
        self.FollowerTableViewController.refreshControl = UIRefreshControl()
        self.FollowerTableViewController.refreshControl!.addTarget(self, action: "loadPeople", forControlEvents: UIControlEvents.ValueChanged)
        
        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControlView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.segmentedControlView)
        
        self.segmentedControl = UISegmentedControl(items: ["Followers","Following"])
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.tintColor = UIColor.blackColor()
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.segmentedControlView.addSubview(self.segmentedControl)
        
        self.segmentedControlViewSeparator = UIView(frame: CGRectZero)
        self.segmentedControlViewSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControlViewSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.segmentedControlView.addSubview(self.segmentedControlViewSeparator)

        
        // mentorCellOverlay init
//        self.mentorCellOverlay = UIView(frame: CGRectZero)
//        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorCellOverlay.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        var toMentorDetailTapRecognizer = UITapGestureRecognizer(target: self, action: "mentorCellTapped:")
//        self.mentorCellOverlay.addGestureRecognizer(toMentorDetailTapRecognizer)
//        self.mentorCellOverlay.layer.masksToBounds = false
//        self.mentorCellOverlay.layer.shadowColor = UIColor.blackColor().CGColor
//        self.mentorCellOverlay.layer.shadowOpacity = 0.15
//        self.mentorCellOverlay.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.mentorCellOverlay.layer.shadowRadius = 1
//        self.view.addSubview(self.mentorCellOverlay)
//        
//        self.mentorAvatar = UIImageView(frame: CGRectZero)
//        self.mentorAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorAvatar.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
//        self.mentorAvatar.layer.cornerRadius = 25
//        self.mentorAvatar.clipsToBounds = true
//        self.mentorAvatar.image = UIImage(named: "elephant-icon")
//        self.mentorAvatar.contentMode = UIViewContentMode.ScaleAspectFit
//        self.mentorCellOverlay.addSubview(self.mentorAvatar)
//        
//        self.mentorRole = UILabel(frame: CGRectZero)
//        self.mentorRole.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorRole.textAlignment = NSTextAlignment.Left
//        self.mentorRole.font = titleFont?.fontWithSize(17.0)
//        self.mentorRole.preferredMaxLayoutWidth = 50
//        self.mentorRole.numberOfLines = 1
//        self.mentorRole.text = "mentor"
//        self.mentorCellOverlay.addSubview(self.mentorRole)
//
//        self.mentorAlias = UILabel(frame: CGRectZero)
//        self.mentorAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorAlias.textAlignment = NSTextAlignment.Left
//        self.mentorAlias.font = regularFont
//        self.mentorAlias.preferredMaxLayoutWidth = 50
//        self.mentorAlias.numberOfLines = 1
//        self.mentorAlias.text = "eleph34"
//        self.mentorCellOverlay.addSubview(self.mentorAlias)
//        
//        self.mentorOrganization = UILabel(frame: CGRectZero)
//        self.mentorOrganization.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorOrganization.textAlignment = NSTextAlignment.Right
//        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
//        self.mentorOrganization.preferredMaxLayoutWidth = 200
//        self.mentorOrganization.numberOfLines = 1
//        self.mentorOrganization.text = "The Trevor Project"
//        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
//        self.mentorCellOverlay.addSubview(self.mentorOrganization)
//
//        self.mentorLocation = UILabel(frame: CGRectZero)
//        self.mentorLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorLocation.textAlignment = NSTextAlignment.Right
//        self.mentorLocation.font = regularFont
//        self.mentorLocation.preferredMaxLayoutWidth = 200
//        self.mentorLocation.numberOfLines = 1
//        self.mentorLocation.text = "New York, NY"
//        self.mentorLocation.font = valueFont?.fontWithSize(14.0)
//        self.mentorCellOverlay.addSubview(self.mentorLocation)
//        
//        self.mentorButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        self.mentorButton.frame = CGRectZero
//        self.mentorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mentorButton.setImage(UIImage(named: "rightChevron-icon"), forState: UIControlState.Normal)
//        self.mentorButton.contentMode = UIViewContentMode.ScaleAspectFit
//        
//        
//        var mentorCellViewsDictionary = ["mentorAvatar":mentorAvatar, "mentorRole":mentorRole, "mentorAlias":mentorAlias, "mentorOrganization":mentorOrganization, "mentorLocation":mentorLocation, "mentorButton":mentorButton]
//        
//        var mentorCellMetricsDictionary = ["sideMargin":15, "topMargin":64 + 16, "bottomMargin": 18]
//        
//        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mentorAvatar(50)]-20-[mentorRole]->=26-[mentorOrganization]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
//        
//
//        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAvatar(50)]-15-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
//        
//        
//        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-82-[mentorRole]-3-[mentorAlias]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
//        var rightVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-87-[mentorOrganization]-3-[mentorLocation]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
//
//
//        self.mentorCellOverlay.addConstraints(topHorizontalConstraints)
//        self.mentorCellOverlay.addConstraints(avatarVerticalConstraints)
//        self.mentorCellOverlay.addConstraints(leftVerticalConstraints)
//        self.mentorCellOverlay.addConstraints(rightVerticalConstraints)
        
        
        let viewsDictionary = ["segmentedControlView":segmentedControlView, "followingTableView":self.followingTableView, "followerTableView":followerTableView]
        let metricsDiciontary = ["margin":0]
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[segmentedControlView(44.5)]", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: metricsDiciontary, views: viewsDictionary)
        
        let followingViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-44.5-[followingTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metricsDiciontary, views: viewsDictionary)

        let followerViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[followerTableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDiciontary, views: viewsDictionary)

        let horizontalFollowingViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[followingTableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDiciontary, views: viewsDictionary)
        
        let horizontalFollowerViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[followerTableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDiciontary, views: viewsDictionary)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[segmentedControlView]-margin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDiciontary, views: viewsDictionary)

        self.view.addConstraints(horizontalFollowingViewConstraints)
        self.view.addConstraints(horizontalFollowerViewConstraints)
        self.view.addConstraints(followingViewConstraints)
        self.view.addConstraints(followerViewConstraints)
        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(horizontalConstraints)
        
        let segmentsViewsDictionary = ["segmentedControl":segmentedControl, "segmentedControlViewSeparator":segmentedControlViewSeparator]
        let segmentsMetricsDictionary = ["margin":7.5]
        
        let segmentsHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[segmentedControl]-margin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        
        let segmentsSeparatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentedControlViewSeparator]|", options: NSLayoutFormatOptions(rawValue:0), metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)

        let segmentsVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl(28)]-8-[segmentedControlViewSeparator(0.5)]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        
        self.segmentedControlView.addConstraints(segmentsHorizontalConstraints)
        self.segmentedControlView.addConstraints(segmentsSeparatorHorizontalConstraints)
        self.segmentedControlView.addConstraints(segmentsVerticalConstraints)
        
        // No follower view init and layout
        self.noFollowerView = UIView(frame: self.view.frame)
        self.noFollowerView.backgroundColor = UIColor.whiteColor()
        self.noFollowerView.center = self.view.center
        
        let noFollowerViewTitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowerView.frame.height / 5, self.noFollowerView.frame.width, 32))
        noFollowerViewTitle.text = "No Followers"
        noFollowerViewTitle.textAlignment = NSTextAlignment.Center
        noFollowerViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noFollowerViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noFollowerView.addSubview(noFollowerViewTitle)
        let noFollowerViewSubtitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowerView.frame.height / 5 + 31, self.noFollowerView.frame.width, 60))
        noFollowerViewSubtitle.text = "you will receive a follow request\nif someone follows you"
        noFollowerViewSubtitle.textAlignment = NSTextAlignment.Center
        noFollowerViewSubtitle.numberOfLines = 2
        noFollowerViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noFollowerViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noFollowerView.addSubview(noFollowerViewSubtitle)
        
        self.noFollowerView.hidden = true
        self.followerTableView.addSubview(self.noFollowerView)

        // No following view init and layout
        self.noFollowingView = UIView(frame: self.view.frame)
        self.noFollowingView.center = self.view.center
        self.noFollowingView.backgroundColor = UIColor.whiteColor()
        
        let noFollowingViewTitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowingView.frame.height / 5, self.noFollowingView.frame.width, 32))
        noFollowingViewTitle.text = "Not Following Anyone"
        noFollowingViewTitle.textAlignment = NSTextAlignment.Center
        noFollowingViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noFollowingViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noFollowingView.addSubview(noFollowingViewTitle)
        let noFollowingViewSubtitle = UILabel(frame: CGRectMake(0, 1 * self.noFollowingView.frame.height / 5 + 31, self.noFollowingView.frame.width, 30))
        noFollowingViewSubtitle.text = "tap '+' to add people"
        noFollowingViewSubtitle.textAlignment = NSTextAlignment.Center
        noFollowingViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noFollowingViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noFollowingView.addSubview(noFollowingViewSubtitle)
        self.noFollowingView.hidden = true
        self.followingTableView.addSubview(self.noFollowingView)

        // Load people data from Parse
        self.loadPeople()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentPeopleGallery"{
        }
        else if segue.identifier == "showPersonDetail"{
            let newVC = segue.destinationViewController as! PersonDetailViewController
            newVC.user = self.user
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // followerTableView has two sections, one for follow requests and one for approved followers
        if tableView == self.followerTableView{
            return 2
        }
        // followingTableView has one section
        else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == self.followerTableView{
            if section == 0{
                return self.followingRequestedFrom.count
            }
            else{
                return self.followers.count
            }
        }
        else{
            return self.following.count
        }
    }
    
    // Table view data source methods for followerTableView and followingTableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableView == self.followerTableView{
            // If section is for displaying follower(s)
            if(indexPath.section == 1){
                let cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as! PersonTableViewCell
                var followersUsers:[PFUser] = self.followers
                let user = followersUsers[indexPath.row] as PFUser
                cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as! String]
                cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as! String]!
                cell.userAlias.text = user.username
                let userOrientation = user["sexualOrientation"] as! String
                let userAge = user["age"] as! Int
                cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
                let userCity = user["city"] as! String
                let userState = user["state"] as! String
                cell.userLocation.text = "\(userCity), \(userState)"
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }
            // If section is for displaying follow requests
            else{
                let cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as! PersonFollowTableViewCell
                var followingRequestsFromUsers:[PFUser] = self.followingRequestedFrom as [PFUser]
                let user = followingRequestsFromUsers[indexPath.row] as PFUser
                cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as! String]
                cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as! String]!
                cell.userAlias.text = user.username
                let userOrientation = user["sexualOrientation"] as! String
                let userAge = user["age"] as! Int
                cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
                _ = user["city"] as! String
                _ = user["state"] as! String
                cell.followButton.addTarget(self, action: "acceptButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                cell.followButton.setTitle("Accept", forState: UIControlState.Normal)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
                cell.userAvatar.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }
        }
        // Display following
        else if tableView == self.followingTableView{
            let cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as! PersonTableViewCell
            var followingUsers:[PFUser] = self.following
            let user = followingUsers[indexPath.row] as PFUser
            cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as! String]
            cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as! String]!
            cell.userAlias.text = user.username
            let userOrientation = user["sexualOrientation"] as! String
            let userAge = user["age"] as! Int
            cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
            let userCity = user["city"] as! String
            let userState = user["state"] as! String
            cell.userLocation.text = "\(userCity), \(userState)"
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
            cell.addGestureRecognizer(tapGestureRecognizer)
            return cell
        }
        else{
            return tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as! PersonTableViewCell
        }
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.followerTableView{
            switch section{
            case 0:
                if self.followingRequestedFrom.isEmpty{
                    return nil
                }
                else{
                    return "Follow Requests"
                }
            default:
                if self.followers.isEmpty || self.followingRequestedFrom.isEmpty{
                    return nil
                }
                else{
                    return  "Followers"
                }
            }
        }
        else{
            return nil
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Segue to mentor detail view if Mentor Overlay tapped
    func mentorCellTapped(sender:UIGestureRecognizer){
        self.performSegueWithIdentifier("viewMentor", sender: self)
    }
    
    // Switch between follower and following tables with segmented control value change
    func valueChanged(segment:UISegmentedControl){
        if segment.selectedSegmentIndex == 0{
            self.followerTableView.hidden = false
            self.followingTableView.hidden = true
            if self.followers.count == 0 && self.followingRequestedFrom.count == 0{
                self.noFollowerView.hidden = false
            }
            else{
                self.noFollowerView.hidden = true
            }
        }
        else{
            self.followerTableView.hidden = true
            self.followingTableView.hidden = false
            if self.following.count == 0{
                self.noFollowingView.hidden = false
            }
            else{
                self.noFollowingView.hidden = true
            }

        }
    }
    
    // Add PFUser to list of approved followers if Accept button tapped
    func acceptButtonTapped(sender:UIButton){
        let currentCell = sender.superview?.superview as! PersonFollowTableViewCell
        let currentIndexPath:NSIndexPath = self.followerTableView.indexPathForCell(currentCell)!
        let userToAcceptFollowRequest = self.followingRequestedFrom[currentIndexPath.row] as PFUser
        var currentUserFollowingRequestedFrom = self.followingRequestedFrom
        
        let queryUserFollowRequestedFromFollowerFollowing = PFQuery(className: "FollowerFollowing")
        queryUserFollowRequestedFromFollowerFollowing.whereKey("ownerUser", equalTo:currentUserFollowingRequestedFrom[currentIndexPath.row])
        queryUserFollowRequestedFromFollowerFollowing.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                let userFollowRequestedFrom = (objects as! [PFObject])[0]
                var userFollowRequestedFromCurrentlyfollowing:[PFUser] = userFollowRequestedFrom["followingUsers"] as! [PFUser]
                userFollowRequestedFromCurrentlyfollowing.append(PFUser.currentUser()!)
                userFollowRequestedFrom["followingUsers"] = userFollowRequestedFromCurrentlyfollowing
                userFollowRequestedFrom.saveInBackgroundWithBlock(nil)
                self.followerTableView.reloadData()
                self.followerTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }

        var currentUserFollowers:[PFUser] = self.followerFollowingObject["followers"] as! [PFUser]
        currentUserFollowers.append(userToAcceptFollowRequest)
        currentUserFollowingRequestedFrom.removeAtIndex(currentIndexPath.row)
        self.followerFollowingObject["requestsFromUsers"] = currentUserFollowingRequestedFrom
        self.followerFollowingObject["followers"] = currentUserFollowers
        self.followerFollowingObject.saveInBackgroundWithBlock{(succeeded, error) -> Void in
            if error == nil{
                let followRequestApprovedNotification = PFObject(className: "Notification")
                followRequestApprovedNotification["sender"] = PFUser.currentUser()
                followRequestApprovedNotification["receiver"] = userToAcceptFollowRequest
                followRequestApprovedNotification["read"] = false
                followRequestApprovedNotification["type"] = "followRequestApproved"
                followRequestApprovedNotification.saveInBackgroundWithBlock{(succeeded, error) -> Void in
                    if error == nil{
                        // Send iOS Notification
                        self.loadPeople()
//                        self.followerTableView.reloadRowsAtIndexPaths(self.followerTableView.indexPathsForVisibleRows()!, withRowAnimation: UITableViewRowAnimation.None)
                    }
                }
            }
        }
    }

    // Load people data from Parse
    func loadPeople(){
//        self.followerTableView.hidden = true
        let queryFollowerFollowing = PFQuery(className:"FollowerFollowing")
        queryFollowerFollowing.whereKey("ownerUser", equalTo: PFUser.currentUser()!)
        queryFollowerFollowing.includeKey("followingUsers")
        queryFollowerFollowing.includeKey("followers")
        queryFollowerFollowing.includeKey("requestsFromUsers")
        queryFollowerFollowing.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                self.followerFollowingObject = (objects as! [PFObject])[0]
                self.followingRequestedFrom = self.followerFollowingObject["requestsFromUsers"] as! [PFUser]
                self.following = self.followerFollowingObject["followingUsers"] as! [PFUser]
                self.followers = self.followerFollowingObject["followers"] as! [PFUser]
                if self.following.count == 0{
                    self.noFollowingView.hidden = false
                }
                else{
                    self.noFollowingView.hidden = true
                }
                if self.followers.count == 0 && self.followingRequestedFrom.count == 0{
                    self.noFollowerView.hidden = false
                }
                else{
                    self.noFollowerView.hidden = true
                }

                self.followerTableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 2)), withRowAnimation: UITableViewRowAnimation.None)
                self.followingTableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 1)), withRowAnimation: UITableViewRowAnimation.None)
                self.FollowerTableViewController.refreshControl!.endRefreshing()
                self.FollowingTableViewController.refreshControl!.endRefreshing()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
    }
    
    // Present people gallery if Add button tapped
    func addPeople(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("presentPeopleGallery", sender: self)
    }
    func showPersonDetail(sender:UITapGestureRecognizer){
        if self.segmentedControl.selectedSegmentIndex == 0{
            let currentIndexPath = self.followerTableView.indexPathForRowAtPoint(sender.locationInView(self.followerTableView)) as NSIndexPath!
            if currentIndexPath.section == 1{
                self.user = self.followers[currentIndexPath.row]
            }
            else{
                self.user = self.followingRequestedFrom[currentIndexPath.row]
            }
            self.performSegueWithIdentifier("showPersonDetail", sender: self)
        }
        else{
            let currentIndexPath = self.followingTableView.indexPathForRowAtPoint(sender.locationInView(self.followingTableView)) as NSIndexPath!
            self.user = self.following[currentIndexPath.row]
            self.performSegueWithIdentifier("showPersonDetail", sender: self)


        }
        print("")
    }
    
    func showPeerChat(){
        self.performSegueWithIdentifier("showPeerChat", sender: nil)
    }
}
