//
//  ResourceDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/20/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit
import MapKit
class ResourceDetailViewController: UIViewController {
    
    var mapView:MKMapView!
    var resourceItem:PFObject!
    var currentGeoPoint:PFGeoPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)

        
        
        self.navigationItem.title = self.resourceItem["name"] as? String
        
        var shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareResource")
        self.navigationItem.rightBarButtonItem = shareButton
        
        self.mapView = MKMapView(frame: CGRectZero)
        self.mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mapView.showsUserLocation = true
        self.view.addSubview(self.mapView)

        var resourceItemGeoPoint = self.resourceItem["location"] as! PFGeoPoint
        var mapWidth:CLLocationDistance = 1000
        var mapHeight:CLLocationDistance = 1000
        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: resourceItemGeoPoint.latitude, longitude: resourceItemGeoPoint.longitude), mapWidth, mapHeight), animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(resourceItemGeoPoint.latitude, resourceItemGeoPoint.longitude)
        annotation.title = self.resourceItem["name"] as! String
        annotation.subtitle = self.resourceItem["type"] as! String
        
        
        mapView.addAnnotation(annotation)
//        mapView.selectAnnotation(annotation, animated: true)

        var metricsDictionary = ["sideMargin":7.5]
        var viewsDictionary = ["mapView":self.mapView]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[mapView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var mapViewHorizontalConstraint = NSLayoutConstraint(item: self.mapView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.view.addConstraint(mapViewHorizontalConstraint)
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[mapView(200)]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func shareResource(){
        println("share")
    }

}
