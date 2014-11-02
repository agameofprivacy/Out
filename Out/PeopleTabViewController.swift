//
//  PeopleTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var peopleTableView:TPKeyboardAvoidingTableView!
    var mentorCellOverlay:UIView!
    var segmentedControlView:UIView!
    var segmentedControl:UISegmentedControl!
    
    var mentorAvatar:UIImageView!
    var mentorRole:UILabel!
    var mentorAlias:UILabel!
    var mentorOrganization:UILabel!
    var mentorLocation:UILabel!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "People"

        self.peopleTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.peopleTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.peopleTableView.contentInset = UIEdgeInsets(top: 130.0, left: 0, bottom:0, right: 0)
        self.peopleTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.peopleTableView.backgroundColor = UIColor.whiteColor()
        self.peopleTableView.frame = self.view.frame
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 90
        self.peopleTableView.delegate = self
        self.peopleTableView.dataSource = self
        self.view.addSubview(self.peopleTableView)

        
        self.mentorCellOverlay = UIView(frame: CGRectZero)
        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorCellOverlay.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.mentorCellOverlay)
        
        self.mentorAvatar = UIImageView(frame: CGRectZero)
        self.mentorAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAvatar.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
        self.mentorAvatar.layer.cornerRadius = 30
        self.mentorAvatar.clipsToBounds = true
        self.mentorAvatar.image = UIImage(named: "elephant-icon")
        self.mentorCellOverlay.addSubview(self.mentorAvatar)
        
        self.mentorRole = UILabel(frame: CGRectZero)
        self.mentorRole.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorRole.textAlignment = NSTextAlignment.Left
        self.mentorRole.font = titleFont?.fontWithSize(17.0)
        self.mentorRole.preferredMaxLayoutWidth = 50
        self.mentorRole.numberOfLines = 1
        self.mentorRole.text = "mentor"
//        self.mentorRole.textColor = UIColor.whiteColor()
        self.mentorCellOverlay.addSubview(self.mentorRole)

        self.mentorAlias = UILabel(frame: CGRectZero)
        self.mentorAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorAlias.textAlignment = NSTextAlignment.Left
        self.mentorAlias.font = regularFont
        self.mentorAlias.preferredMaxLayoutWidth = 50
        self.mentorAlias.numberOfLines = 1
        self.mentorAlias.text = "eleph34"
//        self.mentorAlias.textColor = UIColor.whiteColor()
        self.mentorCellOverlay.addSubview(self.mentorAlias)
        
        self.mentorOrganization = UILabel(frame: CGRectZero)
        self.mentorOrganization.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorOrganization.textAlignment = NSTextAlignment.Right
        self.mentorOrganization.font = titleFont?.fontWithSize(14.0)
        self.mentorOrganization.preferredMaxLayoutWidth = 200
        self.mentorOrganization.numberOfLines = 1
        self.mentorOrganization.text = "The Trevor Project"
//        self.mentorOrganization.textColor = UIColor.whiteColor()
        self.mentorCellOverlay.addSubview(self.mentorOrganization)
        
        self.mentorLocation = UILabel(frame: CGRectZero)
        self.mentorLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorLocation.textAlignment = NSTextAlignment.Right
        self.mentorLocation.font = valueFont
        self.mentorLocation.preferredMaxLayoutWidth = 200
        self.mentorLocation.numberOfLines = 1
        self.mentorLocation.text = "New York, NY"
//        self.mentorLocation.textColor = UIColor.whiteColor()
        self.mentorCellOverlay.addSubview(self.mentorLocation)
        
        var mentorCellViewsDictionary = ["mentorAvatar":mentorAvatar, "mentorRole":mentorRole, "mentorAlias":mentorAlias, "mentorOrganization":mentorOrganization, "mentorLocation":mentorLocation]
        var mentorCellMetricsDictionary = ["sideMargin":15, "topMargin":64 + 16, "bottomMargin": 18]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mentorAvatar(60)]-20-[mentorRole(60)]-15-[mentorOrganization]-60-|", options: NSLayoutFormatOptions(0), metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[mentorAvatar(60)]-10-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-82-[mentorRole]-3-[mentorAlias]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        var rightVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-85-[mentorOrganization]-4-[mentorLocation]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: mentorCellMetricsDictionary, views: mentorCellViewsDictionary)
        
        self.mentorCellOverlay.addConstraints(topHorizontalConstraints)
        self.mentorCellOverlay.addConstraints(avatarVerticalConstraints)
        self.mentorCellOverlay.addConstraints(leftVerticalConstraints)
        self.mentorCellOverlay.addConstraints(rightVerticalConstraints)
        
        
        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControlView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PersonTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as PersonTableViewCell
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        }
        else{
            cell.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
