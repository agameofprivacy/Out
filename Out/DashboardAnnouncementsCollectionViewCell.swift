//
//  DashboardWhatsNewCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// View class for dhasboard announcements collection view cell
class DashboardAnnouncementsCollectionViewCell: UICollectionViewCell {
    
    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var roleLabel:UILabel!
    var alertCountView:UIView!
    var alertCountLabel:UILabel!
    var alertTypeLabel:UILabel!
    var alertSeparator:UIView!
    
    // UIFont init
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.backgroundColor = UIColor.clearColor()
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.contentView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.translatesAutoresizingMaskIntoConstraints = false
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.aliasLabel.font = titleFont?.fontWithSize(14.0)
        self.contentView.addSubview(self.aliasLabel)
        
        self.roleLabel = UILabel(frame: CGRectZero)
        self.roleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.roleLabel.textAlignment = NSTextAlignment.Left
        self.roleLabel.font = regularFont?.fontWithSize(14.0)
        self.roleLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.contentView.addSubview(self.roleLabel)
        
        self.alertCountView = UIView(frame: CGRectZero)
        self.alertCountView.translatesAutoresizingMaskIntoConstraints = false
        self.alertCountView.layer.cornerRadius = 18
        self.alertCountView.clipsToBounds = true
        self.alertCountView.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(self.alertCountView)
        
        self.alertCountLabel = UILabel(frame: CGRectZero)
        self.alertCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.alertCountLabel.textAlignment = NSTextAlignment.Center
        self.alertCountLabel.textColor = UIColor.whiteColor()
        self.alertCountLabel.font = regularFont?.fontWithSize(16.0)
        self.alertCountView.addSubview(self.alertCountLabel)
        
        self.alertTypeLabel = UILabel(frame: CGRectZero)
        self.alertTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.alertTypeLabel.textAlignment = NSTextAlignment.Left
        self.alertTypeLabel.textColor = UIColor.blackColor()
        self.alertTypeLabel.font = regularFont?.fontWithSize(14.0)
        self.contentView.addSubview(self.alertTypeLabel)
        
        let viewsDictionary = ["avatarImageView":self.avatarImageView, "aliasLabel":self.aliasLabel, "roleLabel":self.roleLabel, "alertCountView":self.alertCountView, "alertCountLabel":self.alertCountLabel, "alertTypeLabel":self.alertTypeLabel]
        
        let metricsDictionary = ["inBetweenPadding":18]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(50)]-inBetweenPadding-[aliasLabel]->=0-[alertCountView(36)]-[alertTypeLabel]->=inBetweenPadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalAvatarConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[avatarImageView(50)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalAliasConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[aliasLabel]-2-[roleLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalAlertCountViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-7-[alertCountView(36)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalAlertTypeConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[alertTypeLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        // layout alertCountView
        let alertCountViewViewsDictionary = ["alertCountLabel":self.alertCountLabel]
        let alertCountViewMetricsDictionary = ["sideMargin":10]
        
        let horizontalAlertCountViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[alertCountLabel]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: alertCountViewMetricsDictionary, views: alertCountViewViewsDictionary)
        
        let verticalAlertCountViewViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[alertCountLabel]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: alertCountViewMetricsDictionary, views: alertCountViewViewsDictionary)
        
        self.alertCountView.addConstraints(horizontalAlertCountViewConstraints)
        self.alertCountView.addConstraints(verticalAlertCountViewViewConstraints)
        
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(verticalAvatarConstraints)
        self.contentView.addConstraints(verticalAliasConstraints)
        self.contentView.addConstraints(verticalAlertCountViewConstraints)
        self.contentView.addConstraints(verticalAlertTypeConstraints)

    }
}
