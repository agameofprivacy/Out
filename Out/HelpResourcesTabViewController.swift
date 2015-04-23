//
//  HelpResourcesViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/15/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit
import MapKit
class HelpResourcesTabViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{


    var relevantOrganizations:[PFObject] = []
    var relevantOrganizationsAttributes:[String:[String]] = NSDictionary() as! [String : [String]]
    var otherOrganizationsNearby:[PFObject] = []
    var emergencyServiceProvider:PFObject!
    var backgroundParameterArray:[String] = ["ethnicity", "religion"]
    var updateLocationRefreshControl:UIRefreshControl!
    
    var mapView:MKMapView!
    var mapWidth:CLLocationDistance = 5000
    var mapHeight:CLLocationDistance = 5000
//    var locationManager:CLLocationManager!
    
    var resourcesTableViewController:UITableViewController = UITableViewController()
    var resourcesTableView:TPKeyboardAvoidingTableView!
    
    var selectedResourceItem:PFObject!
    
    var currentGeoPoint:PFGeoPoint!
    var currentAddressDictionary:[NSObject : AnyObject]!
    
    var mapClusterController:CCHMapClusterController!
    
    var annotations:[MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Resources"
        // Do any additional setup after loading the view.
        
        var searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchResources")
        self.navigationItem.rightBarButtonItem = searchButton
        
        var mapButton = UIBarButtonItem(image: UIImage(named: "mapIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "showOnMap")
        self.navigationItem.leftBarButtonItem = mapButton
        
        self.addChildViewController(self.resourcesTableViewController)

        self.resourcesTableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.resourcesTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.resourcesTableView.delegate = self
        self.resourcesTableView.dataSource = self
        self.resourcesTableView.rowHeight = UITableViewAutomaticDimension
        self.resourcesTableView.registerClass(CrisisHelpTableViewCell.self, forCellReuseIdentifier: "CrisisHelpTableViewCell")
        self.resourcesTableView.registerClass(ResourceTableViewCell.self, forCellReuseIdentifier: "ResourceTableViewCell")
        self.resourcesTableView.registerClass(RelevantResourceTableViewCell.self, forCellReuseIdentifier: "RelevantResourceTableViewCell")
        self.resourcesTableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.resourcesTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.resourcesTableViewController.tableView = self.resourcesTableView
        self.resourcesTableViewController.refreshControl = UIRefreshControl()
        self.resourcesTableViewController.refreshControl!.addTarget(self, action: "updateLocation", forControlEvents: UIControlEvents.ValueChanged)
//        self.resourcesTableViewController.refreshControl?.attributedTitle = nil
        self.view.addSubview(self.resourcesTableView)
        
        var metricsDictionary = ["sideMargin":15, "buttonsSideMargin":(UIScreen.mainScreen().bounds.width - (130 * 2 + 18))/2]
        var viewsDictionary = ["resourcesTableView":self.resourcesTableView]
        
        
        var tableViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[resourcesTableView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[resourcesTableView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)

        self.view.addConstraints(tableViewHorizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        self.mapView = MKMapView(frame: self.view.frame)
        self.mapView.hidden = true
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
//        self.mapClusterController = CCHMapClusterController(mapView: self.mapView)

        
        self.updateLocation()

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 3
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
            var organization = self.relevantOrganizations[indexPath.row]
            var cell = tableView.dequeueReusableCellWithIdentifier("RelevantResourceTableViewCell") as! RelevantResourceTableViewCell
            cell.logoImageView.image = UIImage(named: organization["logoImage"] as! String)
            cell.descriptionLabel.text = organization["description"] as? String
            var keysString:String = "Relevance: "
            var objectId:String = organization.objectId
            for key in (self.relevantOrganizationsAttributes[objectId]! as [String]){
                keysString += (PFUser.currentUser()[key] as? String)! + "  "
            }
            cell.keyLabel.text = keysString
            return cell
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
            return self.relevantOrganizations.count
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
            case 0:
                if self.currentAddressDictionary != nil{
                    titleLabel.text = "CURRENT LOCATION - " + (self.currentAddressDictionary["SubAdministrativeArea"]!.uppercaseString as String)
                }
                else{
                    titleLabel.text = nil
                }
            case tableView.numberOfSections() - 1: titleLabel.text = "OTHER NEARBY RESOURCES"
            default: titleLabel.text = "RELEVANT RESOURCES"
            }
            
            headerView.addSubview(titleLabel)
            
            var metricsDictionary = ["sideMargin":7.5, "barWidth":(UIScreen.mainScreen().bounds.width - 7.5 * 4 - 100)/2]
            var viewsDictionary = ["titleLabel":titleLabel, "separator":separator]
            
            var centerHConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
            headerView.addConstraint(centerHConstraint)
            
//            var centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
//            headerView.addConstraint(centerYConstraint)
            
            var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            headerView.addConstraints(horizontalConstraints)
            var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[titleLabel]-6-[separator(0.75)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            headerView.addConstraints(verticalConstraints)

            return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            if self.currentAddressDictionary != nil{
                return 32
            }
            else{
                return 0
            }
        case 1:
            if self.relevantOrganizations.count > 0{
                return 32
            }
            else{
                return 0
            }
        case 2:
            if self.otherOrganizationsNearby.count > 0{
                return 32
            }
            else{
                return 0
            }
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 310.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            self.selectedResourceItem = self.emergencyServiceProvider
            println("showEmergencyDetail")
        }
        else if indexPath.section == tableView.numberOfSections() - 1{
            self.selectedResourceItem = self.otherOrganizationsNearby[indexPath.row]
            self.performSegueWithIdentifier("showResourceDetail", sender: self)
        }
        else{
            self.selectedResourceItem = self.relevantOrganizations[indexPath.row]
            self.performSegueWithIdentifier("showResourceDetail", sender: self)
        }
    }
    
    
    func searchResources(){
        println("search resources!")
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
        self.mapView.hidden = !self.mapView.hidden
        if self.mapView.hidden{
            self.navigationItem.leftBarButtonItem?.image = UIImage(named:"mapIcon")
        }
        else{
            self.navigationItem.leftBarButtonItem?.image = UIImage(named:"mapIconSelected")
        }
    }


    func updateLocation(){
        self.resourcesTableViewController.refreshControl!.beginRefreshing()
//        self.resourcesTableViewController.refreshControl?.attributedTitle = NSAttributedString(string: "updating location")
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil {
                self.currentGeoPoint = geoPoint
                self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: self.currentGeoPoint.latitude, longitude: self.currentGeoPoint.longitude), self.mapWidth, self.mapHeight), animated: false)

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
                            var annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2DMake((self.emergencyServiceProvider["location"] as! PFGeoPoint).latitude, (self.emergencyServiceProvider["location"] as! PFGeoPoint).longitude)
                            annotation.title = self.emergencyServiceProvider["name"] as! String
                            annotation.subtitle = self.emergencyServiceProvider["streetAddress"] as! String
                            self.annotations.append(annotation)
                        }
                        var query = PFQuery(className: "Organization")
                        query.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 10.0)
                        query.whereKey("type", equalTo: "community")
                        query.orderByAscending("location")
                        query.findObjectsInBackgroundWithBlock{
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            if error == nil{
                                self.relevantOrganizations.removeAll(keepCapacity: false)
                                self.relevantOrganizationsAttributes.removeAll(keepCapacity: false)
                                self.otherOrganizationsNearby.removeAll(keepCapacity: false)
                                // process objects to store in order of weight and associate parameters contributing to weight with object
                                for object in objects{
                                    var weight = 0
                                    var relevance:[String] = []
                                    for parameter in self.backgroundParameterArray{
                                        if contains(object["tags"] as! [String], PFUser.currentUser()[parameter] as! String){
                                            ++weight
                                            relevance.append(parameter)
                                        }
                                    }
//                                    println(weight)
                                    if weight == 0{
                                        self.otherOrganizationsNearby.append(object as! PFObject)
                                    }
                                    else{
                                        self.relevantOrganizations.append(object as! PFObject)
                                        self.relevantOrganizationsAttributes.updateValue(relevance, forKey: (object as! PFObject).objectId)
                                    }
                                    var annotation = MKPointAnnotation()
                                    annotation.coordinate = CLLocationCoordinate2DMake((object["location"] as! PFGeoPoint).latitude, (object["location"] as! PFGeoPoint).longitude)
                                    annotation.title = object["name"] as! String
                                    annotation.subtitle = object["streetAddress"] as! String
                                    self.annotations.append(annotation)
                                }
                                self.mapView.addAnnotations(self.annotations)
//                                self.mapClusterController.addAnnotations(self.annotations, withCompletionHandler: nil)
//                                println(self.annotations.last?.description)
//                                self.mapClusterController.selectAnnotation(self.annotations.last, andZoomToRegionWithLatitudinalMeters: 500, longitudinalMeters: 500)
                                CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: self.currentGeoPoint.latitude, longitude: self.currentGeoPoint.longitude), completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil) {println("reverse geodcode fail: \(error.localizedDescription)")}
                                        else{
                                            let pm = placemarks as! [CLPlacemark]
                                            var placemark:CLPlacemark = pm[0]
                                            self.currentAddressDictionary = placemark.addressDictionary
                                            self.resourcesTableViewController.refreshControl!.endRefreshing()
                                            self.resourcesTableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 3)), withRowAnimation: UITableViewRowAnimation.None)
                                        }
                                })
                            }
                            else{
                                println("second failure")
                            }
                        }
                        
                    }
                    else{
                                println("first failure")
                    }
                }
            }
            else{
                println("can't find location")
//                self.resourcesTableViewController.refreshControl!.endRefreshing()
            }
        }

    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var latitude = view.annotation.coordinate.latitude
        var longitude = view.annotation.coordinate.longitude
        var resourceQuery = PFQuery(className: "Organization")
        resourceQuery.whereKey("location", equalTo: PFGeoPoint(latitude: latitude, longitude: longitude))
        resourceQuery.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if (error==nil){
                self.selectedResourceItem = objects[0] as! PFObject
                self.performSegueWithIdentifier("showResourceDetail", sender: self)
            }
            else{
                println("organization lookup failed")
            }
        }

    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        else{
            var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
            pinView.animatesDrop = true
            pinView.pinColor = MKPinAnnotationColor.Red
            pinView.enabled = true
            pinView.canShowCallout = true
            
            pinView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
            return pinView
        }
    }
    
}
