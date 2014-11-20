//
//  BoolPickerTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class BoolPickerTableViewCell: UITableViewCell, CollectStepData {

    var titleLabel:UILabel!
    var switchControl:UISwitch!
    var key:String!
    
    let fontSize:CGFloat = 16.0
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None

        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = titleFont?.fontWithSize(fontSize)
        contentView.addSubview(self.titleLabel)
        
        self.switchControl = UISwitch(frame: CGRectZero)
        self.switchControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.switchControl.on = false
        contentView.addSubview(self.switchControl)
        
        var viewsDictionary = ["titleLabel":self.titleLabel, "switchControl":self.switchControl]
        var metricsDictionary = ["sideEdgeMargin":8, "verticalMargin":fontSize]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[switchControl]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsLabel:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[titleLabel]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsSwitch:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[switchControl]-verticalMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsLabel)
        contentView.addConstraints(verticalConstraintsSwitch)
    }

    func collectData() -> [String : String] {
        var boolValue = ""
        if self.switchControl.on {
            boolValue = "on"
        }
        else{
            boolValue = "off"
        }
        
        self.userDataDictionary = [key:boolValue]
        return userDataDictionary
    }
}
