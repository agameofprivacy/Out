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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "People"

        self.peopleTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.peopleTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.peopleTableView.contentInset = UIEdgeInsets(top: 144.0, left: 0, bottom:0, right: 0)
        self.peopleTableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.peopleTableView.backgroundColor = UIColor.whiteColor()
        self.peopleTableView.frame = self.view.frame
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 90
        self.peopleTableView.delegate = self
        self.peopleTableView.dataSource = self
        self.view.addSubview(self.peopleTableView)
        println(self.peopleTableView.frame)
        
        self.mentorCellOverlay = UIView(frame: CGRectZero)
        self.mentorCellOverlay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mentorCellOverlay.backgroundColor = UIColor.whiteColor()
        
        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControlView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
        self.segmentedControl = UISegmentedControl(items: ["Following","Followers"])
        self.segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControl.tintColor = UIColor.blackColor()
        self.segmentedControl.selectedSegmentIndex = 0
        
        self.view.addSubview(self.mentorCellOverlay)
        self.view.addSubview(self.segmentedControlView)
        self.segmentedControlView.addSubview(self.segmentedControl)
        
        var viewsDictionary = ["mentorCellOverlay":mentorCellOverlay, "segmentedControlView":segmentedControlView]
        var metricsDiciontary = ["margin":0]
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[mentorCellOverlay(164)]-0-[segmentedControlView(44)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDiciontary, views: viewsDictionary)
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[mentorCellOverlay]-margin-|", options: NSLayoutFormatOptions(0), metrics: metricsDiciontary, views: viewsDictionary)
        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(horizontalConstraints)
        
        var segmentsViewsDictionary = ["segmentedControl":segmentedControl]
        var segmentsMetricsDictionary = ["margin":12]
        
        var segmentsHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[segmentedControl]-margin-|", options: NSLayoutFormatOptions(0), metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        var segmentsVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl]-8-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: segmentsMetricsDictionary, views: segmentsViewsDictionary)
        
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
