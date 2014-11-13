//
//  ChallengeGalleryTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/20/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeGalleryTableViewCell: UITableViewCell {
    
    let titleLabel:UILabel!
    let separatorLine:UIView!
    let reasonLabel:UILabel!
    let introLabel:UILabel!
    let cardContainerView:UIView!
    
    let cardInsetH =  8
    let cardInsetV =  4
    let labelInsetH = 18
    let labelInsetTop = 24
    let labelInsetBottom = 26

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.cardContainerView = UIView(frame: CGRectZero)
        self.cardContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cardContainerView.layer.cornerRadius = 5
        self.cardContainerView.layer.borderWidth = 1
        self.cardContainerView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor
        self.cardContainerView.backgroundColor = UIColor.whiteColor()

        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        cardContainerView.addSubview(titleLabel)
        
        self.separatorLine = UIView(frame: CGRectZero)
        self.separatorLine.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.separatorLine.backgroundColor = UIColor.blackColor()
        cardContainerView.addSubview(separatorLine)
        
        self.reasonLabel = UILabel(frame: CGRectZero)
        self.reasonLabel.numberOfLines = 0
        self.reasonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.reasonLabel.textAlignment = NSTextAlignment.Left
        self.reasonLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.reasonLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.reasonLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        cardContainerView.addSubview(reasonLabel)
        
        self.introLabel = UILabel(frame: CGRectZero)
        self.introLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.introLabel.textAlignment = NSTextAlignment.Left
        self.introLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.introLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.introLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        self.introLabel.numberOfLines = 0
        cardContainerView.addSubview(introLabel)
        
        contentView.addSubview(self.cardContainerView)

        var viewsDictionary = ["cardContainerView":cardContainerView, "titleLabel":titleLabel, "reasonLabel":reasonLabel, "introLabel":introLabel, "separatorLine":separatorLine]
        var metricsDictionary = ["cardInsetH":cardInsetH, "cardInsetV":cardInsetV, "labelInsetH":labelInsetH, "labelInsetTop":labelInsetTop, "labelInsetBottom":labelInsetBottom]
        
        var labelsConstraints_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-labelInsetH-[titleLabel]-labelInsetH-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var labelsConstraints_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-labelInsetTop-[titleLabel]-0-[separatorLine(==2)]-[reasonLabel]-[introLabel]-labelInsetBottom-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)

        var cardContainerConstraints_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInsetH-[cardContainerView]-cardInsetH-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var cardContainerConstraints_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-cardInsetV-[cardContainerView]-cardInsetV-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        self.cardContainerView.addConstraints(labelsConstraints_H)
        self.cardContainerView.addConstraints(labelsConstraints_V)
        self.contentView.addConstraints(cardContainerConstraints_H)
        self.contentView.addConstraints(cardContainerConstraints_V)

    }
}
