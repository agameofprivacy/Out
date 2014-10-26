//
//  FieldsAndActivatorTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/26/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class FieldsAndActivatorTableViewCell: UITableViewCell {

    var fieldTitle:UILabel!
    var fieldValuePlaceholder:UILabel!

    var sideEdgeMargin = 8
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        fieldTitle = UILabel(frame: CGRectZero)
        fieldTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        fieldTitle.textAlignment = NSTextAlignment.Left
        fieldTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentView.addSubview(fieldTitle)
        
        fieldValuePlaceholder = UILabel(frame: CGRectZero)
        fieldValuePlaceholder.setTranslatesAutoresizingMaskIntoConstraints(false)
        fieldValuePlaceholder.textAlignment = NSTextAlignment.Right
        fieldValuePlaceholder.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        contentView.addSubview(fieldValuePlaceholder)
        
        var viewsDictionary = ["fieldTitle":fieldTitle, "fieldValuePlaceholder":fieldValuePlaceholder]
        var metricsDictionary = ["sideEdgeMargin":sideEdgeMargin]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[fieldTitle]-[fieldValuePlaceholder]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        var verticalFieldTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldTitle(>=36)]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        var verticalValuePlaceholderConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldValuePlaceholder(>=36)]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalFieldTitleConstraints)
        contentView.addConstraints(verticalValuePlaceholderConstraints)
    }
    
    
    
}
