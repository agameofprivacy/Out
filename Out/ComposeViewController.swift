//
//  ComposeViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Compose"
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        cancelButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = cancelButton
        var postButton = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.Plain, target: self, action: "postButtonTapped")
        postButton.setTitleTextAttributes(NSDictionary(objectsAndKeys: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!, NSFontAttributeName), forState: UIControlState.Normal)
        postButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = postButton

        // Do any additional setup after loading the view.
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

    func cancelButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postButtonTapped(){
        println("posted!")
    }
}
