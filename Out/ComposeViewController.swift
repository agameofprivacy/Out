//
//  ComposeViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for compose view
class ComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar init and layout
        self.navigationItem.title = "Compose"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        cancelButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let postButton = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.Plain, target: self, action: "postButtonTapped")
        postButton.setTitleTextAttributes(NSDictionary(object: NSFontAttributeName, forKey: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!) as? [String : AnyObject], forState: UIControlState.Normal)
        postButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = postButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismiss modal compose view if Cancel button tapped
    func cancelButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Post composition if Post button tapped
    func postButtonTapped(){
        print("posted!")
    }
}
