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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.senderAvatarImageView.layer.cornerRadius = 25
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
        
        var viewsDictionary = ["senderLabel":self.senderLabel, "receiverLabel":self.receiverLabel, "senderAvatarImageView":self.senderAvatarImageView, "receiverAvatarImageView":self.receiverAvatarImageView, "notificationTypeLabel":self.notificationTypeLabel]
        
        var metricsDictionary = ["sideMargin": 7.5, "verticalMargin":12.5]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[senderAvatarImageView(50)]-[senderLabel]-[notificationTypeLabel]-[receiverLabel]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[senderAvatarImageView(50)]->=verticalMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
