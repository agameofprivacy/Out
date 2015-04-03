//
//  StepMediaTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class StepMediaTableViewCell: UITableViewCell {

    var mediaContextLabel:UILabel!
    var mediaPreviewView:UIView!
    var mediaPreviewImageView:UIImageView!
    var mediaBlurbLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mediaContextLabel = UILabel(frame: CGRectZero)
        self.mediaContextLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(self.mediaContextLabel)
        
        self.mediaPreviewView = UIView(frame: CGRectZero)
        self.mediaPreviewView.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(self.mediaPreviewView)
        
        self.mediaPreviewImageView = UIImageView(frame: CGRectZero)
        self.mediaPreviewImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaPreviewView.addSubview(self.mediaPreviewImageView)
        
        self.mediaBlurbLabel = UILabel(frame: CGRectZero)
        self.mediaBlurbLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaPreviewView.addSubview(self.mediaBlurbLabel)
        
        var viewsDictionary = ["mediaContextLabel":self.mediaContextLabel, "mediaPreviewView":self.mediaPreviewView, "mediaPreviewImageView":self.mediaPreviewImageView, "mediaBlurbLabel":self.mediaBlurbLabel]
        
        var metricsDictinoary = ["sideMargin":15]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[mediaContextLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictinoary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[mediaContextLabel]-6-[mediaPreviewView]-6-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictinoary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
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
