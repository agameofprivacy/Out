//
//  ActivityExpandedBlurbTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 3/27/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ActivityExpandedBlurbTableViewCell: UITableViewCell {

    var avatarImageView:UIImageView!
    var actionTextView:UITextView!
    var bottomSeparatorView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.bottomSeparatorView = UIView(frame: CGRectZero)
        self.bottomSeparatorView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomSeparatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        self.contentView.addSubview(self.bottomSeparatorView)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.backgroundColor = UIColor.whiteColor()
        self.avatarImageView.image = UIImage(named: "avatarImagePlaceholder")
        self.avatarImageView.opaque = true
        self.contentView.addSubview(self.avatarImageView)

        self.actionTextView = UITextView(frame: CGRectZero)
        self.actionTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.actionTextView.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        self.actionTextView.backgroundColor = UIColor.clearColor()
        self.actionTextView.editable = false
        self.actionTextView.scrollEnabled = false
        self.actionTextView.selectable = false
        self.contentView.addSubview(actionTextView)

        var activityExpandedCellViewsDictionary =
        [
            "avatarImageView":self.avatarImageView,
            "actionTextView":self.actionTextView,
            "bottomSeparatorView":self.bottomSeparatorView
        ]
        
        var activityExpandedCellMetricsDictionary = ["largeVerticalPadding":12]
        
        var horizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[avatarImageView(50)]-12.5-[actionTextView]-7.5-|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var secondHorizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparatorView]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var verticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-16.5-[avatarImageView(50)]->=12-[bottomSeparatorView(1)]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var secondVerticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-14.5-[actionTextView]->=12-[bottomSeparatorView(1)]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        self.contentView.addConstraints(horizontalShadeViewConstraints)
        self.contentView.addConstraints(secondHorizontalShadeViewConstraints)
        self.contentView.addConstraints(verticalShadeViewConstraints)
        self.contentView.addConstraints(secondVerticalShadeViewConstraints)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
