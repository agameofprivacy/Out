//
//  PersonDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/11/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: PFUser!
    var tableView: TPKeyboardAvoidingTableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.user.username
        self.tableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.registerClass(PersonDetailTableViewCell.self, forCellReuseIdentifier: "PersonDetailTableViewCell")

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
        self.view.addSubview(self.tableView)
        
        var viewsDictionary = ["tableView":self.tableView]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)

        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return 30
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            var cell = tableView.dequeueReusableCellWithIdentifier("PersonDetailTableViewCell") as! PersonDetailTableViewCell
            return cell
        }
        else{
            var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            var segmentedControlView = UIView()
            segmentedControlView.backgroundColor = UIColor.whiteColor()
            
            var segmentedControl = UISegmentedControl(items: ["About","Activities", "More"])
            segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
            segmentedControl.tintColor = UIColor.blackColor()
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControlView.addSubview(segmentedControl)
            
            var segmentedControlViewSeparator = UIView(frame: CGRectZero)
            segmentedControlViewSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
            segmentedControlViewSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            segmentedControlView.addSubview(segmentedControlViewSeparator)
            
            var metricsDictionary = ["sideMargin":7.5]
            var viewsDictionary = ["segmentedControl":segmentedControl, "segmentedControlViewSeparator":segmentedControlViewSeparator]
            
            var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl(28)]-8-[segmentedControlViewSeparator(0.5)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[segmentedControl]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            var separatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentedControlViewSeparator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

            segmentedControlView.addConstraints(verticalConstraints)
            segmentedControlView.addConstraints(horizontalConstraints)
            segmentedControlView.addConstraints(separatorHorizontalConstraints)
            
            return segmentedControlView
        }
        else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 44.5
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            return 150
        }
        else{
            return 64
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func valueChanged(segment:UISegmentedControl){
        switch segment.selectedSegmentIndex{
        case 0:
            println("About")
        case 1:
            println("Activities")
        default:
            println("More")
        }
    }


}
