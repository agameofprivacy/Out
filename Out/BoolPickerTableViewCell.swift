//
//  BoolPickerTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class BoolPickerTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var switchControl:UISwitch!
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentView.addSubview(self.titleLabel)
        
        self.switchControl = UISwitch(frame: CGRectZero)
        self.switchControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.switchControl.on = false
        contentView.addSubview(self.switchControl)
        
        var viewsDictionary = ["titleLabel":self.titleLabel, "switchControl":self.switchControl]
        var metricsDictionary = ["sideEdgeMargin":8]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[switchControl]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsLabel:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsSwitch:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[switchControl]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsLabel)
        contentView.addConstraints(verticalConstraintsSwitch)
    }
    
}
