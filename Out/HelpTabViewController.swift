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
        self.topPromptLabel.font = titleFont?.fontWithSize(24.0)
        self.topPromptLabel.textAlignment = NSTextAlignment.Left
        self.topPromptLabel.numberOfLines = 0
        self.helpPromptView.addSubview(self.topPromptLabel)
        
        self.followUpPromptLabel = UILabel(frame: CGRectZero)
        self.followUpPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followUpPromptLabel.font = titleFont?.fontWithSize(20.0)
        self.followUpPromptLabel.textAlignment = NSTextAlignment.Left
        self.followUpPromptLabel.numberOfLines = 0
        self.helpPromptView.addSubview(self.followUpPromptLabel)
        
        self.infoParagraphLabel = UILabel(frame: CGRectZero)
        self.infoParagraphLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.infoParagraphLabel.font = valueFont
        self.infoParagraphLabel.textAlignment = NSTextAlignment.Left
        self.infoParagraphLabel.numberOfLines = 0
        self.helpPromptView.addSubview(self.infoParagraphLabel)
        
        self.chatView = UIView(frame: CGRectZero)
        self.chatView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.chatView)
        
        self.chatPromptLabel = UILabel(frame: CGRectZero)
        self.chatPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatPromptLabel.font = titleFont?.fontWithSize(17.0)
        self.chatPromptLabel.textAlignment = NSTextAlignment.Left
        self.chatPromptLabel.numberOfLines = 1
        self.chatView.addSubview(self.chatPromptLabel)
        
        self.chatButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.chatButton.setImage(UIImage(named: "chatButton"), forState: UIControlState.Normal)
        self.chatButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatView.addSubview(self.chatButton)
        
        self.chatRequirementsLabel = UILabel(frame: CGRectZero)
        self.chatRequirementsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.chatRequirementsLabel.textAlignment = NSTextAlignment.Right
        self.chatRequirementsLabel.numberOfLines = 0
        self.chatRequirementsLabel.font = regularFont?.fontWithSize(14.0)
        self.chatView.addSubview(self.chatRequirementsLabel)
        
        self.talkView = UIView(frame: CGRectZero)
        self.talkView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.talkView)
        
        self.talkPromptLabel = UILabel(frame: CGRectZero)
        self.talkPromptLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkPromptLabel.font = titleFont?.fontWithSize(17.0)
        self.talkPromptLabel.textAlignment = NSTextAlignment.Left
        self.talkPromptLabel.numberOfLines = 1
        self.talkView.addSubview(self.talkPromptLabel)
        
        self.talkButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.talkButton.setImage(UIImage(named: "talkButton"), forState: UIControlState.Normal)
        self.talkButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkView.addSubview(self.talkButton)
        
        self.talkRequirementsLabel = UILabel(frame: CGRectZero)
        self.talkRequirementsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.talkRequirementsLabel.textAlignment = NSTextAlignment.Right
        self.talkRequirementsLabel.numberOfLines = 0
        self.talkRequirementsLabel.font = regularFont?.fontWithSize(14.0)
        self.talkView.addSubview(self.talkRequirementsLabel)
        
        self.servicePartnerView = UIView(frame: CGRectZero)
        self.servicePartnerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.servicePartnerView)
        
        self.servicePartnerInfoLabel = UILabel(frame: CGRectZero)
        self.servicePartnerInfoLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.servicePartnerInfoLabel.font = regularFont?.fontWithSize(14.0)
        self.servicePartnerInfoLabel.textAlignment = NSTextAlignment.Right
        self.servicePartnerInfoLabel.numberOfLines = 1
        self.servicePartnerView.addSubview(self.servicePartnerInfoLabel)
        
        self.servicePartnerLogoImageView = UIImageView(frame: CGRectZero)
        self.servicePartnerLogoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.servicePartnerLogoImageView.image = UIImage(named: "partnerLogo")
        self.servicePartnerView.addSubview(self.servicePartnerLogoImageView)
        
        
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
