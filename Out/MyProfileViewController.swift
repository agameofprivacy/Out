//
//  MyProfileViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for profile view
class MyProfileViewController: UIViewController {

    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    
    var genderIdentityTitleLabel:UILabel!
    var genderIdentityLabel:UILabel!
    var sexualOrientationTitleLabel:UILabel!
    var sexualOrientationLabel:UILabel!
    var ageTitleLabel:UILabel!
    var ageLabel:UILabel!
    var ethnicityTitleLabel:UILabel!
    var ethnicityLabel:UILabel!
    var locationTitleLabel:UILabel!
    var locationLabel:UILabel!
    var containerView:TPKeyboardAvoidingScrollView!
    
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

        // UINavigationBar init
        self.navigationItem.title = "Profile"

        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        
        var editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editButtonTapped")
        editButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = editButton


        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.containerView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.containerView.alwaysBounceVertical = true
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.layer.cornerRadius = 50
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = self.avatarImageDictionary[(PFUser.currentUser()!)["avatar"] as! String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[(PFUser.currentUser()!)["color"] as! String]
        self.containerView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aliasLabel.text = PFUser.currentUser()!.username
        self.aliasLabel.textAlignment = NSTextAlignment.Center
        self.aliasLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.aliasLabel.numberOfLines = 1
        self.aliasLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.aliasLabel)

        self.genderIdentityTitleLabel = UILabel(frame: CGRectZero)
        self.genderIdentityTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.genderIdentityTitleLabel.text = "Gender Identity"
        self.genderIdentityTitleLabel.textAlignment = NSTextAlignment.Center
        self.genderIdentityTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.genderIdentityTitleLabel.numberOfLines = 1
        self.genderIdentityTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.genderIdentityTitleLabel)

        self.genderIdentityLabel = UILabel(frame: CGRectZero)
        self.genderIdentityLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.genderIdentityLabel.text = PFUser.currentUser()!["genderIdentity"] as? String
        self.genderIdentityLabel.textAlignment = NSTextAlignment.Center
        self.genderIdentityLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.genderIdentityLabel.numberOfLines = 1
        self.genderIdentityLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.containerView.addSubview(self.genderIdentityLabel)

        self.sexualOrientationTitleLabel = UILabel(frame: CGRectZero)
        self.sexualOrientationTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.sexualOrientationTitleLabel.text = "Sexual Orientation"
        self.sexualOrientationTitleLabel.textAlignment = NSTextAlignment.Center
        self.sexualOrientationTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.sexualOrientationTitleLabel.numberOfLines = 1
        self.sexualOrientationTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.sexualOrientationTitleLabel)
        
        self.sexualOrientationLabel = UILabel(frame: CGRectZero)
        self.sexualOrientationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.sexualOrientationLabel.text = PFUser.currentUser()!["sexualOrientation"] as? String
        self.sexualOrientationLabel.textAlignment = NSTextAlignment.Center
        self.sexualOrientationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.sexualOrientationLabel.numberOfLines = 1
        self.sexualOrientationLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.containerView.addSubview(self.sexualOrientationLabel)

        self.ageTitleLabel = UILabel(frame: CGRectZero)
        self.ageTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.ageTitleLabel.text = "Age"
        self.ageTitleLabel.textAlignment = NSTextAlignment.Center
        self.ageTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.ageTitleLabel.numberOfLines = 1
        self.ageTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.ageTitleLabel)
        
        self.ageLabel = UILabel(frame: CGRectZero)
        self.ageLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        var userAge = PFUser.currentUser()!["age"] as! Int
        self.ageLabel.text = "\(userAge)"
        self.ageLabel.textAlignment = NSTextAlignment.Center
        self.ageLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.ageLabel.numberOfLines = 1
        self.ageLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.containerView.addSubview(self.ageLabel)

        self.ethnicityTitleLabel = UILabel(frame: CGRectZero)
        self.ethnicityTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.ethnicityTitleLabel.text = "Ethnicity"
        self.ethnicityTitleLabel.textAlignment = NSTextAlignment.Center
        self.ethnicityTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.ethnicityTitleLabel.numberOfLines = 1
        self.ethnicityTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.ethnicityTitleLabel)
        
        self.ethnicityLabel = UILabel(frame: CGRectZero)
        self.ethnicityLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.ethnicityLabel.text = (PFUser.currentUser()!["ethnicity"] as? String)?.lowercaseString
        self.ethnicityLabel.textAlignment = NSTextAlignment.Center
        self.ethnicityLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.ethnicityLabel.numberOfLines = 1
        self.ethnicityLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.containerView.addSubview(self.ethnicityLabel)

        self.locationTitleLabel = UILabel(frame: CGRectZero)
        self.locationTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.locationTitleLabel.text = "Location"
        self.locationTitleLabel.textAlignment = NSTextAlignment.Center
        self.locationTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.locationTitleLabel.numberOfLines = 1
        self.locationTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containerView.addSubview(self.locationTitleLabel)
        
        self.locationLabel = UILabel(frame: CGRectZero)
        self.locationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.locationLabel.text = ((PFUser.currentUser()!)["city"] as? String)!.lowercaseString + ", " + ((PFUser.currentUser()!)["state"] as? String)!.lowercaseString
        self.locationLabel.textAlignment = NSTextAlignment.Center
        self.locationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.locationLabel.numberOfLines = 1
        self.locationLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.containerView.addSubview(self.locationLabel)

        
        self.view.addSubview(self.containerView)

        
        var viewsDictionary = ["avatarImageView":self.avatarImageView, "aliasLabel":aliasLabel, "genderIdentityTitleLabel":genderIdentityTitleLabel, "genderIdentityLabel":genderIdentityLabel, "sexualOrientationTitleLabel":sexualOrientationTitleLabel, "sexualOrientationLabel":sexualOrientationLabel, "ageTitleLabel":ageTitleLabel, "ageLabel":ageLabel, "ethnicityTitleLabel":ethnicityTitleLabel, "ethnicityLabel":ethnicityLabel, "locationTitleLabel":locationTitleLabel, "locationLabel":locationLabel]
        
        var metricsDictionary = ["sideMargin": 12]
        
        var horizontalViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[avatarImageView(100)]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var horizontalCenterConstraint = NSLayoutConstraint(item: self.avatarImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        
        var verticalViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[avatarImageView(100)]-14-[aliasLabel]-38-[ageTitleLabel]-2-[ageLabel]-22-[genderIdentityTitleLabel]-2-[genderIdentityLabel]-22-[sexualOrientationTitleLabel]-2-[sexualOrientationLabel]-22-[ethnicityTitleLabel]-2-[ethnicityLabel]-22-[locationTitleLabel]-2-[locationLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
        
        self.containerView.addConstraint(horizontalCenterConstraint)
        self.containerView.addConstraints(horizontalViewsConstraints)
        self.containerView.addConstraints(verticalViewsConstraints)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Dismiss modal profile view if Close button tapped
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Enter Profile Edit mode
    func editButtonTapped(){
        println("Edit profile!")
    }


}
