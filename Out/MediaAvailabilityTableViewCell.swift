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

    let labelMarginFromCellEdge =  20
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        
        mediaPreview = UIImageView(frame: CGRectZero)
        mediaPreview.setTranslatesAutoresizingMaskIntoConstraints(false)
        mediaPreview.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(mediaPreview)
        
        mediaTitle = UILabel(frame: CGRectZero)
        self.mediaTitle.numberOfLines = 0
        mediaTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaTitle.textAlignment = NSTextAlignment.Left
        self.mediaTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.mediaTitle.preferredMaxLayoutWidth = self.bounds.width - 80
        contentView.addSubview(mediaTitle)

        mediaVenue = UILabel(frame: CGRectZero)
        self.mediaVenue.numberOfLines = 0
        mediaVenue.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaVenue.textAlignment = NSTextAlignment.Left
        self.mediaVenue.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.mediaVenue.preferredMaxLayoutWidth = self.bounds.width - 80
        contentView.addSubview(mediaVenue)
        
        mediaTimes = UILabel(frame: CGRectZero)
        self.mediaTimes.numberOfLines = 0
        mediaTimes.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaTimes.textAlignment = NSTextAlignment.Left
        self.mediaTimes.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.mediaTimes.preferredMaxLayoutWidth = self.bounds.width - 80
        contentView.addSubview(mediaTimes)
        
        mediaIntro = UILabel(frame: CGRectZero)
        self.mediaIntro.numberOfLines = 0
        mediaIntro.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaIntro.textAlignment = NSTextAlignment.Left
        self.mediaIntro.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
//        contentView.addSubview(mediaIntro)

        
        let viewsDictionary = ["mediaPreview":mediaPreview, "mediaTitle":mediaTitle, "mediaTimes":mediaTimes, "mediaVenue":mediaVenue, "mediaIntro":mediaIntro]
        
        let metricsDictionary = ["hSpaceFromCellEdge": labelMarginFromCellEdge, "longVerticalSpace": (labelMarginFromCellEdge - 6) * 1, "bottomSpaceFromCellEdge":CGFloat(labelMarginFromCellEdge - 3) * 1.2, "shortVerticalSpace": 4]
        
        let mediaPreviewLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[mediaPreview(==80)]-hSpaceFromCellEdge-[mediaTitle(>=0)]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        let mediaPreview_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[mediaPreview(<=130)]->=bottomSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)

        let labels_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-longVerticalSpace-[mediaTitle]-shortVerticalSpace-[mediaVenue(>=0)]-longVerticalSpace-[mediaTimes]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(labels_constraint_V)
        contentView.addConstraints(mediaPreview_constraint_V)
        contentView.addConstraints(mediaPreviewLabel_constraint_H)

    }


}
