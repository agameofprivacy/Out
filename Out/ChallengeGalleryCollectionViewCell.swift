//
//  ChallengeGalleryCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeGalleryCollectionViewCell: UICollectionViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Mark: UI Elements Declarations
    let titleLabel:UILabel!
    let reasonLabel:UILabel!
    let introLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()

        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        titleLabel.textAlignment = .Left
        titleLabel.numberOfLines = 0
//        var borderWidth:CGFloat = 1.5
//        var bottomBorder:CALayer = CALayer()
//        
//        bottomBorder.borderColor = UIColor.blackColor().CGColor
//        bottomBorder.borderWidth = borderWidth
//        bottomBorder.frame = CGRectMake(borderWidth * -1.0, borderWidth * -1.0, CGRectGetWidth(titleLabel.frame) + borderWidth * 2.0, CGRectGetHeight(titleLabel.frame) - borderWidth * 2.0)
//        titleLabel.layer.addSublayer(bottomBorder)

        titleLabel.preferredMaxLayoutWidth = 300
        contentView.addSubview(titleLabel)

        

        reasonLabel = UILabel(frame: CGRectZero)
        reasonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        reasonLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        reasonLabel.textAlignment = .Left
        reasonLabel.numberOfLines = 0
        reasonLabel.preferredMaxLayoutWidth = 300
        contentView.addSubview(reasonLabel)
        
        introLabel = UILabel(frame: CGRectZero)
        introLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        introLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        introLabel.textAlignment = .Left
        introLabel.numberOfLines = 0
        introLabel.preferredMaxLayoutWidth = 300
        contentView.addSubview(introLabel)
        
        let viewsDictionary = ["titleLabel":titleLabel, "reasonLabel":reasonLabel, "introLabel":introLabel]
        let metricsDictionary = ["hSpaceFromCellEdge": 18, "topSpaceFromCellEdge": 30]
        let titleLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[titleLabel(>=240)]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)
        let reasonLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[reasonLabel(>=240)]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)
        let introLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[introLabel(>=240)]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)

        let label_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topSpaceFromCellEdge-[titleLabel(>=20)]-[reasonLabel(>=20)]-hSpaceFromCellEdge-[introLabel(>=20)]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(titleLabel_constraint_H)
        contentView.addConstraints(reasonLabel_constraint_H)
        contentView.addConstraints(introLabel_constraint_H)
        contentView.addConstraints(label_constraint_V)
    }

    
//
//    
//    reasonLabel = UILabel(frame: CGRectZero)
//    reasonLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//    reasonLabel.textAlignment = .Left
//    self.contentView.addSubview(reasonLabel)
//    self.backgroundColor = UIColor.whiteColor()

    
    func makeLayout(){
    }

    // MARK: Title Label
    

    
    // MARK: Constraints
    
    
}
