//
//  ActivityDetailViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/12/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    var parentVC:ActivityTabViewController!
    
    var activityCardView:UIView!
    var activityHeroImageView:UIImageView!
    var activityTitle:UILabel!
    var activityAlias:UILabel!
    var activityAvatar:UIImageView!
    
    var activityCommentsTableView:SLKTextViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.parentVC)
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

}
