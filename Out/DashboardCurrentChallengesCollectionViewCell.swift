//
//  DashboardCurrentChallengesCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class DashboardCurrentChallengesCollectionViewCell: UICollectionViewCell {
    
    var tagLabel:UILabel!
    var challengeTitleLabel:UILabel!
    var challengeTitleSeparator:UIView!
    var currentStepTitleLabel:UILabel!
    var currentStepBlurbLabel:UILabel!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 1

        self.backgroundColor = UIColor.whiteColor()
        
        self.tagLabel = UILabel(frame: CGRectZero)
        self.tagLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tagLabel.textAlignment = NSTextAlignment.Left
        self.tagLabel.font = regularFont?.fontWithSize(15.0)
        self.tagLabel.textColor = UIColor.whiteColor()
        self.tagLabel.backgroundColor = UIColor.blackColor()
        self.tagLabel.layer.cornerRadius = 5
        self.tagLabel.clipsToBounds = true
        self.contentView.addSubview(self.tagLabel)
        
        self.challengeTitleLabel = UILabel(frame: CGRectZero)
        self.challengeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeTitleLabel.textAlignment = NSTextAlignment.Left
        self.challengeTitleLabel.font = regularFont?.fontWithSize(15.0)
        self.challengeTitleLabel.numberOfLines = 1
        self.contentView.addSubview(self.challengeTitleLabel)
        
        self.challengeTitleSeparator = UIView(frame: CGRectZero)
        self.challengeTitleSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeTitleSeparator.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(self.challengeTitleSeparator)
        
        self.currentStepTitleLabel = UILabel(frame: CGRectZero)
        self.currentStepTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentStepTitleLabel.textAlignment = NSTextAlignment.Left
        self.currentStepTitleLabel.font = regularFont?.fontWithSize(14.0)
        self.currentStepTitleLabel.numberOfLines = 1
        self.contentView.addSubview(self.currentStepTitleLabel)
        
        self.currentStepBlurbLabel = UILabel(frame: CGRectZero)
        self.currentStepBlurbLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentStepBlurbLabel.textAlignment = NSTextAlignment.Left
        self.currentStepBlurbLabel.font = valueFont?.fontWithSize(14.0)
        self.currentStepBlurbLabel.numberOfLines = 0
        self.contentView.addSubview(self.currentStepBlurbLabel)
        
        // layout constraints
        
        var viewsDictionary = ["tagLabel":self.tagLabel,"challengeTitleLabel":self.challengeTitleLabel, "challengeTitleSeparator":self.challengeTitleSeparator, "currentStepTitleLabel":self.currentStepTitleLabel,"currentStepBlurbLabel":self.currentStepBlurbLabel]
        
        var metricsDictionary = ["cardSideInset": 10, "cardTopInset":15, "cardBottomInset":15]
        
        var horizontalTagsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[tagLabel]->=cardSideInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardSideInset-[challengeTitleSeparator]-cardSideInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardSideInset-[challengeTitleLabel]-cardSideInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var verticalTagConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-cardTopInset-[tagLabel(25)]-10-[challengeTitleLabel]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[challengeTitleLabel]-4-[challengeTitleSeparator(1)]-4-[currentStepTitleLabel]-[currentStepBlurbLabel]->=cardBottomInset-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        self.contentView.addConstraints(horizontalTagsConstraints)
        self.contentView.addConstraints(horizontalSeparatorConstraints)
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalTagConstraints)
        self.contentView.addConstraints(verticalConstraints)

    }
}
