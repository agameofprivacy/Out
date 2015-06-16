//
//  ResourceDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/20/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit
import MapKit
import TPKeyboardAvoiding
import Parse
class ResourceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var tableView: TPKeyboardAvoidingTableView!
    var aboutArray:[[String]] = []
    var events:[PFObject] = []
    
    var resourceItem:PFObject!
    var currentGeoPoint:PFGeoPoint!

    
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
        self.navigationItem.title = self.resourceItem["name"] as? String
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareResource")
        self.navigationItem.rightBarButtonItem = shareButton

        
        self.tableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.registerClass(ResourceDetailTableViewCell.self, forCellReuseIdentifier: "ResourceDetailTableViewCell")
        self.tableView.registerClass(EventTableViewCell.self, forCellReuseIdentifier: "EventTableViewCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView)
        
        let viewsDictionary = ["tableView":self.tableView]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)

        let type = self.resourceItem["type"] as! String
        let scale = self.resourceItem["scale"] as! String
        let tags = self.resourceItem["tags"] as! [String]
        let phoneNumber = self.resourceItem["phoneNumber"] as! String
        let email = self.resourceItem["email"] as! String
        let streetAddress = self.resourceItem["streetAddress"] as! String
        let city = self.resourceItem["city"] as! String
        let state = self.resourceItem["state"] as! String
        
        self.aboutArray.append(["Type", type])
        self.aboutArray.append(["Scale", scale])
        self.aboutArray.append(["Tags", "\(tags)"])
        self.aboutArray.append(["Phone", phoneNumber])
        self.aboutArray.append(["Email", email])
        self.aboutArray.append(["Address", streetAddress])
        self.aboutArray.append(["City", city])
        self.aboutArray.append(["State", state])
        
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
            let numberOfRows = self.aboutArray.count + self.events.count + 2
            return numberOfRows
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            let type = self.resourceItem["type"] as! String
            let basicStatsString = type + " · " + (self.resourceItem["scale"] as! String)
            //            var advanceStatsString = (self.user["ethnicity"] as! String) + " · " + (self.user["religion"] as! String) + " · " + (self.user["city"] as! String) + " " + (self.user["state"] as! String)
            
            let advanceStatsString = self.resourceItem["description"] as! String
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ResourceDetailTableViewCell") as! ResourceDetailTableViewCell
            
            
            
            cell.basicsLabel.text = basicStatsString
            cell.aboutTextView.text = advanceStatsString
            cell.logoBannerImageView.image = UIImage(named: self.resourceItem["logoImage"] as! String)
            return cell
        }
        else if indexPath.section == 1{
            if indexPath.row < self.aboutArray.count{
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Value1")
                cell.textLabel!.text = self.aboutArray[indexPath.row][0]
                cell.detailTextLabel!.text = self.aboutArray[indexPath.row][1]
                return cell
            }
            else if indexPath.row < self.aboutArray.count + self.events.count && self.events.count > 0{
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Value1")
                cell.textLabel!.text = "Event"
                cell.detailTextLabel!.text = "Event Value"
                return cell

            }
            else{
                let name = self.resourceItem["name"] as! String
                let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
                if indexPath.row == self.tableView.numberOfRowsInSection(1) - 2{
                    cell.textLabel!.text = "Activities"
                    cell.detailTextLabel!.text = "View activities related to \(name)"
                }
                else{
                    cell.textLabel!.text = "Report"
                    cell.detailTextLabel!.text = "Report \(name)"
                }
                return cell
            }
        }
        else{
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Subtitle")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let segmentedControlView = UIView()
            segmentedControlView.backgroundColor = UIColor.whiteColor()
            
            let segmentedControl = UISegmentedControl(items: ["About","Events", "More"])
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.tintColor = UIColor.blackColor()
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControlView.addSubview(segmentedControl)
            
            let segmentedControlViewSeparator = UIView(frame: CGRectZero)
            segmentedControlViewSeparator.translatesAutoresizingMaskIntoConstraints = false
            segmentedControlViewSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            segmentedControlView.addSubview(segmentedControlViewSeparator)
            
            let metricsDictionary = ["sideMargin":7.5]
            let viewsDictionary = ["segmentedControl":segmentedControl, "segmentedControlViewSeparator":segmentedControlViewSeparator]
            
            let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[segmentedControl(28)]-8-[segmentedControlViewSeparator(0.5)]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
            let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[segmentedControl]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
            let separatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentedControlViewSeparator]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
            
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
            return UITableViewAutomaticDimension
        }
    }
    
    func valueChanged(segment:UISegmentedControl){
        switch segment.selectedSegmentIndex{
        case 0:
            print("About")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        case 1:
            print("Activities")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.aboutArray.count, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        default:
            print("More")
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.tableView.numberOfRowsInSection(1) - 1, inSection: 1), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
    }

    //
//    var scrollView:TPKeyboardAvoidingScrollView!
//    var logoImageView:UIImageView!
//    var mapView:MKMapView!
//    var resourceItem:PFObject!
//    var currentGeoPoint:PFGeoPoint!
//    var tableView:TPKeyboardAvoidingTableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
//        
//        self.navigationItem.title = self.resourceItem["name"] as? String
//        
//        var shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareResource")
//        self.navigationItem.rightBarButtonItem = shareButton
//        
//        self.scrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
//        self.scrollView.backgroundColor = UIColor.whiteColor()
//        self.scrollView.alwaysBounceVertical = true
//        self.view.addSubview(self.scrollView)
//        
//        self.logoImageView = UIImageView(frame: CGRectZero)
//        self.logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.logoImageView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.logoImageView.image = UIImage(named: self.resourceItem["logoImage"] as! String)
//        self.logoImageView.opaque = true
//        self.scrollView.addSubview(self.logoImageView)
//        
//        self.mapView = MKMapView(frame: CGRectZero)
//        self.mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.mapView.showsUserLocation = true
////        self.mapView.scrollEnabled = false
////        self.mapView.zoomEnabled = false
////        var mapTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewMap")
////        self.mapView.addGestureRecognizer(mapTapGestureRecognizer)
//        self.scrollView.addSubview(self.mapView)
//
//        self.tableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
//        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.tableView.backgroundColor = UIColor(white: 0.85, alpha: 1)
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.scrollView.addSubview(self.tableView)
//        
//        var resourceItemGeoPoint = self.resourceItem["location"] as! PFGeoPoint
//        var mapWidth:CLLocationDistance = 200
//        var mapHeight:CLLocationDistance = 200
//        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: resourceItemGeoPoint.latitude, longitude: resourceItemGeoPoint.longitude), mapWidth, mapHeight), animated: false)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2DMake(resourceItemGeoPoint.latitude, resourceItemGeoPoint.longitude)
//        annotation.title = self.resourceItem["name"] as! String
//        annotation.subtitle = self.resourceItem["type"] as! String
//        
//        
//        mapView.addAnnotation(annotation)
////        mapView.selectAnnotation(annotation, animated: true)
//
//        var metricsDictionary = ["sideMargin":7.5]
//        var viewsDictionary = ["mapView":self.mapView, "logoImageView":self.logoImageView, "tableView":self.tableView]
//        
//        
//        var logoViewHorizontalConstraint = NSLayoutConstraint(item: self.logoImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
//        self.scrollView.addConstraint(logoViewHorizontalConstraint)
//        
//        var mapHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[mapView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
//
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[logoImageView]-30-[mapView(200)][tableView(300)]|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
//        
//        self.scrollView.addConstraints(mapHorizontalConstraints)
//        self.scrollView.addConstraints(verticalConstraints)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "value1")
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
    
    
    func shareResource(){
        print("share")
    }

    func viewMap(){
        print("view map")
    }
    
}
