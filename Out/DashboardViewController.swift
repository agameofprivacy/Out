//
//  DashboardViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var scrollView:TPKeyboardAvoidingScrollView!
    
    var myProfileView:UIView!
    var avatarImageView:UIImageView!
    var myProfileLabel:UILabel!
    var currentUserLabel:UILabel!
    
    var myProgressView:UIView!
    var myProgressLabel:UILabel!
    var myProgressPieImageView:UIImageView!
    
    var currentChallengesView:UIView!
    var currentChallengesLabel:UILabel!
    var currentChallengesHeaderSeparator:UIView!
    var currentChallengesPageControl:UIPageControl!
    var currentChallengesCollectionView:UICollectionView!
    
    var whatsNewView:UIView!
    var whatsNewLabel:UILabel!
    var whatsNewHeaderSeparator:UIView!
    var whatsNewPageControl:UIPageControl!
    var whatsNewCollectionView:UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dashboard"

        self.scrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.view = self.scrollView
        
        
        
        currentUserLabel = UILabel(frame: CGRectZero)
        currentUserLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        currentUserLabel.text = PFUser.currentUser().username
        currentUserLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(currentUserLabel)
        
//        var viewsDictionary = ["currentUserLabel":currentUserLabel]
//        var metricsDictionary = ["margin": 20]
//        
//        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-==margin-[currentUserLabel]-==margin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
//        
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=80-[currentUserLabel]->=330-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
//        
//        self.view.addConstraints(horizontalConstraints)
//        self.view.addConstraints(verticalConstraints)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutBarButtonItemTapped(sender: UIBarButtonItem) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        self.performSegueWithIdentifier("LoggedOut", sender: nil)
    }

}
