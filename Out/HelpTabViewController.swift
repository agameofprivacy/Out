//
//  HelpTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class HelpTabViewController: UIViewController {

    var helpPromptView:UIView!
    var topPromptLabel:UILabel!
    var followUpPromptLabel:UILabel!
    var infoParagraphLabel:UILabel!
    
    
    var chatView:UIView!
    var chatPromptLabel:UILabel!
    var chatButton:UIButton!
    var chatRequirementsLabel:UILabel!
    
    var talkView:UIView!
    var talkPromptLabel:UILabel!
    var talkButton:UIButton!
    var talkRequirementsLabel:UILabel!
    
    var servicePartnerView:UIView!
    var servicePartnerInfoLabel:UILabel!
    var servicePartnerLogoImageView:UIImageView!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Help"
        // Do any additional setup after loading the view.
        
        self.helpPromptView = UIView(frame: CGRectZero)
        self.helpPromptView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.helpPromptView)
        
        self.topPromptLabel = UILabel(frame: CGRectZero)
        self.topPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.topPromptLabel.font = regularFont?.fontWithSize(30.0)
        self.topPromptLabel.textAlignment = NSTextAlignment.Left
        self.topPromptLabel.numberOfLines = 0
        self.topPromptLabel.text = "Need help?"
        self.helpPromptView.addSubview(self.topPromptLabel)
        
        self.followUpPromptLabel = UILabel(frame: CGRectZero)
        self.followUpPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followUpPromptLabel.font = regularFont?.fontWithSize(24.0)
        self.followUpPromptLabel.textAlignment = NSTextAlignment.Left
        self.followUpPromptLabel.numberOfLines = 0
        self.followUpPromptLabel.text = "We are here for you. 24/7."
        self.helpPromptView.addSubview(self.followUpPromptLabel)
        
        self.infoParagraphLabel = UILabel(frame: CGRectZero)
        self.infoParagraphLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.infoParagraphLabel.font = valueFont
        self.infoParagraphLabel.textAlignment = NSTextAlignment.Left
        self.infoParagraphLabel.numberOfLines = 0
        self.infoParagraphLabel.text = "Everything will be anonymous, confidential and off-record."
        self.helpPromptView.addSubview(self.infoParagraphLabel)
        
        self.chatView = UIView(frame: CGRectZero)
        self.chatView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.chatView)
        
        self.chatPromptLabel = UILabel(frame: CGRectZero)
        self.chatPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatPromptLabel.font = regularFont?.fontWithSize(17.0)
        self.chatPromptLabel.textAlignment = NSTextAlignment.Left
        self.chatPromptLabel.numberOfLines = 1
        self.chatPromptLabel.text = "Chat with someone."
        self.chatView.addSubview(self.chatPromptLabel)
        
        var chatButtonTapRecognizer = UITapGestureRecognizer(target: self, action: "chatButtonTapped")
        
        self.chatButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.chatButton.setTitle("Chat", forState: UIControlState.Normal)
        self.chatButton.layer.cornerRadius = 5
        self.chatButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        self.chatButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatButton.addGestureRecognizer(chatButtonTapRecognizer)
        self.chatView.addSubview(self.chatButton)
        
        self.chatRequirementsLabel = UILabel(frame: CGRectZero)
        self.chatRequirementsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatRequirementsLabel.textAlignment = NSTextAlignment.Right
        self.chatRequirementsLabel.numberOfLines = 0
        self.chatRequirementsLabel.font = regularFont?.fontWithSize(14.0)
        self.chatRequirementsLabel.text = "*Requires Internet connection"
        self.chatView.addSubview(self.chatRequirementsLabel)
        
        self.talkView = UIView(frame: CGRectZero)
        self.talkView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.talkView)
        
        self.talkPromptLabel = UILabel(frame: CGRectZero)
        self.talkPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkPromptLabel.font = regularFont?.fontWithSize(17.0)
        self.talkPromptLabel.textAlignment = NSTextAlignment.Left
        self.talkPromptLabel.numberOfLines = 1
        self.talkPromptLabel.text = "Talk to someone"
        self.talkView.addSubview(self.talkPromptLabel)
        
        var talkButtonTapRecognizer = UITapGestureRecognizer(target: self, action: "talkButtonTapped")
        
        self.talkButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.talkButton.setTitle("Talk", forState: UIControlState.Normal)
        self.talkButton.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        self.talkButton.layer.cornerRadius = 5
        self.talkButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkButton.addGestureRecognizer(talkButtonTapRecognizer)
        self.talkView.addSubview(self.talkButton)
        
        self.talkRequirementsLabel = UILabel(frame: CGRectZero)
        self.talkRequirementsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkRequirementsLabel.textAlignment = NSTextAlignment.Right
        self.talkRequirementsLabel.numberOfLines = 0
        self.talkRequirementsLabel.font = regularFont?.fontWithSize(14.0)
        self.talkRequirementsLabel.text = "*Requires Internet connection"
        self.talkView.addSubview(self.talkRequirementsLabel)
        
        self.servicePartnerView = UIView(frame: CGRectZero)
        self.servicePartnerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.servicePartnerView)
        
        self.servicePartnerInfoLabel = UILabel(frame: CGRectZero)
        self.servicePartnerInfoLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.servicePartnerInfoLabel.font = regularFont?.fontWithSize(14.0)
        self.servicePartnerInfoLabel.textAlignment = NSTextAlignment.Right
        self.servicePartnerInfoLabel.numberOfLines = 1
        self.servicePartnerInfoLabel.text = "Service provided by"
        self.servicePartnerView.addSubview(self.servicePartnerInfoLabel)
        
        self.servicePartnerLogoImageView = UIImageView(frame: CGRectZero)
        self.servicePartnerLogoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.servicePartnerLogoImageView.image = UIImage(named: "partner-logo")
        self.servicePartnerLogoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.servicePartnerView.addSubview(self.servicePartnerLogoImageView)
        
        
        var rootViewsDictionary = ["helpPromptView":self.helpPromptView, "chatView":self.chatView, "talkView":self.talkView, "servicePartnerView":self.servicePartnerView]
        var rootMetricsDictionary = ["topMarginMin":134, "sideMargin":12, "bottomMarginMin":120]
        
        var rootHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[helpPromptView]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: rootMetricsDictionary, views: rootViewsDictionary)
        
        var rootVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topMarginMin-[helpPromptView]-40-[chatView]-[talkView]->=50-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: rootMetricsDictionary, views: rootViewsDictionary)
        
        var rootBottomVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[servicePartnerView]->=bottomMarginMin-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: rootMetricsDictionary, views: rootViewsDictionary)
        
        var rootBottomHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[servicePartnerView]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: rootMetricsDictionary, views: rootViewsDictionary)

        
        self.view.addConstraints(rootHorizontalConstraints)
        self.view.addConstraints(rootBottomHorizontalConstraints)
        self.view.addConstraints(rootVerticalConstraints)
        self.view.addConstraints(rootBottomVerticalConstraints)
        
        var helpPromptViewViewsDictionary = ["topPromptLabel":self.topPromptLabel, "followUpPromptLabel":self.followUpPromptLabel, "infoParagraphLabel":self.infoParagraphLabel]
        var helpPromptViewMetricsDictionary = ["mediumVerticalMargin":10, "largeVerticalMargin": 20]
        
        var helpPromptViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[topPromptLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: helpPromptViewMetricsDictionary, views: helpPromptViewViewsDictionary)
        
        var helpPromptViewVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topPromptLabel]-6-[followUpPromptLabel]-largeVerticalMargin-[infoParagraphLabel]-0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: helpPromptViewMetricsDictionary, views: helpPromptViewViewsDictionary)
        
        self.helpPromptView.addConstraints(helpPromptViewHorizontalConstraints)
        self.helpPromptView.addConstraints(helpPromptViewVerticalConstraints)
        
        
        var chatViewViewsDictionary = ["chatPromptLabel":self.chatPromptLabel, "chatButton":self.chatButton, "chatRequirementsLabel":self.chatRequirementsLabel]
        var chatViewMetricsDictionary = ["shortVerticalMargin":4]
        
        var chatViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[chatPromptLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: chatViewMetricsDictionary, views: chatViewViewsDictionary)
        var chatViewVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[chatPromptLabel]-shortVerticalMargin-[chatButton(44)]-shortVerticalMargin-[chatRequirementsLabel]-0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: chatViewMetricsDictionary, views: chatViewViewsDictionary)
        
        self.chatView.addConstraints(chatViewHorizontalConstraints)
        self.chatView.addConstraints(chatViewVerticalConstraints)
        
        
        var talkViewViewsDictionary = ["talkPromptLabel":self.talkPromptLabel, "talkButton":self.talkButton, "talkRequirementsLabel":self.talkRequirementsLabel]
        var talkViewMetricsDictionary = ["shortVerticalMargin":8]
        
        var talkViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[talkPromptLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: talkViewMetricsDictionary, views: talkViewViewsDictionary)
        var talkViewVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[talkPromptLabel]-shortVerticalMargin-[talkButton(44)]-shortVerticalMargin-[talkRequirementsLabel]-0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: talkViewMetricsDictionary, views: talkViewViewsDictionary)
        
        self.talkView.addConstraints(talkViewHorizontalConstraints)
        self.talkView.addConstraints(talkViewVerticalConstraints)
        
        
        var servicePartnerViewViewsDictionary = ["servicePartnerInfoLabel":self.servicePartnerInfoLabel, "servicePartnerLogoImageView":self.servicePartnerLogoImageView]
        var servicePartnerViewMetricsDictionary = ["shortHorizontalMargin":4]

        var servicePartnerViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-55-[servicePartnerInfoLabel]-shortHorizontalMargin-[servicePartnerLogoImageView(<=100)]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: servicePartnerViewMetricsDictionary, views: servicePartnerViewViewsDictionary)
        
        var servicePartnerViewVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[servicePartnerInfoLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: servicePartnerViewMetricsDictionary, views: servicePartnerViewViewsDictionary)
        
        self.servicePartnerView.addConstraints(servicePartnerViewHorizontalConstraints)
        self.servicePartnerView.addConstraints(servicePartnerViewVerticalConstraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func talkButtonTapped(){
        self.performSegueWithIdentifier("talkHelp", sender: self)
    }

    func chatButtonTapped(){
        self.performSegueWithIdentifier("chatHelp", sender: self)
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
