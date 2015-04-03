//
//  StepBlurbTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class StepBlurbTableViewCell: UITableViewCell {

    var stepBlurbLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.stepBlurbLabel = UILabel(frame: CGRectZero)
        self.stepBlurbLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.stepBlurbLabel.numberOfLines = 0
        self.stepBlurbLabel.font = UIFont(name: "HelveticaNeue", size: 13)
//        self.stepBlurbLabel.preferredMaxLayoutWidth = 345
        contentView.addSubview(self.stepBlurbLabel)
        
        var viewsDictionary = ["stepBlurbLabel":self.stepBlurbLabel]
        var metricsDictionary = ["sideMargin": 15]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[stepBlurbLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[stepBlurbLabel]-6-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
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
