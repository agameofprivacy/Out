//
//  CallTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class CallTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var numberLabel:UILabel!
    
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
        
        self.numberLabel = UILabel(frame: CGRectZero)
        self.numberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.numberLabel.textAlignment = NSTextAlignment.Left
        self.numberLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentView.addSubview(self.numberLabel)
        
        var viewsDictionary = ["titleLabel":self.titleLabel, "numberLabel":self.numberLabel]
        var metricsDictionary = ["sideEdgeMargin":8]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[numberLabel]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsNumber:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[numberLabel]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsNumber)
        
    }
    

}
