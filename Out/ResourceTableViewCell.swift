//
//  ResourceTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 4/17/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ResourceTableViewCell: UITableViewCell {

    var paperView:UIView!
    var logoImageView:UIImageView!
    var descriptionLabel:UILabel!
//    var callButton:UIButton!
//    var messageButton:UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = nil
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.paperView = UIView(frame: CGRectZero)
        self.paperView.translatesAutoresizingMaskIntoConstraints = false
        self.paperView.backgroundColor = UIColor.whiteColor()
        self.paperView.layer.shadowColor = UIColor(white: 0, alpha: 1).CGColor
        self.paperView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.paperView.layer.shadowRadius = 1
        self.paperView.layer.cornerRadius = 5
        self.paperView.layer.borderWidth = 0.75
        self.paperView.layer.borderColor = UIColor(white: 0.85, alpha: 1).CGColor
        //        self.paperView.bounds = CGRectInset(self.paperView.frame, 7.5, 7.5)
        contentView.addSubview(self.paperView)
        
        self.logoImageView = UIImageView(frame: CGRectZero)
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.layer.cornerRadius = 5
        self.logoImageView.clipsToBounds = true
        self.logoImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.logoImageView.image = UIImage(named: "tervorBanner")
        self.logoImageView.opaque = true
        self.paperView.addSubview(self.logoImageView)
        
        self.descriptionLabel = UILabel(frame: CGRectZero)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13.0)
        self.descriptionLabel.numberOfLines = 0
        self.paperView.addSubview(self.descriptionLabel)
        
//        self.callButton = UIButton(frame: CGRectZero)
//        self.callButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.callButton.setTitle("Call", forState: UIControlState.Normal)
//        self.callButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
//        self.callButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        self.callButton.layer.borderWidth = 1
//        self.callButton.layer.borderColor = UIColor.blackColor().CGColor
//        self.callButton.layer.cornerRadius = 8
//        self.paperView.addSubview(self.callButton)
//        
//        self.messageButton = UIButton(frame: CGRectZero)
//        self.messageButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.messageButton.setTitle("Message", forState: UIControlState.Normal)
//        self.messageButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
//        self.messageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        self.messageButton.layer.borderWidth = 1
//        self.messageButton.layer.borderColor = UIColor.blackColor().CGColor
//        self.messageButton.layer.cornerRadius = 8
//        self.paperView.addSubview(self.messageButton)
//        var buttonWidth = (UIScreen.mainScreen().bounds.width - 20 * 3 - 15)/2
        
        let metricsDictionary = ["sideMargin":7.5, "largeVerticalPadding":6]
        let viewsDictionary = ["paperView":self.paperView, "logoImageView":self.logoImageView, "descriptionLabel":self.descriptionLabel]
        
        let paperHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[paperView]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let paperVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[paperView]-8-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(paperHorizontalConstraints)
        contentView.addConstraints(paperVerticalConstraints)
        
        let logoImageHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[logoImageView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let descriptionLabelHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[descriptionLabel]-20-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[logoImageView(105)]-10-[descriptionLabel]-20-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(logoImageHorizontalConstraints)
        contentView.addConstraints(descriptionLabelHorizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        
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
