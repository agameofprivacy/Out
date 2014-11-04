//
//  ActivityTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 11/4/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    var paperView:UIView!
    
    var reverseTimeLabel:UILabel!
    var avatarImageView:UIImageView!
    var aliasLabel:UILabel!
    var actionLabel:UILabel!
    
    var contentCanvas:UIView!
    var heroImageView:UIImageView!
    var contentType:UIVisualEffectView!
    var contentTypeIconImageView:UIImageView!
    var narrativeTitleLabel:UILabel!
    var narrativeContentLabel:UILabel!
    
    var responseBar:UIView!

    var commentsButtonArea:UIView!
    var commentsCountLabel:UILabel!
    var writeACommentLabel:UILabel!
    
    var likeButtonArea:UIView!
    var likeCountLabel:UILabel!
    var likeButton:UIImageView!
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        
        self.paperView = UIView(frame: CGRectZero)
        self.paperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.backgroundColor = UIColor.whiteColor()
        self.paperView.layer.shadowColor = UIColor.blackColor().CGColor
        self.paperView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.paperView.layer.shadowOpacity = 0.1
        self.paperView.layer.shadowRadius = 1

        contentView.addSubview(self.paperView)
        
        self.reverseTimeLabel = UILabel(frame: CGRectZero)
        self.reverseTimeLabel.numberOfLines = 0
        self.reverseTimeLabel.textAlignment = NSTextAlignment.Right
        self.reverseTimeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.reverseTimeLabel)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.aliasLabel)
        
        self.actionLabel = UILabel(frame: CGRectZero)
        self.actionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.actionLabel)
        
        self.contentCanvas = UIView(frame: CGRectZero)
        self.contentCanvas.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.contentCanvas)
        
        self.responseBar = UIView(frame: CGRectZero)
        self.responseBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.responseBar)

        
        
        self.heroImageView = UIImageView(frame: CGRectZero)
        self.heroImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.heroImageView)
        
        self.contentType = UIVisualEffectView(frame: CGRectZero)
        self.contentType.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.contentType)
        
        self.contentTypeIconImageView = UIImageView(frame: CGRectZero)
        self.contentTypeIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.contentTypeIconImageView)
        
        self.narrativeTitleLabel = UILabel(frame: CGRectZero)
        self.narrativeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.narrativeTitleLabel)
        
        self.narrativeContentLabel = UILabel(frame: CGRectZero)
        self.narrativeContentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.narrativeContentLabel)
        
        self.commentsButtonArea = UIView(frame: CGRectZero)
        self.commentsButtonArea.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.commentsButtonArea)
        
        self.commentsCountLabel = UILabel(frame: CGRectZero)
        self.commentsCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.commentsCountLabel)
        
        self.writeACommentLabel = UILabel(frame: CGRectZero)
        self.writeACommentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.writeACommentLabel)
        
        self.likeButtonArea = UIView(frame: CGRectZero)
        self.likeButtonArea.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.likeButtonArea)
        
        self.likeCountLabel = UILabel(frame: CGRectZero)
        self.likeCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.likeButtonArea.addSubview(self.likeCountLabel)
        
        self.likeButton = UIImageView(frame: CGRectZero)
        self.likeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.likeButtonArea.addSubview(self.likeButton)
        
        
        
        //        "paperSidePadding": 12,
        //        "paperTopPadding":12,
        //        "paperBottomPadding":10,
        //        "smallHorizontalPadding":6,
        //        "mediumHorizontalPadding":10,
        
        
        //        "mediumVerticalPadding":8,
        //        "shortVerticalPadding":4
        
        
        //        "reverseTimeLabel":reverseTimeLabel,
        //        "avatarImageView":avatarImageView,
        //        "aliasLabel":aliasLabel,
        //        "actionLabel":actionLabel,
        //        "contentCanvas":contentCanvas,
        //        "responseBar":responseBar,
        //        "heroImageView":heroImageView,
        //        "contentType":contentType,
        //        "contentTypeIconImageView":contentTypeIconImageView,
        //        "narrativeTitleLabel":narrativeTitleLabel,
        //        "narrativeContentLabel":narrativeContentLabel,
        //        "commentsButtonArea":commentsButtonArea,
        //        "commentsCountLabel":commentsCountLabel,
        //        "writeACommentLabel":writeACommentLabel,
        //        "likeButtonArea":likeButtonArea,
        //        "likeCountLabel":likeCountLabel,
        //        "likeButton":likeButton

        
        // paperView constraints
        var paperViewsDictionary = ["paperView":paperView]
        var paperMetricsDictionary = ["largeVerticalPadding":12]
        
        var horizontalPaperViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[paperView]-0-|", options: NSLayoutFormatOptions(0), metrics: paperMetricsDictionary, views: paperViewsDictionary)
        
        var verticalPaperViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paperView]-largeVerticalPadding-|", options: NSLayoutFormatOptions(0), metrics: paperMetricsDictionary, views: paperViewsDictionary)
        
        contentView.addConstraints(horizontalPaperViewConstraints)
        contentView.addConstraints(verticalPaperViewConstraints)
        
        // paperView internal constraints
        var paperInternalViewsDictionary =
        [
                    "reverseTimeLabel":reverseTimeLabel,
                    "avatarImageView":avatarImageView,
                    "aliasLabel":aliasLabel,
                    "actionLabel":actionLabel,
                    "contentCanvas":contentCanvas,
                    "responseBar":responseBar
        ]
        var paperInternalMetricsDictionary =
        [
                    "paperSidePadding": 12,
                    "paperTopPadding":12,
                    "paperBottomPadding":10,
                    "smallHorizontalPadding":6,
                    "mediumHorizontalPadding":10,

        ]
        
        var horizontalPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[reverseTimeLabel]-paperSidePadding-|", options:NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        var verticalPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-paperTopPadding-[reverseTimeLabel]-[avatarImageView]-[contentCanvas]-[responseBar]-paperBottomPadding-|", options:NSLayoutFormatOptions.AlignAllLeft, metrics:paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        self.paperView.addConstraints(horizontalPaperInternalViewConstraints)
        self.paperView.addConstraints(verticalPaperInternalViewConstraints)
        

        // contentCanvas constraints
        
        var contentCanvasViewsDictionary =
        [
            "heroImageView":heroImageView,
            "contentType":contentType,
            "contentTypeIconImageView":contentTypeIconImageView,
            "narrativeTitleLabel":narrativeTitleLabel,
            "narrativeContentLabel":narrativeContentLabel
        ]
        
        var contentCanvasMetricsDictionary =
        [
            "smallHorizontalPadding":6,
            "mediumVerticalPadding":8,
            "largeVerticalPadding":12,
            "shortVerticalPadding":4
        ]
        
        var horizontalContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[heroImageView]-0-|", options:NSLayoutFormatOptions(0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)
        var verticalContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[heroImageView]-largeVerticalPadding-[narrativeTitleLabel]-shortVerticalPadding-[narrativeContentLabel]-mediumVerticalPadding-|", options:NSLayoutFormatOptions.AlignAllLeft, metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)
        self.contentCanvas.addConstraints(horizontalContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(verticalContentCanvasViewConstraints)

        // responseBar constraints
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
