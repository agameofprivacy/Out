//
//  NotificationsViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notifications"
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        var clearAllButton = UIBarButtonItem(title: "Clear All", style: UIBarButtonItemStyle.Plain, target: self, action: "clearAllButtonTapped")
        clearAllButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = clearAllButton
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
    
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func clearAllButtonTapped(){
        println("Cleared!")
    }

}
