//
//  EventInfoTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class EventInfoTableViewCell: UITableViewCell {

    var eventImage:UIImageView!
    var eventTitle:UILabel!
    var eventVenue:UILabel!
    var eventTimes:UILabel!
    
    let eventImageHeight = 130
    let eventImageWidth = 80
    let horizontalBuffer = 20
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.eventImage = UIImageView(frame: CGRectZero)
        self.eventImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventImage.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(self.eventImage)
        
        self.eventTitle = UILabel(frame: CGRectZero)
        self.eventTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventTitle.textAlignment = NSTextAlignment.Left
        self.eventTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentView.addSubview(self.eventTitle)
        
        self.eventTimes = UILabel(frame: CGRectZero)
        self.eventTimes.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventTimes.textAlignment = NSTextAlignment.Left
        self.eventTimes.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        contentView.addSubview(self.eventTimes)
        
        self.eventVenue = UILabel(frame: CGRectZero)
        self.eventVenue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventVenue.textAlignment = NSTextAlignment.Left
        self.eventVenue.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        contentView.addSubview(self.eventVenue)
        
        var viewsDictionary = ["eventImage":eventImage, "eventTitle":eventTitle, "eventTimes":eventTimes, "eventVenue":eventVenue]
        var metricsDictionary = ["eventImageWidth":eventImageWidth, "eventImageHeight":eventImageHeight, "horizontalBuffer":horizontalBuffer, "labelsTopMargin":14, "shortVerticalBuffer":8]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[eventTitle]-horizontalBuffer-[eventImage(==eventImageWidth)]-|]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var verticalConstraintsEventImage:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[eventImage]-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraintsLabels:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-labelsTopMargin-[eventTitle]-shortVerticalBuffer-[eventVenue]-0-[eventTimes]-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsEventImage)
        contentView.addConstraints(verticalConstraintsLabels)
    }

}
