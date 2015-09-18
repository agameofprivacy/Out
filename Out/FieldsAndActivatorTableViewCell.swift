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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        
        fieldTitle = UILabel(frame: CGRectZero)
        fieldTitle.translatesAutoresizingMaskIntoConstraints = false
        fieldTitle.textAlignment = NSTextAlignment.Left
        fieldTitle.font = self.titleFont?.fontWithSize(fontSize)
        contentView.addSubview(fieldTitle)
        
        fieldValuePlaceholder = UILabel(frame: CGRectZero)
        fieldValuePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        fieldValuePlaceholder.textAlignment = NSTextAlignment.Right
        fieldValuePlaceholder.font = self.valueFont?.fontWithSize(fontSize)
        contentView.addSubview(fieldValuePlaceholder)
        
        let viewsDictionary = ["fieldTitle":fieldTitle, "fieldValuePlaceholder":fieldValuePlaceholder]
        let metricsDictionary = ["sideEdgeMargin":sideEdgeMargin, "verticalMargin":fontSize]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[fieldTitle]-[fieldValuePlaceholder]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)
        let verticalFieldTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldTitle]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)
        let verticalValuePlaceholderConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldValuePlaceholder]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary as? [String : AnyObject], views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalFieldTitleConstraints)
        contentView.addConstraints(verticalValuePlaceholderConstraints)
    }
    
    
    
}
