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
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        contentView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        
        self.paperView = UIView(frame: CGRectZero)
        self.paperView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.backgroundColor = UIColor.whiteColor()
        self.paperView.layer.shadowColor = UIColor.blackColor().CGColor
        self.paperView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.paperView.layer.shadowOpacity = 0.1
        self.paperView.layer.shadowRadius = 1

        contentView.addSubview(self.paperView)
        
        self.reverseTimeLabel = UILabel(frame: CGRectZero)
        self.reverseTimeLabel.numberOfLines = 1
        self.reverseTimeLabel.textAlignment = NSTextAlignment.Right
        self.reverseTimeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.reverseTimeLabel.font = regularFont?.fontWithSize(15.0)
        self.paperView.addSubview(self.reverseTimeLabel)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.paperView.addSubview(self.avatarImageView)
        
        self.aliasLabel = UILabel(frame: CGRectZero)
        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.aliasLabel.numberOfLines = 1
        self.aliasLabel.textAlignment = NSTextAlignment.Left
        self.aliasLabel.font = titleFont?.fontWithSize(16.0)
        self.paperView.addSubview(self.aliasLabel)
        
        self.actionLabel = UILabel(frame: CGRectZero)
        self.actionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.actionLabel.numberOfLines = 0
        self.actionLabel.textAlignment = NSTextAlignment.Left
        self.actionLabel.font = titleFont?.fontWithSize(16.0)
        self.actionLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 12 - 50 - 12 - 12 - 10
        if UIScreen.mainScreen().bounds.width == 320{
            self.actionLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 12 - 50 - 12 - 12 - 10
        }
        self.paperView.addSubview(self.actionLabel)
        
        self.contentCanvas = UIView(frame: CGRectZero)
        self.contentCanvas.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.contentCanvas)
        
        var responseBarSeparator = UIView(frame: CGRectZero)
        responseBarSeparator.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        responseBarSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(responseBarSeparator)
        
        self.responseBar = UIView(frame: CGRectZero)
        self.responseBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.paperView.addSubview(self.responseBar)
        
        self.heroImageView = UIImageView(frame: CGRectZero)
        self.heroImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.heroImageView.layer.cornerRadius = 5
        self.heroImageView.clipsToBounds = true
        self.heroImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentCanvas.addSubview(self.heroImageView)
        
        self.contentType = UIVisualEffectView(frame: CGRectZero)
        self.contentType.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentCanvas.addSubview(self.contentType)
        
        self.contentTypeIconImageView = UIImageView(frame: CGRectZero)
        self.contentTypeIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentType.addSubview(self.contentTypeIconImageView)
        
        self.narrativeTitleLabel = UILabel(frame: CGRectZero)
        self.narrativeTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.narrativeTitleLabel.numberOfLines = 0
        self.narrativeTitleLabel.font = titleFont?.fontWithSize(15.0)
        self.narrativeTitleLabel.textAlignment = NSTextAlignment.Left
        self.contentCanvas.addSubview(self.narrativeTitleLabel)
        
        self.narrativeContentLabel = UILabel(frame: CGRectZero)
        self.narrativeContentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.narrativeContentLabel.numberOfLines = 0
        self.narrativeContentLabel.preferredMaxLayoutWidth = 330
        self.narrativeContentLabel.textAlignment = NSTextAlignment.Left
        self.narrativeContentLabel.font = valueFont?.fontWithSize(14.0)
        self.contentCanvas.addSubview(self.narrativeContentLabel)
        
        self.commentsButtonArea = UIView(frame: CGRectZero)
        self.commentsButtonArea.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.commentsButtonArea)
        
        self.commentsCountLabel = UILabel(frame: CGRectZero)
        self.commentsCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.commentsCountLabel.numberOfLines = 1
        self.commentsCountLabel.font = titleFont?.fontWithSize(16.0)
        self.commentsCountLabel.textAlignment = NSTextAlignment.Left
        self.commentsButtonArea.addSubview(self.commentsCountLabel)
        
        self.writeACommentLabel = UILabel(frame: CGRectZero)
        self.writeACommentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.writeACommentLabel.numberOfLines = 1
        self.writeACommentLabel.font = valueFont?.fontWithSize(16.0)
        self.writeACommentLabel.textAlignment = NSTextAlignment.Left
        self.commentsButtonArea.addSubview(self.writeACommentLabel)
        
        self.likeButtonArea = UIView(frame: CGRectZero)
        self.likeButtonArea.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.responseBar.addSubview(self.likeButtonArea)
        
        self.likeCountLabel = UILabel(frame: CGRectZero)
        self.likeCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.likeCountLabel.numberOfLines = 1
        self.likeCountLabel.textAlignment = NSTextAlignment.Right
        self.likeCountLabel.font = titleFont?.fontWithSize(16.0)
        self.likeButtonArea.addSubview(self.likeCountLabel)
        
        self.likeButton = UIImageView(frame: CGRectZero)
        self.likeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.likeButton.contentMode = UIViewContentMode.ScaleAspectFit
        self.likeButton.image = UIImage(named: "likeButton-icon")
        self.likeButton.layer.cornerRadius = 22
//        self.likeButton.layer.borderWidth = 1
//        self.likeButton.backgroundColor = UIColor(red: 239/255, green: 65/255, blue: 54/255, alpha: 1)
        self.likeButton.clipsToBounds = true
        self.likeButtonArea.addSubview(self.likeButton)
        
        
        
        //        "paperSidePadding": 12,
        //        "paperTopPadding":12,
        //        "paperBottomPadding":10,
        //        "smallHorizontalPadding":6,
        //        "mediumHorizontalPadding":10,
        
        
        
        
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
                    "responseBarSeparator":responseBarSeparator,
                    "responseBar":responseBar
        ]
        var paperInternalMetricsDictionary =
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
        
        var horizontalSecondRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[avatarImageView(50)]-paperSidePadding-[aliasLabel]-[reverseTimeLabel]-paperSidePadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        var horizontalThirdRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[avatarImageView(50)]-paperSidePadding-[actionLabel]-paperSidePadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        var horizontalFourthRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[contentCanvas]-paperSidePadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        var horizontalFifthRowPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[responseBar]-paperSidePadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        var horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-paperSidePadding-[responseBarSeparator]-paperSidePadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        var verticalLeftPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-paperTopPadding-[avatarImageView(50)]->=longVerticalPadding-[contentCanvas]-paperTopPadding-[responseBarSeparator(1)]-mediumVerticalPadding-[responseBar]-paperBottomPadding-|", options:NSLayoutFormatOptions.AlignAllLeft, metrics:paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        
        var verticalSecondColumnPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-secondColumnTopPadding-[aliasLabel]->=4-[actionLabel]-[contentCanvas]-paperTopPadding-[responseBarSeparator(1)]-mediumVerticalPadding-[responseBar]-paperBottomPadding-|", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)

        var verticalThirdColumnPaperInternalViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-thirdColumnTopPadding-[reverseTimeLabel]->=6-[actionLabel]", options: NSLayoutFormatOptions(0), metrics: paperInternalMetricsDictionary, views: paperInternalViewsDictionary)
        

        self.paperView.addConstraints(horizontalSecondRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalThirdRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalFourthRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalFifthRowPaperInternalViewConstraints)
        self.paperView.addConstraints(horizontalSeparatorConstraints)
        self.paperView.addConstraints(verticalLeftPaperInternalViewConstraints)
        self.paperView.addConstraints(verticalSecondColumnPaperInternalViewConstraints)
        self.paperView.addConstraints(verticalThirdColumnPaperInternalViewConstraints)
        

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

        var horizontalnarrativeTitleContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[narrativeTitleLabel]-0-|", options:NSLayoutFormatOptions(0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)
        
        var horizontalnarrativeContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-mediumVerticalPadding-[narrativeContentLabel]-mediumVerticalPadding-|", options:NSLayoutFormatOptions(0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)

        var verticalContentCanvasViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[heroImageView(140)]-mediumVerticalPadding-[narrativeTitleLabel]-shortVerticalPadding-[narrativeContentLabel]-0-|", options:NSLayoutFormatOptions(0), metrics: contentCanvasMetricsDictionary, views: contentCanvasViewsDictionary)

        self.contentCanvas.addConstraints(horizontalContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(horizontalnarrativeTitleContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(verticalContentCanvasViewConstraints)
        self.contentCanvas.addConstraints(horizontalnarrativeContentCanvasViewConstraints)

        // responseBar constraints
        var responseBarViewsDictionary =
        [
            "commentsButtonArea":commentsButtonArea,
            "commentsCountLabel":commentsCountLabel,
            "writeACommentLabel":writeACommentLabel,
            "likeButtonArea":likeButtonArea,
            "likeCountLabel":likeCountLabel,
            "likeButton":likeButton
        ]
        
        var responseBarMetricsDictionary =
        [
            "mediumVerticalPadding":8,
            "shortVerticalPadding":4,
            "mediumHorizontalPadding":10
        ]
        
        var horizontalResponseBarConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[commentsButtonArea]->=0-[likeButtonArea]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        var verticalResponseBarLeftConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[commentsButtonArea]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        var verticalResponseBarRightConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[likeButtonArea]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: responseBarMetricsDictionary, views: responseBarViewsDictionary)
        
        self.responseBar.addConstraints(horizontalResponseBarConstraints)
        self.responseBar.addConstraints(verticalResponseBarLeftConstraints)
        self.responseBar.addConstraints(verticalResponseBarRightConstraints)
        
        // Comment Button Area Constraints
        var commentButtonViewsDictionary =
        [
            "commentsCountLabel":commentsCountLabel,
            "writeACommentLabel":writeACommentLabel,
        ]
        
        var commentButtonMetricsDictionary =
        [
            "shortVerticalPadding":0
        ]
        
        var horizontalCommentButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[commentsCountLabel]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: commentButtonMetricsDictionary, views: commentButtonViewsDictionary)
        
        var verticalCommentButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[commentsCountLabel]-shortVerticalPadding-[writeACommentLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: commentButtonMetricsDictionary, views: commentButtonViewsDictionary)
        
        self.commentsButtonArea.addConstraints(horizontalCommentButtonAreaConstraints)
        self.commentsButtonArea.addConstraints(verticalCommentButtonAreaConstraints)
        
        // Like Button Area Constraints
        var likeButtonViewsDictionary =
        [
            "likeCountLabel":likeCountLabel,
            "likeButton":likeButton
        ]
        
        var likeButtonMetricsDictionary =
        [
            "shortVerticalPadding":2
        ]
        
        var horizontalLikeButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[likeCountLabel]-[likeButton(44)]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: likeButtonMetricsDictionary, views: likeButtonViewsDictionary)
        
        var verticalLikeButtonAreaConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[likeButton(44)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: likeButtonMetricsDictionary, views: likeButtonViewsDictionary)
        
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
