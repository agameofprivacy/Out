//
//  LaunchWebViewTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class LaunchWebViewTableViewCell: UITableViewCell {

    var fieldTitle:UILabel!
    var fieldValue:UILabel!
    
    var userDataDictionary:[String:String] = ["":""]

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.fieldTitle = UILabel(frame: CGRectZero)
        self.fieldTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldTitle.textAlignment = NSTextAlignment.Left
        self.fieldTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentView.addSubview(self.fieldTitle)
        
        self.fieldValue = UILabel(frame: CGRectZero)
        self.fieldValue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldValue.textAlignment = NSTextAlignment.Right
        self.fieldValue.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        contentView.addSubview(self.fieldValue)
        
        var viewsDictionary = ["fieldTitle":self.fieldTitle, "fieldValue":self.fieldValue]
        var metricsDictionary = ["sideEdgeMargin":8]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[fieldTitle]-[fieldValue]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldTitle]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsValue:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldValue]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsValue)
        
    }
}
