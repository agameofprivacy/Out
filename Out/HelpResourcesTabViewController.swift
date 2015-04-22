//
//  HelpResourcesViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/15/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class HelpResourcesTabViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {


    var organizations:[String:[PFObject]] = NSDictionary() as! [String:[PFObject]]
    var otherOrganizationsNearby:[PFObject] = []
    var organizationsArrayKey:[String] = []
    var emergencyServiceProvider:PFObject!
    var backgroundParameterArray:[String] = ["ethnicity", "religion"]
//    var locationManager:CLLocationManager!
    
    var resourcesTableView:TPKeyboardAvoidingTableView!
    
    var selectedResourceItem:PFObject!
    
    var currentGeoPoint:PFGeoPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Resources"
        // Do any additional setup after loading the view.
        
        var searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "updateLocation")
        self.navigationItem.rightBarButtonItem = searchButton
        
        var mapButton = UIBarButtonItem(image: UIImage(named: "mapIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "showOnMap")
        self.navigationItem.leftBarButtonItem = mapButton
        
        
        self.resourcesTableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.resourcesTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.resourcesTableView.delegate = self
        self.resourcesTableView.dataSource = self
        self.resourcesTableView.rowHeight = UITableViewAutomaticDimension
        self.resourcesTableView.registerClass(CrisisHelpTableViewCell.self, forCellReuseIdentifier: "CrisisHelpTableViewCell")
        self.resourcesTableView.registerClass(ResourceTableViewCell.self, forCellReuseIdentifier: "ResourceTableViewCell")
        self.resourcesTableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.resourcesTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.resourcesTableView)
        
        var metricsDictionary = ["sideMargin":15, "buttonsSideMargin":(UIScreen.mainScreen().bounds.width - (130 * 2 + 18))/2]
        var viewsDictionary = ["resourcesTableView":self.resourcesTableView]
        
        
        var tableViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[resourcesTableView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[resourcesTableView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)

        self.view.addConstraints(tableViewHorizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        self.updateLocation()

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1 + self.organizationsArrayKey.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("CrisisHelpTableViewCell") as! CrisisHelpTableViewCell
            cell.logoImageView.image = UIImage(named: self.emergencyServiceProvider["logoImage"] as! String)
            cell.descriptionLabel.text = self.emergencyServiceProvider["description"] as? String
            var callButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "call")
            cell.callButton.addGestureRecognizer(callButtonTapGestureRecognizer)
            return cell
        }
        else if indexPath.section == tableView.numberOfSections() - 1{
            var organization = self.otherOrganizationsNearby[indexPath.row]
            var cell = tableView.dequeueReusableCellWithIdentifier("ResourceTableViewCell") as! ResourceTableViewCell
            cell.logoImageView.image = UIImage(named: organization["logoImage"] as! String)
            cell.descriptionLabel.text = organization["description"] as? String
            return cell
        }
        else{
            var key = self.organizationsArrayKey[indexPath.section - 1]
            var organization = (self.organizations[key] as [PFObject]!)[indexPath.row]
            var cell = tableView.dequeueReusableCellWithIdentifier("ResourceTableViewCell") as! ResourceTableViewCell
            cell.logoImageView.image = UIImage(named: organization["logoImage"] as! String)
            cell.descriptionLabel.text = organization["description"] as? String
            return cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: return nil
        case 1: return "Relevant Resources"
        case 2: return "Other Resources"
        default: return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.emergencyServiceProvider != nil{
                return 1
            }
            else{
                return 0
            }
        }
        else if section == tableView.numberOfSections() - 1{
            return self.otherOrganizationsNearby.count
        }
        else{
            var key = self.organizationsArrayKey[section - 1]
            return (self.organizations[key] as [PFObject]!).count
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 || section == 2{
            var headerView = UIView()
            headerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
            var separator = UIView(frame: CGRectZero)
            separator.setTranslatesAutoresizingMaskIntoConstraints(false)
            separator.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
            headerView.addSubview(separator)
            var titleLabel = UILabel(frame: CGRectZero)
            titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 13.0)
            switch section{
            case 0: titleLabel.text = nil
            case 1: titleLabel.text = "RELEVANT RESOURCES"
            case 2: titleLabel.text = "OTHER RESOURCES"
            default: return nil
            }
            
            headerView.addSubview(titleLabel)
            
            var metricsDictionary = ["sideMargin":7.5, "barWidth":(UIScreen.mainScreen().bounds.width - 7.5 * 4 - 100)/2]
            var viewsDictionary = ["titleLabel":titleLabel, "separator":separator]
            
            var centerHConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
            headerView.addConstraint(centerHConstraint)
            
            var centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
            headerView.addConstraint(centerYConstraint)
            
            var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            headerView.addConstraints(horizontalConstraints)
            var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[titleLabel]-6-[separator(0.75)]-6-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            headerView.addConstraints(verticalConstraints)

            return headerView
        }
        else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0: return 0
        case 1: return 38
        case 2: return 38
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == tableView.numberOfSections() - 1{
            self.selectedResourceItem = self.otherOrganizationsNearby[indexPath.row]
            self.performSegueWithIdentifier("showResourceDetail", sender: self)
        }
        else if indexPath.section != 0 {
            var key = self.organizationsArrayKey[indexPath.section - 1]
            self.selectedResourceItem = (self.organizations[key] as [PFObject]!)[indexPath.row]
            self.performSegueWithIdentifier("showResourceDetail", sender: self)
        }
        else if indexPath.section == 0{
            self.selectedResourceItem = self.emergencyServiceProvider
            println("showEmergencyDetail")
        }
    }
    
    
    func call(){
        var phoneNumber = self.emergencyServiceProvider["phoneNumber"] as! String
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(phoneNumber)")!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResourceDetail"{
            var newVC = segue.destinationViewController as! ResourceDetailViewController
            newVC.resourceItem = self.selectedResourceItem
            newVC.currentGeoPoint = self.currentGeoPoint
        }
        
    }
    
    func showOnMap(){
        println("show on map")
    }


    func updateLocation(){
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil {
                self.currentGeoPoint = geoPoint
                // do something with the new geoPoint
                var emergencyServiceProviderQuery = PFQuery(className: "Organization")
                //                emergencyServiceProviderQuery.whereKey("city", equalTo: PFUser.currentUser()["city"])
                //                emergencyServiceProviderQuery.whereKey("state", equalTo: PFUser.currentUser()["state"])
                emergencyServiceProviderQuery.whereKey("type", equalTo: "crisis-handling")
                emergencyServiceProviderQuery.limit = 1
                emergencyServiceProviderQuery.findObjectsInBackgroundWithBlock{
                    (objects:[AnyObject]!, error:NSError!) -> Void in
                    if error == nil{
                        if objects.count > 0{
                            self.emergencyServiceProvider = objects[0] as! PFObject
                            //                            self.emergencyServiceProviderDescriptionLabel.text = self.emergencyServiceProvider["description"] as? String
                            //                            self.emergencyServiceProviderTitleLabel.text = self.emergencyServiceProvider["name"] as? String
                        }
                        var query = PFQuery(className: "Organization")
                        query.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 10.0)
                        query.whereKey("type", equalTo: "community")
                        query.orderByAscending("location")
                        query.findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil{
                                self.organizations.removeAll(keepCapacity: false)
                                self.organizationsArrayKey.removeAll(keepCapacity: false)
                                self.otherOrganizationsNearby.removeAll(keepCapacity: false)
                                for object in objects{
                                    var weight = 0
                                    for parameter in self.backgroundParameterArray{
                                        if contains(object["tags"] as! [String], PFUser.currentUser()[parameter] as! String){
                                            ++weight
                                            var currentValue:[PFObject] = []
                                            if !contains(self.organizationsArrayKey, parameter){
                                                self.organizationsArrayKey.append(parameter)
                                            }
                                            else{
                                                currentValue = self.organizations[parameter] as [PFObject]!
                                            }
                                            currentValue.append(object as! PFObject)
                                            self.organizations.updateValue(currentValue, forKey: parameter)
                                        }
                                    }
                                    println(weight)
                                    if weight == 0{
                                        self.otherOrganizationsNearby.append(object as! PFObject)
                                    }
                                    
                                }
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
}
