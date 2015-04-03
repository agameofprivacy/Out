//
//  StepTitleTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class StepTitleTableViewCell: UITableViewCell {

    var stepTitleLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.stepTitleLabel = UILabel(frame: CGRectZero)
        self.stepTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.stepTitleLabel.numberOfLines = 0
        self.stepTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        contentView.addSubview(self.stepTitleLabel)
        
        var viewsDictionary = ["stepTitleLabel":self.stepTitleLabel]
        var metricsDictionary = ["verticalMargin": 6]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[stepTitleLabel]-15-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(horizontalConstraints)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[stepTitleLabel]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
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
