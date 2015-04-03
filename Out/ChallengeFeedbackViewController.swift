//
//  ChallengeFeedbackViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeFeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Challenge Reviews"
        // Do any additional setup after loading the view.
        
//        var composeButton = UIBarButtonItem(image: UIImage(named: "compose-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "composeButtonTapped")
//        composeButton.tintColor = UIColor.blackColor()
//        self.navigationItem.rightBarButtonItem = composeButton

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    func composeButtonTapped(){
//        self.performSegueWithIdentifier("showComposeChallengeReview", sender: self)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
