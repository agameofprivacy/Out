//
//  DashboardWhatsNewCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class DashboardWhatsNewCollectionViewCell: UICollectionViewCell {
    
    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var roleLabel:UILabel!
    var alertCountView:UIView!
    var alertCountLabel:UILabel!
    var alertTypeLabel:UILabel!
    var alertSeparator:UIView!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.clearColor()
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.contentView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.aliasLabel.font = regularFont?.fontWithSize(14.0)
        self.contentView.addSubview(self.aliasLabel)
        
        self.roleLabel = UILabel(frame: CGRectZero)
        self.roleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.roleLabel.textAlignment = NSTextAlignment.Left
        self.roleLabel.font = regularFont?.fontWithSize(14.0)
        self.roleLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.contentView.addSubview(self.roleLabel)
        
        self.alertCountView = UIView(frame: CGRectZero)
        self.alertCountView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertCountView.layer.cornerRadius = 18
        self.alertCountView.clipsToBounds = true
        self.alertCountView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        self.contentView.addSubview(self.alertCountView)
        
        self.alertCountLabel = UILabel(frame: CGRectZero)
        self.alertCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertCountLabel.textAlignment = NSTextAlignment.Center
        self.alertCountLabel.textColor = UIColor.whiteColor()
        self.alertCountLabel.font = regularFont?.fontWithSize(16.0)
        self.alertCountView.addSubview(self.alertCountLabel)
        
        self.alertTypeLabel = UILabel(frame: CGRectZero)
        self.alertTypeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertTypeLabel.textAlignment = NSTextAlignment.Left
        self.alertTypeLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.alertTypeLabel.font = regularFont?.fontWithSize(14.0)
        self.contentView.addSubview(self.alertTypeLabel)
        
        self.alertSeparator = UIView(frame: CGRectZero)
        self.alertSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.contentView.addSubview(self.alertSeparator)
        
        
        var viewsDictionary = ["avatarImageView":self.avatarImageView, "aliasLabel":self.aliasLabel, "roleLabel":self.roleLabel, "alertCountView":self.alertCountView, "alertCountLabel":self.alertCountLabel, "alertTypeLabel":self.alertTypeLabel, "alertSeparator":self.alertSeparator]
        
        var metricsDictionary = ["inBetweenPadding":18]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(50)]-inBetweenPadding-[aliasLabel]-<=40-[alertCountView(36)]-[alertTypeLabel]->=inBetweenPadding-[alertSeparator(1)]->=10-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalAvatarConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[avatarImageView(50)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalAliasConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[aliasLabel]-2-[roleLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalAlertCountViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-9-[alertCountView(36)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalAlertTypeConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-17-[alertTypeLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalAlertSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-9-[alertSeparator(36)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        // layout alertCountView
        
        var alertCountViewViewsDictionary = ["alertCountLabel":self.alertCountLabel]
        var alertCountViewMetricsDictionary = ["sideMargin":10]
        
        var horizontalAlertCountViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[alertCountLabel]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: alertCountViewMetricsDictionary, views: alertCountViewViewsDictionary)
        
        var verticalAlertCountViewViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[alertCountLabel]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: alertCountViewMetricsDictionary, views: alertCountViewViewsDictionary)
        
        self.alertCountView.addConstraints(horizontalAlertCountViewConstraints)
        self.alertCountView.addConstraints(verticalAlertCountViewViewConstraints)

        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalAvatarConstraints)
        self.contentView.addConstraints(verticalAliasConstraints)
        self.contentView.addConstraints(verticalAlertCountViewConstraints)
        self.contentView.addConstraints(verticalAlertTypeConstraints)
        self.contentView.addConstraints(verticalAlertSeparatorConstraints)
        
        
    }
}
