//
//  ActivityContentPreviewViewController.swift
//  Out
//
//  Created by Eddie Chen on 1/24/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ActivityContentPreviewViewController: UIViewController, UIWebViewDelegate {

    var parentVC:ActivityTabViewController!
    var activity:PFObject!
    var challenge:PFObject!
    var userChallengeData:PFObject!
    var user:PFUser!
    var challengeTrackNumber:Int!
    
    var challengeShade:UIView!
    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var activityNarrativeActionLabel:UILabel!
    var activityNarrativeTitleLabel:UILabel!
    var prepoChallengeTitleLabel:UILabel!
    var challengeTitleLabel:UILabel!
    var viewChallengeButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton

    var activityContentWebView:UIWebView!
    
    // User color dictionary
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
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
        "intermediateYellow":UIColor(red: 255/255, green: 206/255, blue: 0/255, alpha: 1),
        "intenseRed":UIColor(red: 223/255, green: 48/255, blue: 97/255, alpha: 1),
        "casualGreen":UIColor(red: 32/255, green: 220/255, blue: 129/255, alpha: 1)
    ]
    
    
    // Avatar image dictionary
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Activity"
        
        var shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareActivityContent")
        shareButton.enabled = true
        shareButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = shareButton

        
        var URLString = (self.challenge["narrativeURLs"] as [String])[challengeTrackNumber] as String
        self.automaticallyAdjustsScrollViewInsets = false
        self.activityContentWebView = UIWebView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height - 113))
        self.activityContentWebView.scrollView.contentInset = UIEdgeInsetsMake(130, 0, 0, 0)
        self.activityContentWebView.delegate = self
        self.activityContentWebView.scalesPageToFit = true
        self.activityContentWebView.hidden = true
        self.view.addSubview(self.activityContentWebView)
 
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        visualEffectView.frame = CGRectMake(0, 0, self.view.frame.width, 130)

        
        var challengeShadeBG = UIView(frame: CGRectMake(0, 64, self.view.frame.width, 130))
        challengeShadeBG.layer.masksToBounds = false
//        challengeShadeBG.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
        challengeShadeBG.layer.shadowColor = UIColor.blackColor().CGColor
        challengeShadeBG.layer.shadowOffset = CGSize(width: 0, height: 1)
        challengeShadeBG.layer.shadowOpacity = 0.15
        challengeShadeBG.layer.shadowRadius = 1
        self.view.addSubview(challengeShadeBG)

        
        self.challengeShade = UIView(frame: CGRectMake(0, 64, self.view.frame.width, 130))
        self.challengeShade.layer.masksToBounds = false
        self.challengeShade.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
        self.challengeShade.layer.shadowColor = UIColor.blackColor().CGColor
        self.challengeShade.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.challengeShade.layer.shadowOpacity = 0.15
        self.challengeShade.layer.shadowRadius = 1
        self.view.addSubview(self.challengeShade)
        
        challengeShadeBG.addSubview(visualEffectView)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.image = self.avatarImageDictionary[user["avatar"] as String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[user["color"] as String]
        self.challengeShade.addSubview(self.avatarImageView)

        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aliasLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        self.aliasLabel.text = self.user.username
        self.aliasLabel.numberOfLines = 1
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.challengeShade.addSubview(self.aliasLabel)
        
        self.activityNarrativeActionLabel = UILabel(frame: CGRectZero)
        self.activityNarrativeActionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.activityNarrativeActionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        self.activityNarrativeActionLabel.text = (self.challenge["narrativeAction"] as String)
        self.activityNarrativeActionLabel.numberOfLines = 1
        self.activityNarrativeActionLabel.textAlignment = NSTextAlignment.Left
        self.challengeShade.addSubview(self.activityNarrativeActionLabel)
        
        self.activityNarrativeTitleLabel = UILabel(frame: CGRectZero)
        self.activityNarrativeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.activityNarrativeTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        self.activityNarrativeTitleLabel.text = (self.challenge["narrativeTitles"] as [String])[self.challengeTrackNumber]
        self.activityNarrativeTitleLabel.numberOfLines = 1
        self.activityNarrativeTitleLabel.textAlignment = NSTextAlignment.Left
        self.challengeShade.addSubview(self.activityNarrativeTitleLabel)

        self.prepoChallengeTitleLabel = UILabel(frame: CGRectZero)
        self.prepoChallengeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.prepoChallengeTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        self.prepoChallengeTitleLabel.text = "in"
        self.prepoChallengeTitleLabel.numberOfLines = 1
        self.prepoChallengeTitleLabel.textAlignment = NSTextAlignment.Left
        self.challengeShade.addSubview(self.prepoChallengeTitleLabel)
        
        self.challengeTitleLabel = UILabel(frame: CGRectZero)
        self.challengeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        self.challengeTitleLabel.text = (self.challenge["title"] as String)
        self.challengeTitleLabel.numberOfLines = 1
        self.challengeTitleLabel.textAlignment = NSTextAlignment.Left
        self.challengeShade.addSubview(self.challengeTitleLabel)

        self.viewChallengeButton.frame = CGRectZero
        self.viewChallengeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.viewChallengeButton.setTitle("View Challenge", forState: UIControlState.Normal)
        self.viewChallengeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.viewChallengeButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        self.viewChallengeButton.userInteractionEnabled = true
        self.viewChallengeButton.layer.borderWidth = 1
        self.viewChallengeButton.layer.borderColor = UIColor.blackColor().CGColor
        self.viewChallengeButton.layer.cornerRadius = 5
        self.challengeShade.addSubview(viewChallengeButton)

        
        
        var challengeShadeViewsDictionary = ["avatarImageView":avatarImageView, "aliasLabel":aliasLabel, "activityNarrativeTitleLabel":activityNarrativeTitleLabel, "activityNarrativeActionLabel":activityNarrativeActionLabel, "prepoChallengeTitleLabel":prepoChallengeTitleLabel, "challengeTitleLabel":challengeTitleLabel, "viewChallengeButton":viewChallengeButton]
        var challengeShadeMetricsDictionary = ["largeVerticalPadding":12]
        
        var horizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[avatarImageView(50)]-12.5-[aliasLabel]", options: NSLayoutFormatOptions(0), metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)
        
        var secondHorizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[aliasLabel]-[activityNarrativeActionLabel]-[activityNarrativeTitleLabel]->=7.5-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)
        
        var thirdHorizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[prepoChallengeTitleLabel]-[challengeTitleLabel]->=7.5-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)
        
        var fourthHorizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[viewChallengeButton]-7.5-|", options: NSLayoutFormatOptions(0), metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)

        var verticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-16.5-[avatarImageView(50)]->=7.5-[viewChallengeButton(36)]-12-|", options: NSLayoutFormatOptions(0), metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)
        
        var secondVerticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-21.5-[aliasLabel]-2-[prepoChallengeTitleLabel]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: challengeShadeMetricsDictionary, views: challengeShadeViewsDictionary)
        
        self.challengeShade.addConstraints(horizontalShadeViewConstraints)
        self.challengeShade.addConstraints(secondHorizontalShadeViewConstraints)
        self.challengeShade.addConstraints(thirdHorizontalShadeViewConstraints)
        self.challengeShade.addConstraints(fourthHorizontalShadeViewConstraints)
        self.challengeShade.addConstraints(verticalShadeViewConstraints)
        self.challengeShade.addConstraints(secondVerticalShadeViewConstraints)
        
        // Initialize NSURLRequest object with URL
        var req = NSURLRequest(URL:NSURL(string: URLString)!)
        
        // Load NSURLRequest
        self.activityContentWebView!.loadRequest(req)
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // Update UINavigationBar title with page title once the page is loaded
//        self.navigationItem.title = self.webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.activityContentWebView.hidden = false
    }



    func shareActivityContent(){
        println("share activity")
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
