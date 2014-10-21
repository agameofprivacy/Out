////
////  ChallengeGalleryCollectionViewCell.swift
////  Out
////
////  Created by Eddie Chen on 10/8/14.
////  Copyright (c) 2014 Coming Out App. All rights reserved.
////
//
//import UIKit
//
//class ChallengeGalleryCollectionViewCell: UICollectionViewCell {
//
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    // Mark: UI Elements Declarations
//    let titleLabel:UILabel!
//    let reasonLabel:UILabel!
//    let introLabel:UILabel!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.backgroundColor = UIColor.whiteColor()
//        var labelMarginFromCellEdge = 20
//        
//        titleLabel = UILabel(frame: CGRectZero)
//        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//        titleLabel.textAlignment = .Left
//        titleLabel.numberOfLines = 0
//        titleLabel.preferredMaxLayoutWidth = self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)
//        contentView.addSubview(titleLabel)
//
//        reasonLabel = UILabel(frame: CGRectZero)
//        reasonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        reasonLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
//        reasonLabel.textAlignment = .Left
//        reasonLabel.numberOfLines = 0
//        reasonLabel.preferredMaxLayoutWidth = self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)
//        contentView.addSubview(reasonLabel)
//        
//        introLabel = UILabel(frame: CGRectZero)
//        introLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        introLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
//        introLabel.textAlignment = .Left
//        introLabel.numberOfLines = 0
//        introLabel.preferredMaxLayoutWidth = self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)
//        contentView.addSubview(introLabel)
//        
//        let viewsDictionary = ["titleLabel":titleLabel, "reasonLabel":reasonLabel, "introLabel":introLabel]
//        let metricsDictionary = ["hSpaceFromCellEdge": labelMarginFromCellEdge, "topSpaceFromCellEdge": (labelMarginFromCellEdge - 2) * 1, "bottomSpaceFromCellEdge":CGFloat(labelMarginFromCellEdge - 3) * 1.8, "shortVerticalSpace": 4]
//        
//        let titleLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[titleLabel(==\(self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)))]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)
//        let reasonLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[reasonLabel(==\(self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)))]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)
//        let introLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hSpaceFromCellEdge-[introLabel(==\(self.bounds.width - CGFloat(labelMarginFromCellEdge * 2)))]-hSpaceFromCellEdge-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metricsDictionary, views: viewsDictionary)
//
//        let label_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[titleLabel(>=0)]-5-[reasonLabel(>=0)]-hSpaceFromCellEdge-[introLabel(>=0)]-bottomSpaceFromCellEdge-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        
//        contentView.addConstraints(titleLabel_constraint_H)
//        contentView.addConstraints(reasonLabel_constraint_H)
//        contentView.addConstraints(introLabel_constraint_H)
//        contentView.addConstraints(label_constraint_V)
//    }
//}