//
//  HelpResourcesViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/15/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class HelpResourcesTabViewController: UIViewController {

    var emergencyServiceProviderLabel:UILabel!
    var emergencyActionView:UIView!
    var emergencyCallButton:UIButton!
    var emergencyMessageButton:UIButton!
    
    var resourcesTableView:TPKeyboardAvoidingTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Help"
        // Do any additional setup after loading the view.
        
        self.emergencyServiceProviderLabel = UILabel(frame: CGRectZero)
        self.emergencyServiceProviderLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyServiceProviderLabel.text = "The Trevor Project"
        self.view.addSubview(self.emergencyServiceProviderLabel)
        
        self.emergencyActionView = UIView(frame:CGRectZero)
        self.emergencyActionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyActionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.view.addSubview(self.emergencyActionView)
        
        self.emergencyCallButton = UIButton(frame: CGRectZero)
        self.emergencyCallButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyCallButton.titleLabel?.text = "Call"
        self.emergencyCallButton.titleLabel?.textColor = UIColor.blackColor()
        self.emergencyCallButton.layer.borderWidth = 1
        self.emergencyCallButton.layer.borderColor = UIColor.blackColor().CGColor
        self.emergencyCallButton.layer.cornerRadius = 4
        self.emergencyActionView.addSubview(self.emergencyCallButton)
        
        self.emergencyMessageButton = UIButton(frame: CGRectZero)
        self.emergencyMessageButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.emergencyMessageButton.titleLabel?.text = "Message"
        self.emergencyMessageButton.titleLabel?.textColor = UIColor.blackColor()
        self.emergencyMessageButton.layer.borderWidth = 1
        self.emergencyMessageButton.layer.borderColor = UIColor.blackColor().CGColor
        self.emergencyMessageButton.layer.cornerRadius = 4
        self.emergencyActionView.addSubview(self.emergencyMessageButton)
        
        self.resourcesTableView = TPKeyboardAvoidingTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.resourcesTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.resourcesTableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.view.addSubview(self.resourcesTableView)
        
        var metricsDictionary = ["sideMargin":7.5]
        var viewsDictionary = ["emergencyServiceProviderLabel":self.emergencyServiceProviderLabel, "emergencyActionView":self.emergencyActionView, "emergencyCallButton":self.emergencyCallButton, "emergencyMessageButton":self.emergencyMessageButton, "resourcesTableView":self.resourcesTableView]
        
        var providerLabelCenterXConstraint = NSLayoutConstraint(item: self.emergencyServiceProviderLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.view.addConstraint(providerLabelCenterXConstraint)
        
        var topHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[emergencyServiceProviderLabel]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.view.addConstraints(topHorizontalConstraints)
        
        var buttonsHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[emergencyCallButton(130)]-18-[emergencyMessageButton(130)]->=sideMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        self.emergencyActionView.addConstraints(buttonsHorizontalConstraints)
        
        var buttonsVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[emergencyCallButton(36)]-15-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        self.emergencyActionView.addConstraints(buttonsVerticalConstraints)
        
        var buttonsConstraint = NSLayoutConstraint(item: self.emergencyCallButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.emergencyActionView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.emergencyActionView.addConstraint(buttonsConstraint)
        
        var tableViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[resourcesTableView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var emergencyActionViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[emergencyActionView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-79-[emergencyServiceProviderLabel]-15-[emergencyActionView]-15-[resourcesTableView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)

        self.view.addConstraints(emergencyActionViewHorizontalConstraints)
        self.view.addConstraints(tableViewHorizontalConstraints)
        self.view.addConstraints(verticalConstraints)

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
