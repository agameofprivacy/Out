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
    
    var profileProgressView:UIView!
    
    var myProfileView:UIView!
    var avatarImageView:UIImageView!
    var myProfileLabel:UILabel!
    var currentUserLabel:UILabel!
    
    var profileProgressSeparator:UIView!
    
    var myProgressView:UIView!
    var myProgressLabel:UILabel!
    var myProgressPieChart:PNPieChart!
    
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

    let colorDictionary =
    [
        "orange":UIColor(red: 255/255, green: 97/255, blue: 27/255, alpha: 1),
        "brown":UIColor(red: 139/255, green: 87/255, blue: 42/255, alpha: 1),
        "teal":UIColor(red: 34/255, green: 200/255, blue: 165/255, alpha: 1),
        "purple":UIColor(red: 140/255, green: 76/255, blue: 233/255, alpha: 1),
        "pink":UIColor(red: 252/255, green: 52/255, blue: 106/255, alpha: 1),
        "lightBlue":UIColor(red: 30/255, green: 169/255, blue: 238/255, alpha: 1),
        "yellowGreen":UIColor(red: 211/255, green: 206/255, blue: 52/255, alpha: 1),
        "vibrantBlue":UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1),
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    ]
    
    let avatarImageDictionary =
    [
        "elephant":UIImage(named: "elephant-icon"),
        "snake":UIImage(named: "snake-icon"),
        "butterfly":UIImage(named: "butterfly-icon"),
        "snail":UIImage(named: "snail-icon"),
        "horse":UIImage(named: "horse-icon"),
        "bird":UIImage(named: "bird-icon"),
        "turtle":UIImage(named: "turtle-icon"),
        "sheep":UIImage(named: "sheep-icon"),
        "bear":UIImage(named: "bear-icon"),
        "littleBird":UIImage(named: "littleBird-icon"),
        "dog":UIImage(named: "dog-icon"),
        "rabbit":UIImage(named: "rabbit-icon"),
        "caterpillar":UIImage(named: "caterpillar-icon"),
        "crab":UIImage(named: "crab-icon"),
        "fish":UIImage(named: "fish-icon"),
        "cat":UIImage(named: "cat-icon")
    ]

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dashboard"
        
        self.scrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        self.view = self.scrollView
        
        // container views initiation and layout
        
        self.profileProgressView = UIView(frame: CGRectZero)
        self.profileProgressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.profileProgressView)
        
        self.currentChallengesView = UIView(frame: CGRectZero)
        self.currentChallengesView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.currentChallengesView)
        
        self.whatsNewView = UIView(frame: CGRectZero)
        self.whatsNewView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.whatsNewView)
        
        var containerViewsDictionary = ["profileProgressView":self.profileProgressView, "currentChallengesView":self.currentChallengesView, "whatsNewView":self.whatsNewView]
        var containerMetricsDictionary = ["sideMargin": 15, "topMargin":30, "bottomMargin":30]
        
        var horizontalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[profileProgressView]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        var verticalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[profileProgressView]-[currentChallengesView]-[whatsNewView]-bottomMargin-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        self.scrollView.addConstraints(horizontalContainerViewsConstraints)
        self.scrollView.addConstraints(verticalContainerViewsConstraints)
        

        // Profile Progress View Sub-containers Initiation and Layout

        self.myProfileView = UIView(frame: CGRectZero)
        self.myProfileView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileProgressView.addSubview(self.myProfileView)
        
        self.profileProgressSeparator = UIView(frame: CGRectZero)
        self.profileProgressSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileProgressSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.profileProgressView.addSubview(self.profileProgressSeparator)
        
        self.myProgressView = UIView(frame: CGRectZero)
        self.myProgressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileProgressView.addSubview(self.myProgressView)
        
        var profileProgressSubcontainersViewsDictionary = ["myProfileView":self.myProfileView, "profileProgressSeparator":self.profileProgressSeparator, "myProgressView":self.myProgressView]
        var profileProgressSubcontainersMetricsDictionary = ["sideMargin":15]
        
        var horizontalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProfileView]->=sideMargin-[profileProgressSeparator(2)]->=0-[myProgressView]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        var verticalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressView]-0-|", options: NSLayoutFormatOptions(0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        self.profileProgressView.addConstraints(horizontalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressConstraints)
        
        
        // Profile View Initiation and Layout
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.layer.cornerRadius = 35
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = self.avatarImageDictionary[PFUser.currentUser()["avatar"] as String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[PFUser.currentUser()["color"] as String]
        self.myProfileView.addSubview(self.avatarImageView)
        
        self.myProfileLabel = UILabel(frame: CGRectZero)
        self.myProfileLabel.text = "My\nProfile"
        self.myProfileLabel.numberOfLines = 0
        self.myProfileLabel.textAlignment = NSTextAlignment.Left
        self.myProfileLabel.font = regularFont?.fontWithSize(20.0)
        self.myProfileLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.myProfileView.addSubview(self.myProfileLabel)

        self.currentUserLabel = UILabel(frame: CGRectZero)
        self.currentUserLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentUserLabel.text = PFUser.currentUser().username
        self.currentUserLabel.font = regularFont?.fontWithSize(13.0)
        self.currentUserLabel.textAlignment = NSTextAlignment.Left
        self.myProfileView.addSubview(self.currentUserLabel)
        
        var myProfileViewViewsDictionary = ["avatarImageView":self.avatarImageView, "myProfileLabel":self.myProfileLabel, "currentUserLabel":self.currentUserLabel]
        var myProfileViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(70)]-inBetweenPadding-[myProfileLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        var verticalLeftMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[avatarImageView(70)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        var verticalRightMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProfileLabel]-2-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        self.myProfileView.addConstraints(horizontalMyProfileViewConstraints)
        self.myProfileView.addConstraints(verticalLeftMyProfileViewConstraints)
        self.myProfileView.addConstraints(verticalRightMyProfileViewConstraints)
        
        // myProgressView Initialization and Layout
        
        self.myProgressLabel = UILabel(frame: CGRectZero)
        self.myProgressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.myProgressLabel.text = "My\nRecords"
        self.myProgressLabel.textAlignment = NSTextAlignment.Left
        self.myProgressLabel.font = regularFont?.fontWithSize(20.0)
        self.myProgressLabel.numberOfLines = 0
        self.myProgressView.addSubview(self.myProgressLabel)
        
        var items:NSArray = [PNPieChartDataItem(value: 0.3, color: self.colorDictionary["vibrantBlue"],description: ""), PNPieChartDataItem(value: 0.1, color: self.colorDictionary["pink"],description: ""),PNPieChartDataItem(value: 0.6, color: self.colorDictionary["vibrantGreen"],description: "")]
        self.myProgressPieChart = PNPieChart(frame: CGRectMake(0, 0, 70, 70), items: items)
        self.myProgressPieChart.strokeChart()
        self.myProgressView.addSubview(self.myProgressPieChart)

        
        var myProgressViewViewsDictionary = ["myProgressLabel":self.myProgressLabel, "myProgressPieChart":self.myProgressPieChart]
        var myProgresssViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProgressPieChart(70)]-inBetweenPadding-[myProgressLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        var verticalLeftMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressPieChart(70)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        var verticalRightMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProgressLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        self.myProgressView.addConstraints(horizontalMyProgressViewConstraint)
        self.myProgressView.addConstraints(verticalLeftMyProgressViewConstraint)
        self.myProgressView.addConstraints(verticalRightMyProgressViewConstraint)
        
//        var viewsDictionary = ["currentUserLabel":currentUserLabel]
//        var metricsDictionary = ["margin": 20]
//        
//        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=0-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
//        
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
//        
//        self.scrollView.addConstraints(horizontalConstraints)
//        self.scrollView.addConstraints(verticalConstraints)
        

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
