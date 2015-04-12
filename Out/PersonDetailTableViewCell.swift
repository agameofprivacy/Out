//
//  PersonDetailTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/12/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class PersonDetailTableViewCell: UITableViewCell {
    
    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var basicsLabel:UILabel!
    var aboutTextView:UITextView!
    var followButton:UIButton!
    var messageButton:UIButton!
    var separatorView:UIView!
    
    var segmentedControlView:UIView!
    var personDetailSegmentedControl:UISegmentedControl!

    
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

    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.image = avatarImageDictionary["dog"]!
        self.avatarImageView.backgroundColor = colorDictionary["vibrantGreen"]
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aliasLabel.text = "username"
        contentView.addSubview(self.aliasLabel)
        
        self.basicsLabel = UILabel(frame: CGRectZero)
        self.basicsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.basicsLabel.text = "user basic stats"
        contentView.addSubview(self.basicsLabel)
        
        self.aboutTextView = UITextView(frame: CGRectZero)
        self.aboutTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aboutTextView.text = "user advance stats"
        contentView.addSubview(self.aboutTextView)
        
        self.followButton = UIButton(frame: CGRectZero)
        self.followButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followButton.setTitle("Follow", forState: UIControlState.Normal)
        self.followButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.followButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.followButton.layer.borderWidth = 1
        self.followButton.layer.borderColor = UIColor.blackColor().CGColor
        self.followButton.layer.cornerRadius = 8
        contentView.addSubview(self.followButton)
        
        self.messageButton = UIButton(frame: CGRectZero)
        self.messageButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.messageButton.setTitle("Message", forState: UIControlState.Normal)
        self.messageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.messageButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.messageButton.layer.borderWidth = 1
        self.messageButton.layer.borderColor = UIColor.blackColor().CGColor
        self.messageButton.layer.cornerRadius = 8
        contentView.addSubview(self.messageButton)
        
        self.separatorView = UIView(frame: CGRectZero)
        self.separatorView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.separatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        contentView.addSubview(self.separatorView)
        
        var metricsDictionary = ["sideMargin":7.5, "buttonMargin":(UIScreen.mainScreen().bounds.width - 304)/2]
        var viewsDictionary = ["avatarImageView":self.avatarImageView, "aliasLabel":self.aliasLabel, "basicsLabel":self.basicsLabel, "aboutTextView":self.aboutTextView, "followButton":self.followButton, "messageButton":self.messageButton, "separatorView":self.separatorView]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[avatarImageView(50)]-15-[aliasLabel]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var secondHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[aboutTextView]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var thirdHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-buttonMargin-[followButton(140)]-24-[messageButton(140)]-buttonMargin-|", options: NSLayoutFormatOptions.AlignAllTop | NSLayoutFormatOptions.AlignAllBottom, metrics: metricsDictionary, views: viewsDictionary)
        
        var fourthHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separatorView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[avatarImageView(50)]->=0-[aboutTextView]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var secondVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-24-[aliasLabel]-0-[basicsLabel]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)

        var thirdVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[basicsLabel]-[aboutTextView]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var fourthVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aboutTextView]-20-[followButton(36)]-30-[separatorView(0.5)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
//        var buttonHorizontalConstraint = NSLayoutConstraint(item: self.followButton, attribute: NSLayoutAttribute.CenterXWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: self.separatorView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)

        self.contentView.addConstraints(topHorizontalConstraints)
        self.contentView.addConstraints(secondHorizontalConstraints)
        self.contentView.addConstraints(thirdHorizontalConstraints)
        self.contentView.addConstraints(fourthHorizontalConstraints)
        self.contentView.addConstraints(leftVerticalConstraints)
        self.contentView.addConstraints(secondVerticalConstraints)
        self.contentView.addConstraints(thirdVerticalConstraints)
        self.contentView.addConstraints(fourthVerticalConstraints)
//        self.contentView.addConstraint(buttonHorizontalConstraint)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
