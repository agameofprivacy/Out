//
//  CautionTextTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/18/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class CautionTextTableViewCell: UITableViewCell {

    var cautionTextLabel:UILabel!
    
    var userDataDictionary:[String:String] = ["":""]
    
    var topMargin = 10
    var bottomMargin = 10

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCellSelectionStyle.None

        self.cautionTextLabel = UILabel(frame: CGRectZero)
        self.cautionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.cautionTextLabel.font = titleFont?.fontWithSize(16.0)
        self.cautionTextLabel.numberOfLines = 0
        self.cautionTextLabel.textAlignment = NSTextAlignment.Left
        self.cautionTextLabel.preferredMaxLayoutWidth =  self.bounds.size.width - 8
        if UIScreen.mainScreen().bounds.size.width == 320{
            self.cautionTextLabel.preferredMaxLayoutWidth = self.bounds.size.width - 60
        }
        contentView.addSubview(self.cautionTextLabel)
        
        let viewsDictionary = ["cautionTextLabel":self.cautionTextLabel]
        let metricsDictionary = ["topMargin":topMargin, "bottomMargin":bottomMargin]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cautionTextLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topMargin-[cautionTextLabel]-bottomMargin-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
    }
    
}
