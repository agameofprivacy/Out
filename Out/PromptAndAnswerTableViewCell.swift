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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        
        self.prompt1 = UILabel(frame: CGRectZero)
        self.prompt1.numberOfLines = 0
        self.prompt1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.prompt1.textAlignment = NSTextAlignment.Left
        self.prompt1.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.prompt1.preferredMaxLayoutWidth = contentView.frame.width - 20
        contentView.addSubview(prompt1)
        
        self.prompt2 = UILabel(frame: CGRectZero)
        self.prompt2.numberOfLines = 0
        self.prompt2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.prompt2.textAlignment = NSTextAlignment.Left
        self.prompt2.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.prompt2.preferredMaxLayoutWidth = contentView.frame.width - 20
        contentView.addSubview(prompt2)
        
        self.textView1 = UITextView(frame: CGRectZero)
        self.textView1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textView1.font = UIFont.systemFontOfSize(17.0)
        self.textView1.userInteractionEnabled = true
        self.textView1.isFirstResponder()
        contentView.addSubview(textView1)
        
        self.textView2 = UITextView(frame: CGRectZero)
        self.textView2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.textView2.font = UIFont.systemFontOfSize(17.0)
        self.textView2.userInteractionEnabled = true
        contentView.addSubview(textView2)
        
//        self.addDoneToolBarToKeyboard(self.textView1)
//        self.addDoneToolBarToKeyboard(self.textView2)
        
        var viewsDictionary = ["prompt1":prompt1, "prompt2":prompt2, "textField1":textView1, "textField2":textView2]
        var metricsDictionary = ["promptBottomMargin":promptBottomMargin, "textFieldBottomMargin":textFieldBottomMargin]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[prompt1]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[prompt1]-promptBottomMargin-[textField1(>=80)]-promptBottomMargin-[prompt2]-promptBottomMargin-[textField2(>=80)]-textFieldBottomMargin-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
    }
    
    
    func collectData() -> [String : String] {
        var textEntry1 = self.textView1.text
        var textEntry2 = self.textView2.text
        
        return ["answer1":textEntry1, "answer2":textEntry2]
    }
    
//    func addDoneToolBarToKeyboard(currentTextView:UITextView){
//        var doneToolBar:UIToolbar = UIToolbar(frame: CGRectMake(0, 0, self.bounds.width, 44))
//        doneToolBar.barStyle = UIBarStyle.Default
//
//        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneButtonPressed:")
//        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
//        doneButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//        var toolBarItems = [flexibleSpace, doneButton]
//        doneToolBar.setItems(toolBarItems, animated: false)
//        currentTextView.inputAccessoryView = doneToolBar
//    }
    
//    func doneButtonPressed(sender:UIBarButtonItem){
//        textView1.resignFirstResponder()
//        textView2.resignFirstResponder()
//    }
    
    
}
