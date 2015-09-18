//
//  ChallengeRecordTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 1/24/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeRecordTableViewCell: UITableViewCell {

    var challengeTypeIconImageView:UIImageView!
    var challengeTitleLabel:UILabel!
    var separatorBottom:UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.separatorBottom = UIView(frame: CGRectZero)
        self.separatorBottom.translatesAutoresizingMaskIntoConstraints = false
        self.separatorBottom.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        self.contentView.addSubview(self.separatorBottom)
        
        self.challengeTypeIconImageView = UIImageView(frame: CGRectZero)
        self.challengeTypeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.challengeTypeIconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.challengeTypeIconImageView.layer.cornerRadius = 18
        self.contentView.addSubview(self.challengeTypeIconImageView)
        
        self.challengeTitleLabel = UILabel(frame: CGRectZero)
        self.challengeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.challengeTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.challengeTitleLabel.numberOfLines = 0
        self.challengeTitleLabel.preferredMaxLayoutWidth = contentView.frame.width - (51 + 8)
        self.contentView.addSubview(self.challengeTitleLabel)
        
        let viewsDictionary = ["challengeTypeIconImageView":self.challengeTypeIconImageView, "challengeTitleLabel":self.challengeTitleLabel, "separatorBottom":self.separatorBottom]
        let metricsDictionary = ["sideMargin": 7.5]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[challengeTypeIconImageView(36)]-15-[challengeTitleLabel]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        let separatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separatorBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=15-[challengeTypeIconImageView(36)]->=15-[separatorBottom(1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(separatorHorizontalConstraints)
        self.contentView.addConstraints(verticalConstraints)
        
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
