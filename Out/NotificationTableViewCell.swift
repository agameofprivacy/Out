//
//  NotificationTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 2/16/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    var senderLabel:UILabel!
    var receiverLabel:UILabel!
    var notificationTypeLabel:UILabel!
    var senderAvatarImageView:UIImageView!
    var receiverAvatarImageView:UIImageView!
    var timeLabel:UILabel!
    var separatorView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.senderLabel = UILabel(frame: CGRectZero)
        self.senderLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.senderLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.senderLabel.text = "Sender"
        contentView.addSubview(self.senderLabel)
        
        self.receiverLabel = UILabel(frame: CGRectZero)
        self.receiverLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.receiverLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.receiverLabel.text = "Receiver"
        contentView.addSubview(self.receiverLabel)
        
        self.senderAvatarImageView = UIImageView(frame: CGRectZero)
        self.senderAvatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.senderAvatarImageView.layer.cornerRadius = 16
        self.senderAvatarImageView.image = UIImage(named: "bear-icon")
        self.senderAvatarImageView.backgroundColor = UIColor.grayColor()
        contentView.addSubview(self.senderAvatarImageView)
        
        self.receiverAvatarImageView = UIImageView(frame: CGRectZero)
        self.receiverAvatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.receiverAvatarImageView.layer.cornerRadius = 10
        self.receiverAvatarImageView.backgroundColor = UIColor.blackColor()
        contentView.addSubview(self.receiverAvatarImageView)
        
        self.notificationTypeLabel = UILabel(frame: CGRectZero)
        self.notificationTypeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.notificationTypeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.notificationTypeLabel.text = "Notification Type"
        contentView.addSubview(self.notificationTypeLabel)
        
        self.timeLabel = UILabel(frame: CGRectZero)
        self.timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.timeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        self.timeLabel.text = "ago"
        contentView.addSubview(self.timeLabel)
        
        self.separatorView = UIView(frame: CGRectZero)
        self.separatorView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.separatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        contentView.addSubview(self.separatorView)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        var viewsDictionary = ["senderLabel":self.senderLabel, "receiverLabel":self.receiverLabel, "senderAvatarImageView":self.senderAvatarImageView, "receiverAvatarImageView":self.receiverAvatarImageView, "notificationTypeLabel":self.notificationTypeLabel, "separatorView":self.separatorView, "timeLabel":self.timeLabel]
        
        var metricsDictionary = ["sideMargin": 7.5, "verticalMargin":18]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[senderAvatarImageView(32)]-[senderLabel]-[notificationTypeLabel]-[receiverLabel]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var secondHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separatorView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var thirdHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[receiverLabel]-[timeLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[senderAvatarImageView(32)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var secondVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[senderAvatarImageView(32)]-verticalMargin-[separatorView(1)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var thirdVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-14-[timeLabel]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(secondHorizontalConstraints)
        contentView.addConstraints(thirdHorizontalConstraints)
        
        contentView.addConstraints(verticalConstraints)
        contentView.addConstraints(secondVerticalConstraints)
        contentView.addConstraints(thirdVerticalConstraints)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
