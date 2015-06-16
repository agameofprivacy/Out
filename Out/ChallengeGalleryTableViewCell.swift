//
//  ChallengeGalleryTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/20/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeGalleryTableViewCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var separatorLine:UIView!
    var reasonLabel:UILabel!
    var introLabel:UILabel!
    var cardContainerView:UIView!
    
    let cardInsetH =  7.5
    let cardInsetV =  12
    let labelInsetH = 18
    let labelInsetTop = 24
    let labelInsetBottom = 26

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.cardContainerView = UIView(frame: CGRectZero)
        self.cardContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.cardContainerView.layer.cornerRadius = 5
        self.cardContainerView.backgroundColor = UIColor.whiteColor()

        self.cardContainerView.layer.shadowColor = UIColor.blackColor().CGColor
        self.cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.cardContainerView.layer.shadowOpacity = 0.1
        self.cardContainerView.layer.shadowRadius = 1
        self.cardContainerView.layer.cornerRadius = 5
        self.cardContainerView.layer.borderWidth = 0.75
        self.cardContainerView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.25).CGColor

        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        cardContainerView.addSubview(titleLabel)
        
        self.separatorLine = UIView(frame: CGRectZero)
        self.separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.separatorLine.backgroundColor = UIColor.blackColor()
        cardContainerView.addSubview(separatorLine)
        
        self.reasonLabel = UILabel(frame: CGRectZero)
        self.reasonLabel.numberOfLines = 0
        self.reasonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.reasonLabel.textAlignment = NSTextAlignment.Left
        self.reasonLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.reasonLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.reasonLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        cardContainerView.addSubview(reasonLabel)
        
        self.introLabel = UILabel(frame: CGRectZero)
        self.introLabel.translatesAutoresizingMaskIntoConstraints = false
        self.introLabel.textAlignment = NSTextAlignment.Left
        self.introLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.introLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            self.introLabel.preferredMaxLayoutWidth = self.bounds.width - 64
        }
        self.introLabel.numberOfLines = 0
        cardContainerView.addSubview(introLabel)
        
        contentView.addSubview(self.cardContainerView)

        let viewsDictionary = ["cardContainerView":cardContainerView, "titleLabel":titleLabel, "reasonLabel":reasonLabel, "introLabel":introLabel, "separatorLine":separatorLine]
        let metricsDictionary = ["cardInsetH":cardInsetH, "cardInsetV":cardInsetV, "labelInsetH":labelInsetH, "labelInsetTop":labelInsetTop, "labelInsetBottom":labelInsetBottom]
        
        let labelsConstraints_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-labelInsetH-[titleLabel]-labelInsetH-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)
        let labelsConstraints_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-labelInsetTop-[titleLabel]-0-[separatorLine(==2)]-[reasonLabel]-[introLabel]-labelInsetBottom-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)

        let cardContainerConstraints_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInsetH-[cardContainerView]-cardInsetH-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)
        let cardContainerConstraints_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cardContainerView]-cardInsetV-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)

        self.cardContainerView.addConstraints(labelsConstraints_H)
        self.cardContainerView.addConstraints(labelsConstraints_V)
        self.contentView.addConstraints(cardContainerConstraints_H)
        self.contentView.addConstraints(cardContainerConstraints_V)

    }
}
