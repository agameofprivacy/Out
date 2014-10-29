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

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    let fontSize:CGFloat = 16.0
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
                
        self.eventTitle = UILabel(frame: CGRectZero)
        self.eventTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventTitle.textAlignment = NSTextAlignment.Left
        self.eventTitle.numberOfLines = 0
        self.eventTitle.font = titleFont?.fontWithSize(17.0)
        self.eventTitle.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.eventTitle.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        contentView.addSubview(self.eventTitle)
        
        self.eventTimes = UILabel(frame: CGRectZero)
        self.eventTimes.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventTimes.textAlignment = NSTextAlignment.Left
        self.eventTimes.numberOfLines = 0
        self.eventTimes.font = valueFont?.fontWithSize(15.0)
        self.eventTimes.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.eventTimes.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        contentView.addSubview(self.eventTimes)
        
        self.eventVenue = UILabel(frame: CGRectZero)
        self.eventVenue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.eventVenue.textAlignment = NSTextAlignment.Left
        self.eventVenue.numberOfLines = 0
        self.eventVenue.font = valueFont?.fontWithSize(15.0)
        self.eventVenue.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.eventVenue.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        contentView.addSubview(self.eventVenue)
        
        var viewsDictionary = ["eventTitle":eventTitle, "eventTimes":eventTimes, "eventVenue":eventVenue]
        var metricsDictionary = ["labelsTopMargin":14, "shortVerticalBuffer":4]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[eventTitle]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        
        var verticalConstraintsLabels:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[eventTitle]-0-[eventTimes]-shortVerticalBuffer-[eventVenue]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraintsLabels)
    }

}
