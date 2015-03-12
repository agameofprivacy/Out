//
//  TextFieldInputTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class TextFieldInputTableViewCell: UITableViewCell, CollectStepData {

    var userDataDictionary:[String:String] = ["":""]

    var placeholderText:String!
    var textField:UITextField!
    var key:String!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)
    
    let fontSize:CGFloat = 16.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        self.textField = UITextField(frame: CGRectZero)
        self.textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textField.textAlignment = NSTextAlignment.Left
        self.textField.font = valueFont?.fontWithSize(fontSize)
        self.textField.placeholder = self.placeholderText
        contentView.addSubview(self.textField)
        
        var viewsDictionary = ["textField":self.textField]
        var metricsDictionary = ["sideEdgeMargin":8]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideEdgeMargin-[textField]-sideEdgeMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-18-[textField]-18-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
    }
    func collectData() -> [String : String] {
        self.userDataDictionary = [self.key:self.textField.text]
        return userDataDictionary
    }
    
}
