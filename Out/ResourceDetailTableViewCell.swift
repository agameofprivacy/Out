//
//  ResourceDetailTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/22/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ResourceDetailTableViewCell: UITableViewCell {
    
    var logoBannerImageView:UIImageView!
    var aliasLabel:UILabel!
    var basicsLabel:UILabel!
    var aboutTextView:UILabel!
    var contactButton:UIButton!
    var directionsButton:UIButton!
    var separatorView:UIView!
    
    var segmentedControlView:UIView!
    var personDetailSegmentedControl:UISegmentedControl!
    
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.logoBannerImageView = UIImageView(frame: CGRectZero)
        self.logoBannerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoBannerImageView.image = UIImage(named: "trevorBanner")
        self.logoBannerImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(self.logoBannerImageView)
        
        //        self.aliasLabel = UILabel(frame: CGRectZero)
        //        self.aliasLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        //        self.aliasLabel.text = "username"
        //        contentView.addSubview(self.aliasLabel)
        
        self.basicsLabel = UILabel(frame: CGRectZero)
        self.basicsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.basicsLabel.text = "user basic stats"
        self.basicsLabel.textAlignment = NSTextAlignment.Center
        contentView.addSubview(self.basicsLabel)
        
        self.aboutTextView = UILabel(frame: CGRectZero)
        self.aboutTextView.translatesAutoresizingMaskIntoConstraints = false
        self.aboutTextView.text = "user advance stats"
        self.aboutTextView.backgroundColor = UIColor.clearColor()
        self.aboutTextView.textAlignment = NSTextAlignment.Left
        self.aboutTextView.font = self.valueFont?.fontWithSize(14)
        self.aboutTextView.numberOfLines = 0
        self.aboutTextView.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 30
        contentView.addSubview(self.aboutTextView)
        
        self.contactButton = UIButton(frame: CGRectZero)
        self.contactButton.translatesAutoresizingMaskIntoConstraints = false
        self.contactButton.setTitle("Contact", forState: UIControlState.Normal)
        self.contactButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.contactButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        self.contactButton.layer.borderWidth = 1
        self.contactButton.layer.borderColor = UIColor.blackColor().CGColor
        self.contactButton.layer.cornerRadius = 8
        self.contactButton.enabled = false
        contentView.addSubview(self.contactButton)
        
        self.directionsButton = UIButton(frame: CGRectZero)
        self.directionsButton.translatesAutoresizingMaskIntoConstraints = false
        self.directionsButton.setTitle("Directions", forState: UIControlState.Normal)
        self.directionsButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.directionsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        self.directionsButton.layer.borderWidth = 1
        self.directionsButton.layer.borderColor = UIColor.blackColor().CGColor
        self.directionsButton.layer.cornerRadius = 8
        contentView.addSubview(self.directionsButton)
        
        self.separatorView = UIView(frame: CGRectZero)
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.separatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        contentView.addSubview(self.separatorView)
        //        var aboutTextViewHeight = self.aboutTextView.sizeThatFits(CGSizeMake(UIScreen.mainScreen().bounds.width - 15, CGFloat(MAXFLOAT))).height
        
        let metricsDictionary = ["sideMargin":15, "buttonMargin":(UIScreen.mainScreen().bounds.width - 278)/2]
        let viewsDictionary = ["logoBannerImageView":self.logoBannerImageView, "basicsLabel":self.basicsLabel, "aboutTextView":self.aboutTextView, "contactButton":self.contactButton, "directionsButton":self.directionsButton, "separatorView":self.separatorView]
        
        
        let topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[logoBannerImageView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let logoBannerImageViewCenterConstraint = NSLayoutConstraint(item: self.logoBannerImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let secondHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[basicsLabel]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let aboutTextViewHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[aboutTextView]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let thirdHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-buttonMargin-[contactButton(130)]-18-[directionsButton(130)]-buttonMargin-|", options: [NSLayoutFormatOptions.AlignAllTop, NSLayoutFormatOptions.AlignAllBottom], metrics: metricsDictionary, views: viewsDictionary)
        
        let fourthHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let topVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-24-[logoBannerImageView]-12-[basicsLabel]-10-[aboutTextView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
        
        let secondVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aboutTextView]-20-[contactButton(36)]-24-[separatorView(0.5)]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        
        //        var fourthVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aboutTextView]-20-[contactButton(36)]-30-[separatorView(0.5)]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        //        var buttonHorizontalConstraint = NSLayoutConstraint(item: self.contactButton, attribute: NSLayoutAttribute.CenterXWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: self.separatorView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(logoBannerImageViewCenterConstraint)
        self.contentView.addConstraints(topHorizontalConstraints)
        self.contentView.addConstraints(secondHorizontalConstraints)
        self.contentView.addConstraints(aboutTextViewHorizontalConstraints)
        self.contentView.addConstraints(thirdHorizontalConstraints)
        self.contentView.addConstraints(fourthHorizontalConstraints)
        self.contentView.addConstraints(topVerticalConstraints)
        self.contentView.addConstraints(secondVerticalConstraints)
        //        self.contentView.addConstraints(fourthVerticalConstraints)
        //        self.contentView.addConstraint(buttonHorizontalConstraint)
        
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
