//
//  MyProfileViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

}
