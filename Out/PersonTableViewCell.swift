//
//  PersonTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    var userAvatar:UIImageView!
    var userAlias:UILabel!
    var userOrientationAge:UILabel!
    var userLocation:UILabel!
    var userButton:UIButton!

    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
        self.userAvatar = UIImageView(frame: CGRectZero)
        self.userAvatar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userAvatar.layer.cornerRadius = 25
        self.userAvatar.clipsToBounds = true
        self.userAvatar.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(self.userAvatar)
        
        self.userAlias = UILabel(frame: CGRectZero)
        self.userAlias.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userAlias.textAlignment = NSTextAlignment.Left
        self.userAlias.font = regularFont?.fontWithSize(15.0)
        contentView.addSubview(self.userAlias)
        
        self.userOrientationAge = UILabel(frame: CGRectZero)
        self.userOrientationAge.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userOrientationAge.textAlignment = NSTextAlignment.Left
        self.userOrientationAge.font = titleFont?.fontWithSize(14.0)
        contentView.addSubview(self.userOrientationAge)
        
        self.userLocation = UILabel(frame: CGRectZero)
        self.userLocation.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userLocation.textAlignment = NSTextAlignment.Left
        self.userLocation.font = valueFont?.fontWithSize(14.0)
        contentView.addSubview(self.userLocation)
        
//        self.userButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        self.userButton.frame = CGRectZero
//        self.userButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.userButton.setImage(UIImage(named: "rightChevron-icon"), forState: UIControlState.Normal)
//        self.userButton.contentMode = UIViewContentMode.ScaleAspectFit
//        contentView.addSubview(self.userButton)
        
        
        var viewsDictionary = ["userAvatar":userAvatar, "userAlias":userAlias, "userOrientationAge":userOrientationAge, "userLocation":userLocation]
        var metricsDictionary = ["verticalMargin":15, "sideMargin":15]
        
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[userAvatar(50)]-20-[userAlias]->=sideMargin-[userOrientationAge]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var avatarVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[userAvatar(50)]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var aliasVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-29-[userAlias]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var orientationAgeLocationVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-22.5-[userOrientationAge]-2-[userLocation]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(avatarVerticalConstraints)
        contentView.addConstraints(aliasVerticalConstraints)
        contentView.addConstraints(orientationAgeLocationVerticalConstraints)
        
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
