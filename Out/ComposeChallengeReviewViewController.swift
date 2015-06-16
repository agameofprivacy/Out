//
//  ComposeChallengeReviewViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/3/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ComposeChallengeReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let submitButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitReview")
        submitButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = submitButton
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelReview")
        cancelButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = cancelButton

        self.navigationItem.title = "Review"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitReview(){
        print("Review Submitted")
    }
    
    func cancelReview(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
