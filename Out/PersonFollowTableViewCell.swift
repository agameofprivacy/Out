//
//  PersonFollowTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/2/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PersonFollowTableViewCell: UITableViewCell {

    var userAvatar:UIImageView!
    var userAlias:UILabel!
    var userOrientationAge:UILabel!
    var followButton:UIButton!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    
    var colorDictionary =
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
    
    var avatarImageDictionary =
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
        
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.userAvatar = UIImageView(frame: CGRectZero)
        self.userAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userAvatar.layer.cornerRadius = 25
        self.userAvatar.clipsToBounds = true
        self.userAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(self.userAvatar)
        
        self.userAlias = UILabel(frame: CGRectZero)
        self.userAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userAlias.textAlignment = NSTextAlignment.Left
        self.userAlias.font = regularFont?.fontWithSize(17.0)
        contentView.addSubview(self.userAlias)
        
        self.userOrientationAge = UILabel(frame: CGRectZero)
        self.userOrientationAge.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userOrientationAge.textAlignment = NSTextAlignment.Left
        self.userOrientationAge.font = titleFont?.fontWithSize(14.0)
        contentView.addSubview(self.userOrientationAge)
        
        self.followButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.followButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followButton.layer.borderColor = UIColor.blackColor().CGColor
        self.followButton.layer.borderWidth = 1
        self.followButton.layer.cornerRadius = 5
        self.followButton.setTitle("Follow", forState: UIControlState.Normal)
        contentView.addSubview(self.followButton)
        
        var viewsDictionary = ["userAvatar":self.userAvatar, "userAlias":self.userAlias, "userOrientationAge":self.userOrientationAge, "followButton":self.followButton]
        
        var metricsDictionary = ["sideMargin":15, "verticalMargin":15]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[userAvatar(50)]-sideMargin-[userAlias]-[followButton(120)]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=verticalMargin-[userAvatar(50)]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var aliasVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=20-[userAlias]-2-[userOrientationAge]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var followButtonVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=25-[followButton(30)]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(avatarVerticalConstraints)
        contentView.addConstraints(aliasVerticalConstraints)
        contentView.addConstraints(followButtonVerticalConstraints)
        
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
