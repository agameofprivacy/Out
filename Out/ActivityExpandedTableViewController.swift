//
//  ActivityExpandedTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 3/25/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ActivityExpandedTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var parentVC:ActivityTabViewController!
    var activity:PFObject!
    var challenge:PFObject!
    var userChallengeData:PFObject!
    var user:PFUser!
    var challengeTrackNumber:Int!
    var comments:[PFObject] = []
    var selectedSegment:String!
    
    var expandedViewSegmentedControl:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Activity"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0{
            return 1
        }
        else{
            return 30
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return nil
        }
        else{
            var segmentedControlView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 44))
            segmentedControlView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            self.expandedViewSegmentedControl = UISegmentedControl(items: ["About","Comments","More"])
            self.expandedViewSegmentedControl.frame = CGRectMake(7.5, 8.0, UIScreen.mainScreen().bounds.width - 15, 28)
            self.expandedViewSegmentedControl.tintColor = UIColor.blackColor()
            self.expandedViewSegmentedControl.selectedSegmentIndex = 0
            self.expandedViewSegmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControlView.addSubview(self.expandedViewSegmentedControl)
            return segmentedControlView
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 44
        }
        else if section == 0{
            return 0
        }
        else{
            return 20
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            return 250
        }
        else {
            return 44
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "uitableviewcell")
        // Configure the cell...

        return cell
    }

    func valueChanged(segment:UISegmentedControl){
        println("changed!")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
