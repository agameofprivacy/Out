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
    let fontSize:CGFloat = 16
    
    var sideEdgeMargin = 8
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        
        fieldTitle = UILabel(frame: CGRectZero)
        fieldTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        fieldTitle.textAlignment = NSTextAlignment.Left
        fieldTitle.font = self.titleFont?.fontWithSize(fontSize)
        contentView.addSubview(fieldTitle)
        
        fieldValuePlaceholder = UILabel(frame: CGRectZero)
        fieldValuePlaceholder.setTranslatesAutoresizingMaskIntoConstraints(false)
        fieldValuePlaceholder.textAlignment = NSTextAlignment.Right
        fieldValuePlaceholder.font = self.valueFont?.fontWithSize(fontSize)
        contentView.addSubview(fieldValuePlaceholder)
        
        var viewsDictionary = ["fieldTitle":fieldTitle, "fieldValuePlaceholder":fieldValuePlaceholder]
        var metricsDictionary = ["sideEdgeMargin":sideEdgeMargin, "verticalMargin":fontSize]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[fieldTitle]-[fieldValuePlaceholder]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary as [NSObject : AnyObject], views: viewsDictionary)
        var verticalFieldTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldTitle]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary as? [NSObject : AnyObject], views: viewsDictionary)
        var verticalValuePlaceholderConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldValuePlaceholder]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary as? [NSObject : AnyObject], views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalFieldTitleConstraints)
        contentView.addConstraints(verticalValuePlaceholderConstraints)
    }
    
    
    
}
