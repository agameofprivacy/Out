//
//  MediaAvailabilityTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/16/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MediaAvailabilityTableViewCell: UITableViewCell {

    let mediaPreview:UIImageView!
    let mediaTitle:UILabel!
    let mediaTimes:UILabel!
    let mediaVenue:UILabel!
    let mediaIntro:UILabel!

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    let labelMarginFromCellEdge =  20
    
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        self.mediaPreview = UIImageView(frame: CGRectZero)
        self.mediaPreview.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaPreview.contentMode = UIViewContentMode.ScaleAspectFill
        self.mediaPreview.clipsToBounds = true
        self.mediaPreview.layer.cornerRadius = 5
        contentView.addSubview(self.mediaPreview)
        
        self.mediaTitle = UILabel(frame: CGRectZero)
        self.mediaTitle.numberOfLines = 0
        self.mediaTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaTitle.textAlignment = NSTextAlignment.Left
        self.mediaTitle.font = titleFont?.fontWithSize(17.0)
        self.mediaTitle.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.mediaTitle.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        contentView.addSubview(self.mediaTitle)

        self.mediaVenue = UILabel(frame: CGRectZero)
        self.mediaVenue.numberOfLines = 0
        self.mediaVenue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaVenue.textAlignment = NSTextAlignment.Left
        self.mediaVenue.font = titleFont?.fontWithSize(15.0)
        self.mediaVenue.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.mediaVenue.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        contentView.addSubview(self.mediaVenue)
        
        self.mediaTimes = UILabel(frame: CGRectZero)
        self.mediaTimes.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaTimes.textAlignment = NSTextAlignment.Left
        self.mediaTimes.font = titleFont?.fontWithSize(14.0)
        self.mediaTimes.preferredMaxLayoutWidth = self.bounds.width - 136
        if UIScreen.mainScreen().bounds.width == 320{
            self.mediaTimes.preferredMaxLayoutWidth = self.bounds.width - 139
        }
        self.mediaTimes.numberOfLines = 0
        contentView.addSubview(self.mediaTimes)
        
        
        let viewsDictionary = ["mediaPreview":mediaPreview, "mediaTitle":mediaTitle, "mediaTimes":mediaTimes, "mediaVenue":mediaVenue]
        
        let metricsDictionary = ["hSpaceFromCellEdge": labelMarginFromCellEdge - 2, "longVerticalSpace": labelMarginFromCellEdge - 6, "bottomSpaceFromCellEdge":CGFloat(labelMarginFromCellEdge - 8), "mediumVerticalSpace":labelMarginFromCellEdge - 12, "shortVerticalSpace": 6]
        
        let mediaPreviewLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[mediaPreview(==90)]-hSpaceFromCellEdge-[mediaTitle]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        let mediaPreview_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[mediaPreview(==130)]->=bottomSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)

        let labels_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[mediaTitle]-mediumVerticalSpace-[mediaVenue]-shortVerticalSpace-[mediaTimes]->=bottomSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(labels_constraint_V)
        contentView.addConstraints(mediaPreview_constraint_V)
        contentView.addConstraints(mediaPreviewLabel_constraint_H)

    }


}
