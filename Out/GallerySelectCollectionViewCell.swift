//
//  GallerySelectCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/20/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class GallerySelectCollectionViewCell: UICollectionViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var imageImageView:UIImageView!
    var titleLabel:UILabel!
    var blurbLabel:UILabel!
    
    let labelInsetH = 24
    let labelInsetV = 18
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageImageView = UIImageView(frame: CGRectZero)
        imageImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageImageView)
        
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        titleLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            titleLabel.preferredMaxLayoutWidth = self.bounds.width - 10
        }
        contentView.addSubview(titleLabel)
        
        blurbLabel = UILabel(frame: CGRectZero)
        blurbLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurbLabel.numberOfLines = 0
        blurbLabel.textAlignment = NSTextAlignment.Left
        blurbLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        blurbLabel.font = UIFont.systemFontOfSize(14.0)
        blurbLabel.preferredMaxLayoutWidth = self.bounds.width
        if UIScreen.mainScreen().bounds.width == 320{
            blurbLabel.preferredMaxLayoutWidth = self.bounds.width - 10
        }
        contentView.addSubview(blurbLabel)
        
        var viewsDictionary = ["imageImageView":imageImageView, "titleLabel":titleLabel, "blurbLabel":blurbLabel]
        var metricsDictioanry = ["labelInsetH":labelInsetH, "labelInsetV":labelInsetV]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=10-[imageImageView]->=10-|", options: NSLayoutFormatOptions(0), metrics: metricsDictioanry, views: viewsDictionary)
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-<=20-[imageImageView(<=240)]-labelInsetV-[titleLabel]-[blurbLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictioanry, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        
    }
}
