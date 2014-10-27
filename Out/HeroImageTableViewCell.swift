//
//  HeroImageTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class HeroImageTableViewCell: UITableViewCell {

    var heroImage:UIImageView!
    
    var userDataDictionary:[String:String] = ["":""]

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.heroImage = UIImageView(frame: CGRectZero)
        self.heroImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.heroImage.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(self.heroImage)
        
        var viewsDictionary = ["heroImage":self.heroImage]
        var metricsDictionary = ["bottomMargin":4]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[heroImage]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[heroImage(==100)]-bottomMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        
    }

}
