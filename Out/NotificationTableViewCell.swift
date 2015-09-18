//
//  NotificationTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 2/16/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    var senderAvatarImageView:UIImageView!
    var timeLabel:UILabel!
    var separatorView:UIView!
    var notificationTextView:UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        self.senderAvatarImageView = UIImageView(frame: CGRectZero)
        self.senderAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.senderAvatarImageView.layer.cornerRadius = 20
        self.senderAvatarImageView.image = UIImage(named: "bear-icon")
        self.senderAvatarImageView.backgroundColor = UIColor.grayColor()
        contentView.addSubview(self.senderAvatarImageView)
        
        self.timeLabel = UILabel(frame: CGRectZero)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.timeLabel.textColor = UIColor(white: 0.5, alpha: 1)
        self.timeLabel.text = "ago"
        contentView.addSubview(self.timeLabel)
        
        self.separatorView = UIView(frame: CGRectZero)
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.separatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        contentView.addSubview(self.separatorView)
        
        self.notificationTextView = UITextView()
        self.notificationTextView.translatesAutoresizingMaskIntoConstraints = false
        self.notificationTextView.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        self.notificationTextView.editable = false
        self.notificationTextView.scrollEnabled = false
        self.notificationTextView.selectable = false
        self.notificationTextView.userInteractionEnabled = false
        self.notificationTextView.backgroundColor = UIColor.clearColor()
        self.notificationTextView.textContainerInset = UIEdgeInsetsZero
//        self.notificationTextView.textContainer.lineFragmentPadding = 0
//        self.notificationTextView.textContainerInset = UIEdgeInsetsZero
        contentView.addSubview(self.notificationTextView)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        let viewsDictionary = ["senderAvatarImageView":self.senderAvatarImageView, "notificationTextView":self.notificationTextView, "separatorView":self.separatorView, "timeLabel":self.timeLabel]
        
        let metricsDictionary = ["sideMargin": 12.5, "verticalMargin":14]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[senderAvatarImageView(40)]-10-[notificationTextView]-12.5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let secondHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let thirdHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[senderAvatarImageView(40)]-15-[timeLabel]-15-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)

        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[senderAvatarImageView(40)]", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let thirdVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[notificationTextView(>=0)]-5-[timeLabel]-15-[separatorView(1)]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(secondHorizontalConstraints)
        contentView.addConstraints(thirdHorizontalConstraints)

        contentView.addConstraints(verticalConstraints)
        contentView.addConstraints(thirdVerticalConstraints)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
