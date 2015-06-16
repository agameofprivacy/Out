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
    let fontSize:CGFloat = 16.0
    var userDataDictionary:[String:String] = ["":""]

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        
        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = titleFont?.fontWithSize(fontSize)
        contentView.addSubview(self.titleLabel)
        
        self.numberLabel = UILabel(frame: CGRectZero)
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numberLabel.textAlignment = NSTextAlignment.Left
        self.numberLabel.font = valueFont?.fontWithSize(fontSize)
        contentView.addSubview(self.numberLabel)
        
        let viewsDictionary = ["titleLabel":self.titleLabel, "numberLabel":self.numberLabel]
        let metricsDictionary = ["sideEdgeMargin":8, "verticalMargin":fontSize]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[numberLabel]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[titleLabel]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraintsNumber:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[numberLabel]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsNumber)
        
    }
    

}
