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
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        contentView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        


        
        self.paperView = UIView(frame: CGRectZero)
        self.paperView.translatesAutoresizingMaskIntoConstraints = false
        self.paperView.backgroundColor = UIColor.whiteColor()
        self.paperView.layer.shadowColor = UIColor(white: 0, alpha: 1).CGColor
        self.paperView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.paperView.layer.shadowOpacity = 0.1
//        self.paperView.layer.shadowPath = UIBezierPath(rect: self.paperView.bounds).CGPath
        self.paperView.layer.shadowRadius = 1
        self.paperView.layer.cornerRadius = 5
        self.paperView.layer.borderWidth = 0.75
        self.paperView.layer.borderColor = UIColor(white: 0.85, alpha: 1).CGColor
        contentView.addSubview(self.paperView)
        
        self.reverseTimeLabel = UILabel(frame: CGRectZero)
        self.reverseTimeLabel.numberOfLines = 1
        self.reverseTimeLabel.textAlignment = NSTextAlignment.Right
        self.reverseTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.reverseTimeLabel.text = "time"
        self.reverseTimeLabel.font = regularFont?.fontWithSize(15.0)
        self.reverseTimeLabel.opaque = true
        self.paperView.addSubview(self.reverseTimeLabel)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.backgroundColor = UIColor.whiteColor()
        self.avatarImageView.image = UIImage(named: "avatarImagePlaceholder")
        self.avatarImageView.opaque = true
        self.avatarImageView.userInteractionEnabled = true
        self.paperView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.translatesAutoresizingMaskIntoConstraints = false
        self.aliasLabel.numberOfLines = 1
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.aliasLabel.font = titleFont?.fontWithSize(16.0)
        self.aliasLabel.text = "username"
        self.aliasLabel.opaque = true
        self.aliasLabel.userInteractionEnabled = true
        self.paperView.addSubview(self.aliasLabel)
        
        self.actionLabel = UILabel(frame: CGRectZero)
        self.actionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.actionLabel.numberOfLines = 0
        self.actionLabel.textAlignment = NSTextAlignment.Left
        self.actionLabel.font = titleFont?.fontWithSize(16.0)
        self.actionLabel.text = "challenge action"
        self.actionLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 12 - 50 - 12 - 12 - 10
        if UIScreen.mainScreen().bounds.width == 320{
            self.actionLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 12 - 50 - 12 - 12 - 10
        }
        self.actionLabel.opaque = true
        self.paperView.addSubview(self.actionLabel)
        
        self.contentCanvas = UIView(frame: CGRectZero)
        self.contentCanvas.translatesAutoresizingMaskIntoConstraints = false
        self.contentCanvas.backgroundColor = UIColor(white: 0.96, alpha: 1)
        self.contentCanvas.layer.cornerRadius = 5
        self.contentCanvas.clipsToBounds = true
        self.contentCanvas.layer.borderWidth = 0.75
        self.contentCanvas.layer.borderColor = UIColor(white: 0.85, alpha: 1).CGColor
        self.paperView.addSubview(self.contentCanvas)
        
        let responseBarSeparator = UIView(frame: CGRectZero)
        responseBarSeparator.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        responseBarSeparator.translatesAutoresizingMaskIntoConstraints = false
        responseBarSeparator.opaque = true
        self.paperView.addSubview(responseBarSeparator)
        
        self.responseBar = UIView(frame: CGRectZero)
        self.responseBar.translatesAutoresizingMaskIntoConstraints = false
        self.responseBar.opaque = true
        self.paperView.addSubview(self.responseBar)
        
        self.heroImageView = UIImageView(frame: CGRectZero)
        self.heroImageView.translatesAutoresizingMaskIntoConstraints = false
        self.heroImageView.layer.cornerRadius = 5
        self.heroImageView.clipsToBounds = true
        self.heroImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.heroImageView.image = UIImage(named: "heroPlaceholder")
        self.heroImageView.opaque = true
        self.contentCanvas.addSubview(self.heroImageView)
        
        self.contentType = UIVisualEffectView(frame: CGRectZero)
        self.contentType.translatesAutoresizingMaskIntoConstraints = false
        self.contentType.opaque = true
        self.contentCanvas.addSubview(self.contentType)
        
        self.contentTypeIconImageView = UIImageView(frame: CGRectZero)
        self.contentTypeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentTypeIconImageView.opaque = true
        self.contentType.addSubview(self.contentTypeIconImageView)
        
        self.narrativeTitleLabel = UILabel(frame: CGRectZero)
        self.narrativeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.narrativeTitleLabel.numberOfLines = 0
        self.narrativeTitleLabel.font = titleFont?.fontWithSize(14.0)
        self.narrativeTitleLabel.textAlignment = NSTextAlignment.Left
        self.narrativeTitleLabel.text = "Narrative Title"
        self.narrativeTitleLabel.opaque = true
        self.contentCanvas.addSubview(self.narrativeTitleLabel)
        
        self.narrativeContentLabel = UILabel(frame: CGRectZero)
        self.narrativeContentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.narrativeContentLabel.numberOfLines = 0
        self.narrativeContentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 67
        self.narrativeContentLabel.textAlignment = NSTextAlignment.Left
        self.narrativeContentLabel.text = "Narrative Content"
        self.narrativeContentLabel.font = valueFont?.fontWithSize(13.0)
        self.narrativeContentLabel.opaque = true
        self.contentCanvas.addSubview(self.narrativeContentLabel)
        
        self.commentsButtonArea = UIView(frame: CGRectZero)
        self.commentsButtonArea.translatesAutoresizingMaskIntoConstraints = false
        self.commentsButtonArea.userInteractionEnabled = true
        self.commentsButtonArea.opaque = true
        self.responseBar.addSubview(self.commentsButtonArea)
        
        self.commentsCountLabel = UILabel(frame: CGRectZero)
        self.commentsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.commentsCountLabel.numberOfLines = 1
        self.commentsCountLabel.text = "No comments"
        self.commentsCountLabel.font = titleFont?.fontWithSize(16.0)
        self.commentsCountLabel.textAlignment = NSTextAlignment.Left
        self.commentsCountLabel.opaque = true
        self.commentsButtonArea.addSubview(self.commentsCountLabel)
        
        self.writeACommentLabel = UILabel(frame: CGRectZero)
        self.writeACommentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.writeACommentLabel.numberOfLines = 1
        self.writeACommentLabel.font = valueFont?.fontWithSize(16.0)
        self.writeACommentLabel.textAlignment = NSTextAlignment.Left
        self.writeACommentLabel.text = "write a comment"
        self.writeACommentLabel.opaque = true
        self.commentsButtonArea.addSubview(self.writeACommentLabel)
        
        self.likeButtonArea = UIView(frame: CGRectZero)
        self.likeButtonArea.translatesAutoresizingMaskIntoConstraints = false
        self.likeButtonArea.userInteractionEnabled = true
        self.likeButtonArea.opaque = true
        self.responseBar.addSubview(self.likeButtonArea)
        
        self.likeCountLabel = UILabel(frame: CGRectZero)
        self.likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.likeCountLabel.numberOfLines = 1
        self.likeCountLabel.textAlignment = NSTextAlignment.Right
        self.likeCountLabel.text = ""
        self.likeCountLabel.font = titleFont?.fontWithSize(16.0)
        self.likeCountLabel.opaque = true
        self.likeButtonArea.addSubview(self.likeCountLabel)
        
        self.likeButton = UIImageView(frame: CGRectZero)
        self.likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.likeButton.contentMode = UIViewContentMode.ScaleAspectFit
        self.likeButton.clipsToBounds = true
        self.likeButton.image = UIImage(named: "likeButtonPlaceholder")
        self.likeButton.userInteractionEnabled = true
        self.likeButton.opaque = true
        self.likeButtonArea.addSubview(self.likeButton)
//        self.contentCanvas.hidden = true

        // paperView constraints
        let paperViewsDictionary = ["paperView":paperView]
        let paperMetricsDictionary = ["largeVerticalPadding":8]
        
        let horizontalPaperViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[paperView]-7.5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperMetricsDictionary, views: paperViewsDictionary)
        
        let verticalPaperViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paperView]-largeVerticalPadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperMetricsDictionary, views: paperViewsDictionary)
        
        contentView.addConstraints(horizontalPaperViewConstraints)
        contentView.addConstraints(verticalPaperViewConstraints)
        
        
        // paperView internal constraints
        let paperInternalViewsDictionary =
        [
                    "reverseTimeLabel":reverseTimeLabel,
                    "avatarImageView":avatarImageView,
                    "aliasLabel":aliasLabel,
                    "actionLabel":actionLabel,
                    "contentCanvas":contentCanvas,
                    "responseBarSeparator":responseBarSeparator,
                    "responseBar":responseBar
        ]
        
        let paperInternalMetricsDictionary =
        [
                    "paperSidePadding": 12,
                    "paperTopPadding":16,
                    "secondColumnTopPadding": 22,
                    "thirdColumnTopPadding": 22,
                    "paperBottomPadding":10,
                    "smallHorizontalPadding":6,
                    "mediumHorizontalPadding":10,
                    "mediumVerticalPadding":8,
                    "longVerticalPadding":12,
                    "shortVerticalPadding":2
        ]
        
        let horizontalSecondRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[avatarImageView(50)]-paperSidePadding-[aliasLabel]-[reverseTimeLabel]-paperSidePadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        let horizontalThirdRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[avatarImageView(50)]-paperSidePadding-[actionLabel]-paperSidePadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        let horizontalFourthRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[contentCanvas]-paperSidePadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        let horizontalFifthRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[responseBar]-paperSidePadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        let horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[responseBarSeparator]-paperSidePadding-|", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        let verticalLeftPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-paperTopPadding-[avatarImageView(50)]->=longVerticalPadding-[contentCanvas]-paperTopPadding-[responseBarSeparator(1)]-mediumVerticalPadding-[responseBar]-paperBottomPadding-|", options:NSLayoutFormatOptions.AlignAllLeft, metrics:paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        let verticalSecondColumnPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-secondColumnTopPadding-[aliasLabel]-4-[actionLabel]-longVerticalPadding-[contentCanvas]", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        let verticalThirdColumnPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-thirdColumnTopPadding-[reverseTimeLabel]", options: NSLayoutFormatOptions(rawValue:0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        self.paperView.addConstraints(horizontalSecondRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalThirdRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalFourthRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalFifthRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalSeparatorConstraints)
        self.paperView.addConstraints(verticalLeftPaperInternalViewConstraints)
        self.paperView.addConstraints(verticalSecondColumnPaperInternalViewConstraints)
        self.paperView.addConstraints(verticalThirdColumnPaperInternalViewConstraints)
        

        // contentCanvas constraints
        
        let contentCanvasViewsDictionary =
        [
            "heroImageView":heroImageView,
            "contentType":contentType,
            "contentTypeIconImageView":contentTypeIconImageView,
            "narrativeTitleLabel":narrativeTitleLabel,
            "narrativeContentLabel":narrativeContentLabel
        ]
        
        let contentCanvasMetricsDictionary =
        [
            "smallHorizontalPadding":6,
            "mediumVerticalPadding":12,
            "largeVerticalPadding":12,
            "shortVerticalPadding":4
        ]
        
        let horizontalContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[heroImageView]-0-|", options:NSLayoutFormatOptions(rawValue:0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)

        let horizontalnarrativeTitleContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-mediumVerticalPadding-[narrativeTitleLabel]-mediumVerticalPadding-|", options:NSLayoutFormatOptions(rawValue:0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)
        
        let horizontalnarrativeContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-mediumVerticalPadding-[narrativeContentLabel]-16-|", options:NSLayoutFormatOptions(rawValue:0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)

        let verticalContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[heroImageView(<=110)]-mediumVerticalPadding-[narrativeTitleLabel]-shortVerticalPadding-[narrativeContentLabel]-mediumVerticalPadding-|", options:NSLayoutFormatOptions(rawValue:0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)

        self.contentCanvas.addConstraints(horizontalContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(horizontalnarrativeTitleContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(verticalContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(horizontalnarrativeContentCanvasViewConstraints)

        
        // responseBar constraints
        let responseBarViewsDictionary =
        [
            "commentsButtonArea":commentsButtonArea,
            "commentsCountLabel":commentsCountLabel,
            "writeACommentLabel":writeACommentLabel,
            "likeButtonArea":likeButtonArea,
//            "likeCountLabel":likeCountLabel,
            "likeButton":likeButton
        ]
        
        let responseBarMetricsDictionary =
        [
            "mediumVerticalPadding":8,
            "shortVerticalPadding":4,
            "mediumHorizontalPadding":10
        ]
        
        let horizontalResponseBarConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[commentsButtonArea]->=0-[likeButtonArea]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        let verticalResponseBarLeftConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[commentsButtonArea]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        let verticalResponseBarRightConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[likeButtonArea]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        self.responseBar.addConstraints(horizontalResponseBarConstraints)
        self.responseBar.addConstraints(verticalResponseBarLeftConstraints)
        self.responseBar.addConstraints(verticalResponseBarRightConstraints)
        
        
        // Comment Button Area Constraints
        let commentButtonViewsDictionary =
        [
            "commentsCountLabel":commentsCountLabel,
            "writeACommentLabel":writeACommentLabel,
        ]
        
        let commentButtonMetricsDictionary =
        [
            "shortVerticalPadding":0
        ]
        
        let horizontalCommentButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[commentsCountLabel]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: commentButtonMetricsDictionary, views: commentButtonViewsDictionary)
        
        let verticalCommentButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[commentsCountLabel]-shortVerticalPadding-[writeACommentLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: commentButtonMetricsDictionary, views: commentButtonViewsDictionary)
        
        self.commentsButtonArea.addConstraints(horizontalCommentButtonAreaConstraints)
        self.commentsButtonArea.addConstraints(verticalCommentButtonAreaConstraints)
        
        
        // Like Button Area Constraints
        let likeButtonViewsDictionary =
        [
            "likeCountLabel":likeCountLabel,
            "likeButton":likeButton
        ]
        
        let likeButtonMetricsDictionary =
        [
            "shortVerticalPadding":2
        ]
        
        let horizontalLikeButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[likeCountLabel]-6-[likeButton(44)]|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: likeButtonMetricsDictionary, views: likeButtonViewsDictionary)
        
        let verticalLikeButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=2-[likeButton(44)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: likeButtonMetricsDictionary, views: likeButtonViewsDictionary)
        
        self.likeButtonArea.addConstraints(horizontalLikeButtonAreaConstraints)
        self.likeButtonArea.addConstraints(verticalLikeButtonAreaConstraints)
        
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
