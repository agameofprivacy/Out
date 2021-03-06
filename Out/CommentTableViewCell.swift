//
//  CommentTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/13/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var commentLabel:UILabel!
    var timeAgoLabel:UILabel!
    var separator:UIView!
    
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.translatesAutoresizingMaskIntoConstraints = false
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.aliasLabel.font = titleFont?.fontWithSize(14.0)
        self.aliasLabel.numberOfLines = 1
        self.contentView.addSubview(self.aliasLabel)
        
        self.timeAgoLabel = UILabel(frame: CGRectZero)
        self.timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeAgoLabel.textAlignment = NSTextAlignment.Right
        self.timeAgoLabel.font = regularFont?.fontWithSize(14.0)
        self.timeAgoLabel.numberOfLines = 1
        self.contentView.addSubview(self.timeAgoLabel)

        self.commentLabel = UILabel(frame: CGRectZero)
        self.commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.commentLabel.textAlignment = NSTextAlignment.Left
        self.commentLabel.font = valueFont?.fontWithSize(14.0)
        self.commentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 100
        self.commentLabel.numberOfLines = 0
        self.contentView.addSubview(self.commentLabel)
        
        self.separator = UIView(frame: CGRectZero)
        self.separator.translatesAutoresizingMaskIntoConstraints = false
        self.separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        self.contentView.addSubview(self.separator)
        
        
        let viewsDictionary = ["avatarImageView":self.avatarImageView, "aliasLabel":self.aliasLabel, "commentLabel":self.commentLabel, "timeAgoLabel":self.timeAgoLabel, "separator":self.separator]
        let metricsDictionary = ["sideMargin":7.5, "inBetweenMargin":15]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[avatarImageView(50)]-inBetweenMargin-[aliasLabel]-[timeAgoLabel]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)

        let horizontalCommentConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[avatarImageView(50)]-inBetweenMargin-[commentLabel]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)

        
        let horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[separator]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[avatarImageView(50)]", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalLabelsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[aliasLabel]-4-[commentLabel]->=25-[separator(1)]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalTimeAgoConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[timeAgoLabel]", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        self.contentView.addConstraints(horizontalConstraints)
        self.contentView.addConstraints(horizontalCommentConstraints)
        self.contentView.addConstraints(verticalConstraints)
        self.contentView.addConstraints(verticalLabelsConstraints)
        self.contentView.addConstraints(verticalTimeAgoConstraints)
        self.contentView.addConstraints(horizontalSeparatorConstraints)
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
