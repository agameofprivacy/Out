//
//  StringValuePickerTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class StringValuePickerTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, CollectStepData {

    var stringValuePicker:UIPickerView!
    var fieldTitle:String!
    var fieldValues:[String] = ["Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye"]
    var fieldTitleLabel:UILabel!
    var fieldValueLabel:UILabel!
    
    var userDataDictionary:[String:String] = ["":""]
    
    var horizontalMargin = 20
    var verticalMargin = 16

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.userInteractionEnabled = true
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: "callUpPickerView")
        contentView.addGestureRecognizer(tapRecognizer)
        
        
        self.fieldTitleLabel = UILabel(frame: CGRectZero)
        self.fieldTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldTitleLabel.numberOfLines = 1
        self.fieldTitleLabel.textAlignment = NSTextAlignment.Left
        self.fieldTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.fieldTitleLabel.font = titleFont
        self.fieldTitleLabel.text = "Title"
        contentView.addSubview(self.fieldTitleLabel)
        
        self.fieldValueLabel = UILabel(frame: CGRectZero)
        self.fieldValueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fieldValueLabel.numberOfLines = 1
        self.fieldValueLabel.textAlignment = NSTextAlignment.Left
        self.fieldValueLabel.font = valueFont
        self.fieldValueLabel.text = "Value"
        contentView.addSubview(self.fieldValueLabel)
        
        self.stringValuePicker = UIPickerView(frame: CGRectZero)
        self.stringValuePicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.stringValuePicker.dataSource = self
        self.stringValuePicker.delegate = self
        self.stringValuePicker.hidden = true
        contentView.addSubview(self.stringValuePicker)
        
        var viewsDictionary = ["fieldTitleLabel":fieldTitleLabel, "fieldValueLabel":fieldValueLabel, "stringValuePicker":stringValuePicker]
        var metricsDictionary = ["horizontalMargin":horizontalMargin, "verticalMargin":verticalMargin]
        
        var horizontalConstraintsFields:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[fieldTitleLabel]-[fieldValueLabel]-horizontalMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        var horizontalConstraintsPicker:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[stringValuePicker]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=verticalMargin-[fieldTitleLabel]-0-[stringValuePicker]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraintsValue:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=verticalMargin-[fieldValueLabel]-0-[stringValuePicker]-0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        
        contentView.addConstraints(horizontalConstraintsFields)
        contentView.addConstraints(verticalConstraintsTitle)
        contentView.addConstraints(verticalConstraintsValue)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fieldValues.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var valueLabel = UILabel()
        valueLabel.textAlignment = NSTextAlignment.Right
        valueLabel.font = valueFont
        valueLabel.font = valueFont?.fontWithSize(20.0)
        valueLabel.text = self.fieldValues[row]
        valueLabel.frame.size.width -= 20
        
//        var viewsDictionary = ["valueLabel":valueLabel]
//        var metricsDictionary = ["sideMargin":sideMargin]
//        
//        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[valueLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[valueLabel]-5-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
//        
//        view.addConstraints(horizontalConstraints)
//        view.addConstraints(verticalConstraints)
        
        return valueLabel
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return fieldValues[row]
//    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func collectData() -> [String : String] {
        return userDataDictionary
    }
    
    func callUpPickerView(){
        println("tapped!")
        
//        if self.stringValuePicker.hidden{
//            self.frame.size.height += self.stringValuePicker.frame.height
//        }
//        else{
//            self.frame.size.height -= self.stringValuePicker.frame.height
//        }
    }

}
