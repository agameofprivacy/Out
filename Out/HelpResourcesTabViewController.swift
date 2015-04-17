//
//  HelpResourcesViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/15/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class HelpResourcesTabViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    var emergencyServiceProviderTitleLabel:UILabel!
    var emergencyServiceProviderDescriptionLabel:UILabel!
    var emergencyActionView:UIView!
    var emergencyCallButton:UIButton!
    var emergencyMessageButton:UIButton!
    var organizations:[PFObject] = []
    var emergencyServiceProvider:PFObject!
//    var locationManager:CLLocationManager!
    
    var resourcesTableView:TPKeyboardAvoidingTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Help"
        // Do any additional setup after loading the view.
        
//        self.locationManager = CLLocationManager()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        self.emergencyServiceProviderTitleLabel = UILabel(frame: CGRectZero)
        self.emergencyServiceProviderTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyServiceProviderTitleLabel.text = "The Trevor Project"
        self.emergencyServiceProviderTitleLabel.numberOfLines = 0
        self.view.addSubview(self.emergencyServiceProviderTitleLabel)
        
        self.emergencyServiceProviderDescriptionLabel = UILabel(frame: CGRectZero)
        self.emergencyServiceProviderDescriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyServiceProviderDescriptionLabel.text = "Trevor Lifeline is a crisis hotline offered by The Trevor Project that lets lesbian, gay, bisexual, transgender, and questioning youth talk to trained volunteers when they’re in need."
        self.emergencyServiceProviderDescriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13.0)
        self.emergencyServiceProviderDescriptionLabel.numberOfLines = 0
        self.view.addSubview(self.emergencyServiceProviderDescriptionLabel)

        
        
        self.emergencyActionView = UIView(frame:CGRectZero)
        self.emergencyActionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyActionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.view.addSubview(self.emergencyActionView)
        
        self.emergencyCallButton = UIButton(frame: CGRectZero)
        self.emergencyCallButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyCallButton.setTitle("Call", forState: UIControlState.Normal)
        self.emergencyCallButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        self.emergencyCallButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.emergencyCallButton.layer.borderWidth = 1
        self.emergencyCallButton.layer.borderColor = UIColor.blackColor().CGColor
        self.emergencyCallButton.layer.cornerRadius = 8
        self.emergencyActionView.addSubview(self.emergencyCallButton)
        
        self.emergencyMessageButton = UIButton(frame: CGRectZero)
        self.emergencyMessageButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyMessageButton.setTitle("Message", forState: UIControlState.Normal)
        self.emergencyMessageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.emergencyMessageButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        self.emergencyMessageButton.layer.borderWidth = 1
        self.emergencyMessageButton.layer.borderColor = UIColor.blackColor().CGColor
        self.emergencyMessageButton.layer.cornerRadius = 8
        self.emergencyActionView.addSubview(self.emergencyMessageButton)
        
        self.resourcesTableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.resourcesTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.resourcesTableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.resourcesTableView.delegate = self
        self.resourcesTableView.dataSource = self
        self.resourcesTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.resourcesTableView)
        
        var metricsDictionary = ["sideMargin":15, "buttonsSideMargin":(UIScreen.mainScreen().bounds.width - (130 * 2 + 18))/2]
        var viewsDictionary = ["emergencyServiceProviderTitleLabel":self.emergencyServiceProviderTitleLabel, "emergencyServiceProviderDescriptionLabel":self.emergencyServiceProviderDescriptionLabel, "emergencyActionView":self.emergencyActionView, "emergencyCallButton":self.emergencyCallButton, "emergencyMessageButton":self.emergencyMessageButton, "resourcesTableView":self.resourcesTableView]
        
        var providerLabelCenterXConstraint = NSLayoutConstraint(item: self.emergencyServiceProviderTitleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.view.addConstraint(providerLabelCenterXConstraint)
        
        var topHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[emergencyServiceProviderTitleLabel]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.view.addConstraints(topHorizontalConstraints)
        
        var secondHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[emergencyServiceProviderDescriptionLabel]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.view.addConstraints(secondHorizontalConstraints)
        
        var buttonsHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-buttonsSideMargin-[emergencyCallButton(130)]-18-[emergencyMessageButton(130)]-buttonsSideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.emergencyActionView.addConstraints(buttonsHorizontalConstraints)
        
        var callButtonVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[emergencyCallButton(36)]-15-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.emergencyActionView.addConstraints(callButtonVerticalConstraints)

        var messageButtonVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[emergencyMessageButton(36)]-15-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.emergencyActionView.addConstraints(messageButtonVerticalConstraints)

//        var buttonsConstraint = NSLayoutConstraint(item: self.emergencyCallButton, attribute: NSLayoutAttribute., relatedBy: NSLayoutRelation.Equal, toItem: self.emergencyMessageButton, attribute: NSLayoutAttribute.CenterXWithinMargins, multiplier: 1.0, constant: 0)
//        self.emergencyActionView.addConstraint(buttonsConstraint)
        
        var tableViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[resourcesTableView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var emergencyActionViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[emergencyActionView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-84-[emergencyServiceProviderTitleLabel]-4-[emergencyServiceProviderDescriptionLabel]-15-[emergencyActionView]-15-[resourcesTableView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)

        self.view.addConstraints(emergencyActionViewHorizontalConstraints)
        self.view.addConstraints(tableViewHorizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil {
                // do something with the new geoPoint
                println(geoPoint.description)
                var emergencyServiceProviderQuery = PFQuery(className: "Organization")
                emergencyServiceProviderQuery.whereKey("city", equalTo: PFUser.currentUser()["city"])
                emergencyServiceProviderQuery.whereKey("state", equalTo: PFUser.currentUser()["state"])
                emergencyServiceProviderQuery.whereKey("type", equalTo: "crisis-handling")
                emergencyServiceProviderQuery.limit = 1
                emergencyServiceProviderQuery.findObjectsInBackgroundWithBlock{
                    (objects:[AnyObject]!, error:NSError!) -> Void in
                    if error == nil{
                        if objects.count > 0{
                            self.emergencyServiceProvider = objects[0] as! PFObject
                            self.emergencyServiceProviderDescriptionLabel.text = self.emergencyServiceProvider["description"] as? String
                            self.emergencyServiceProviderTitleLabel.text = self.emergencyServiceProvider["name"] as? String
                            println(self.emergencyServiceProvider.description)
                        }
                        var query = PFQuery(className: "Organization")
                        query.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 2.5)
                        query.whereKey("type", equalTo: "community")
                        query.orderByAscending("location")
                        query.findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil{
                                self.organizations = objects as! [PFObject]
                                self.resourcesTableView.reloadData()
                            }
                            else{
                                
                            }
                        }

                    }
                    else{
                    
                    }
                }
            }
        }

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var organization = self.organizations[indexPath.row]
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
        cell.textLabel?.text = organization["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizations.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
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
