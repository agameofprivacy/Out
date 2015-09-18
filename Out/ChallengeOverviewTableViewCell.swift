//
//  ChallengeOverviewTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeOverviewTableViewCell: UITableViewCell {
    
    var challengeIntro:UILabel!
    var stepTitles:UILabel!
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        self.challengeIntro = UILabel(frame: CGRectZero)
        self.challengeIntro.numberOfLines = 0
        self.challengeIntro.translatesAutoresizingMaskIntoConstraints = false
        self.challengeIntro.textAlignment = NSTextAlignment.Left
        self.challengeIntro.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.challengeIntro.preferredMaxLayoutWidth = self.bounds.width - 10
        if UIScreen.mainScreen().bounds.width == 320{
            self.challengeIntro.preferredMaxLayoutWidth = self.bounds.width - 72
        }

        contentView.addSubview(challengeIntro)
        
        self.stepTitles = UILabel(frame: CGRectZero)
        self.stepTitles.numberOfLines = 0
        self.stepTitles.translatesAutoresizingMaskIntoConstraints = false
        self.stepTitles.textAlignment = NSTextAlignment.Left
        self.stepTitles.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.stepTitles.preferredMaxLayoutWidth = self.bounds.width - 10
        if UIScreen.mainScreen().bounds.width == 320{
            self.stepTitles.preferredMaxLayoutWidth = self.bounds.width - 72
        }
        contentView.addSubview(stepTitles)
        
        let viewsDictionary = ["challengeIntro":challengeIntro, "stepTitles":stepTitles]
        let metricsDictionary = ["mediumVerticalSpace":14, "longVerticalSpace":20]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeIntro]->=8-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-mediumVerticalSpace-[challengeIntro]-longVerticalSpace-[stepTitles]->=0-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        
    }


}
