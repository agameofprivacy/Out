//
//  PickerFieldsTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/25/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PickerFieldsTableViewCell: UITableViewCell {

    var fieldTitleLabel:UILabel!
    var fieldValueLabel:UILabel!

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)
    
    var horizontalMargin = 20
    var verticalMargin = 16

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.fieldTitleLabel = UILabel(frame: CGRectZero)
        self.fieldTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldTitleLabel.numberOfLines = 1
        self.fieldTitleLabel.textAlignment = NSTextAlignment.Left
        self.fieldTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.fieldTitleLabel.font = titleFont
        self.fieldTitleLabel.text = "Title"
        contentView.addSubview(self.fieldTitleLabel)

        self.fieldValueLabel = UILabel(frame: CGRectZero)
        self.fieldValueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldValueLabel.numberOfLines = 1
        self.fieldValueLabel.textAlignment = NSTextAlignment.Left
        self.fieldValueLabel.font = valueFont
        self.fieldValueLabel.text = "Value"
        contentView.addSubview(self.fieldValueLabel)

        var viewsDictionary = ["fieldTitleLabel":fieldTitleLabel, "fieldValueLabel":fieldValueLabel]
        var metricsDictionary = ["horizontalMargin":horizontalMargin, "verticalMargin":verticalMargin]

        var horizontalConstraintsFields:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[fieldTitleLabel]-[fieldValueLabel]-horizontalMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldTitleLabel]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsValue:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[fieldValueLabel]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraintsFields)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsValue)
        
    }
    
}
