//
//  MyProfileViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for profile view
class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // UINavigationBar init
        self.navigationItem.title = "Profile"

        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Dismiss modal profile view if Close button tapped
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
