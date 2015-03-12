//
//  PromptAndAnswerTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PromptAndAnswerTableViewCell: UITableViewCell, CollectStepData{
    
    var userDataDictionary:[String:String] = ["":""]
    var prompt1:UILabel!
    var prompt2:UILabel!
    var textView1:UITextView!
    var textView2:UITextView!
    
    var promptBottomMargin = 12
    var textFieldBottomMargin = 50

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None

        self.prompt1 = UILabel(frame: CGRectZero)
        self.prompt1.numberOfLines = 0
        self.prompt1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.prompt1.textAlignment = NSTextAlignment.Left
        self.prompt1.font = titleFont?.fontWithSize(16.0)
        self.prompt1.preferredMaxLayoutWidth = contentView.frame.width - 20
        if UIScreen.mainScreen().bounds.size.width == 320{
            self.prompt1.preferredMaxLayoutWidth = self.bounds.size.width - 60
        }

        contentView.addSubview(prompt1)
        
        self.prompt2 = UILabel(frame: CGRectZero)
        self.prompt2.numberOfLines = 0
        self.prompt2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.prompt2.textAlignment = NSTextAlignment.Left
        self.prompt2.font = titleFont?.fontWithSize(16.0)
        self.prompt2.preferredMaxLayoutWidth = contentView.frame.width - 20
        if UIScreen.mainScreen().bounds.size.width == 320{
            self.prompt2.preferredMaxLayoutWidth = self.bounds.size.width - 60
        }

        contentView.addSubview(prompt2)
        
        self.textView1 = UITextView(frame: CGRectZero)
        self.textView1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textView1.userInteractionEnabled = true
        self.textView1.isFirstResponder()
        self.textView1.font = valueFont?.fontWithSize(16.0)
        contentView.addSubview(textView1)
        
        self.textView2 = UITextView(frame: CGRectZero)
        self.textView2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textView2.font = valueFont?.fontWithSize(16.0)
        self.textView2.userInteractionEnabled = true
        contentView.addSubview(textView2)
        
        var viewsDictionary = ["prompt1":prompt1, "prompt2":prompt2, "textView1":textView1, "textView2":textView2]
        var metricsDictionary = ["promptBottomMargin":promptBottomMargin, "textFieldBottomMargin":textFieldBottomMargin]
        
        var horizontalConstraintsPrompt1:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[prompt1]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalConstraintsPrompt2:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[prompt2]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalConstraintsAnswer1:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[textView1]-8-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalConstraintsAnswer2:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[textView2]-8-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)

        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[prompt1]-promptBottomMargin-[textView1(>=80)]-promptBottomMargin-[prompt2]-promptBottomMargin-[textView2(>=80)]-textFieldBottomMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraintsPrompt1)
        contentView.addConstraints(horizontalConstraintsPrompt2)
        contentView.addConstraints(horizontalConstraintsAnswer1)
        contentView.addConstraints(horizontalConstraintsAnswer2)
        contentView.addConstraints(verticalConstraints)
    }
    
    
    func collectData() -> [String : String] {
        var textEntry1 = self.textView1.text
        var textEntry2 = self.textView2.text
        
        return ["answer1":textEntry1, "answer2":textEntry2]
    }
    
}
