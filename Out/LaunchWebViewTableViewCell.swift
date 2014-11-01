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
    let fontSize:CGFloat = 16.0
    var launchURL:NSURL!

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)

    var userDataDictionary:[String:String] = ["":""]

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default

        self.fieldTitle = UILabel(frame: CGRectZero)
        self.fieldTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldTitle.textAlignment = NSTextAlignment.Left
        self.fieldTitle.font = titleFont?.fontWithSize(fontSize)
        contentView.addSubview(self.fieldTitle)
        
        self.fieldValue = UILabel(frame: CGRectZero)
        self.fieldValue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldValue.textAlignment = NSTextAlignment.Right
        self.fieldValue.font = valueFont?.fontWithSize(fontSize)
        contentView.addSubview(self.fieldValue)
        
        var viewsDictionary = ["fieldTitle":self.fieldTitle, "fieldValue":self.fieldValue]
        var metricsDictionary = ["sideEdgeMargin":8, "verticalMargin":fontSize]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[fieldTitle]-[fieldValue]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldTitle]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsValue:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[fieldValue]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsValue)
        
    }
}
