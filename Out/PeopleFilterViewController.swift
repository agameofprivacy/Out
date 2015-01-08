//
//  PeopleFilterViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleFilterViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var placeholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar init and layout
        self.navigationItem.title = "Filter"
        
        var closeButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        var applyButton = UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: "applyButtonTapped:")
        applyButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = applyButton

        self.containerScrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(containerScrollView)
        self.placeholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 1225))
        self.placeholderImageView.image = UIImage(named: "people_filter_placeholder")
        self.containerScrollView.contentSize = CGSize(width: 375, height: 1225)
        self.containerScrollView.addSubview(self.placeholderImageView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismiss people filter view if Close button tapped
    func closeButtonTapped(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Apply people filter if Apply button tapped
    func applyButtonTapped(sender: UIBarButtonItem){
        println("apply!")
    }

}
