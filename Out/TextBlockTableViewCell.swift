//
//  TextBlockTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/17/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class TextBlockTableViewCell: UITableViewCell {

    var textBlock:UILabel!
    
    let labelMarginFromCellEdge =  20
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    let fontSize:CGFloat = 16.0
    var userDataDictionary:[String:String] = ["":""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.textBlock = UILabel(frame: CGRectZero)
        self.textBlock.numberOfLines = 0
        textBlock.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textBlock.textAlignment = NSTextAlignment.Left
        self.textBlock.font = valueFont?.fontWithSize(fontSize)
        contentView.addSubview(textBlock)
        
        let viewsDictionary = ["textBlock":textBlock]
        
        let metricsDictionary = ["hSpaceFromCellEdge": labelMarginFromCellEdge, "longVerticalSpace": (labelMarginFromCellEdge - 6) * 1, "bottomSpaceFromCellEdge":18, "shortVerticalSpace": 4]
        
        let textBlockLabel_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[textBlock]-8-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        let textBlockLabel_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[textBlock]-10-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(textBlockLabel_constraint_H)
        contentView.addConstraints(textBlockLabel_constraint_V)
        
    }

}
