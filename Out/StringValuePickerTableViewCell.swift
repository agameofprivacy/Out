//
//  StringValuePickerTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/19/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class StringValuePickerTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, CollectStepData {

//    var stringValuePicker:UIPickerView!
    var fieldTitle:String!
    var fieldValues:[String] = ["Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye","Hello", "Hi", "Goodbye"]
    
    var pickerTableView:UITableView!
    
    var userDataDictionary:[String:String] = ["":""]
    var numberofRows = 1
    var horizontalMargin = 20
    var verticalMargin = 16

    var tableHeight:CGFloat!
    
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
        
        
        self.pickerTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.pickerTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.pickerTableView.delegate = self
        self.pickerTableView.dataSource = self
        self.pickerTableView.registerClass(PickerFieldsTableViewCell.self, forCellReuseIdentifier: "PickerFieldsTableViewCell")
        self.pickerTableView.registerClass(PickerViewTableViewCell.self, forCellReuseIdentifier: "PickerViewTableViewCell")
        self.pickerTableView.rowHeight = UITableViewAutomaticDimension
        self.pickerTableView.estimatedRowHeight = 80
        self.pickerTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        contentView.addSubview(pickerTableView)
        
        var viewsDictionary = ["pickerTableView":pickerTableView]
        var metricsDictionary = ["verticalMargin":verticalMargin]
        
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[pickerTableView(==257.5)]-0-|", options: NSLayoutFormatOptions(0), metrics:metricsDictionary, views: viewsDictionary)
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[pickerTableView(>=37.5)]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(verticalConstraints)
        contentView.addConstraints(horizontalConstraints)
        
        
//        self.fieldTitleLabel = UILabel(frame: CGRectZero)
//        self.fieldTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.fieldTitleLabel.numberOfLines = 1
//        self.fieldTitleLabel.textAlignment = NSTextAlignment.Left
//        self.fieldTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//        self.fieldTitleLabel.font = titleFont
//        self.fieldTitleLabel.text = "Title"
//        contentView.addSubview(self.fieldTitleLabel)
//        
//        self.fieldValueLabel = UILabel(frame: CGRectZero)
//        self.fieldValueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.fieldValueLabel.numberOfLines = 1
//        self.fieldValueLabel.textAlignment = NSTextAlignment.Left
//        self.fieldValueLabel.font = valueFont
//        self.fieldValueLabel.text = "Value"
//        contentView.addSubview(self.fieldValueLabel)
        
//        self.stringValuePicker = UIPickerView(frame: CGRectZero)
//        self.stringValuePicker.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.stringValuePicker.dataSource = self
//        self.stringValuePicker.delegate = self
//        self.stringValuePicker.hidden = false
//        contentView.addSubview(self.stringValuePicker)
        
//        var viewsDictionary = ["fieldTitleLabel":fieldTitleLabel, "fieldValueLabel":fieldValueLabel]
//        var metricsDictionary = ["horizontalMargin":horizontalMargin, "verticalMargin":verticalMargin]
//        
//        var horizontalConstraintsFields:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[fieldTitleLabel]-[fieldValueLabel]-horizontalMargin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
//        var horizontalConstraintsPicker:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[stringValuePicker]-0-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        var verticalConstraintsTitle:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=verticalMargin-[fieldTitleLabel]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
//        var verticalConstraintsValue:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=verticalMargin-[fieldValueLabel]-0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
//        contentView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        
//        contentView.addConstraints(horizontalConstraintsFields)
//        contentView.addConstraints(verticalConstraintsTitle)
//        contentView.addConstraints(verticalConstraintsValue)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.frame.size = self.pickerTableView.contentSize
        if indexPath.row == 0{
            var cell:PickerFieldsTableViewCell = tableView.dequeueReusableCellWithIdentifier("PickerFieldsTableViewCell") as PickerFieldsTableViewCell
            cell.fieldTitleLabel.text = fieldTitle
            cell.fieldValueLabel.text = "Tap to Select"
            var fieldsCellTapped:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: "fieldsCellTapped")
            cell.addGestureRecognizer(fieldsCellTapped)
            return cell
        }
        else{
            var cell:PickerViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("PickerViewTableViewCell") as PickerViewTableViewCell
            cell.values = self.fieldValues
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberofRows
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return fieldValues.count
//    }
    
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
//        var valueLabel = UILabel()
//        valueLabel.textAlignment = NSTextAlignment.Right
//        valueLabel.font = valueFont
//        valueLabel.font = valueFont?.fontWithSize(20.0)
//        valueLabel.text = self.fieldValues[row]
//        valueLabel.frame.size.width -= 20
    
//        var viewsDictionary = ["valueLabel":valueLabel]
//        var metricsDictionary = ["sideMargin":sideMargin]
//        
//        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[valueLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[valueLabel]-5-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
//        
//        view.addConstraints(horizontalConstraints)
//        view.addConstraints(verticalConstraints)
        
//        return valueLabel
//    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return fieldValues[row]
//    }

//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
    func collectData() -> [String : String] {
        return userDataDictionary
    }
//
//    func callUpPickerView(){
//        println("tapped!")
//        
//        if self.stringValuePicker.hidden{
//            self.frame.size.height += self.stringValuePicker.frame.height
//        }
//        else{
//            self.frame.size.height -= self.stringValuePicker.frame.height
//        }
//    }
    func fieldsCellTapped(){
        var temp = self.frame.origin
        var pickerCellIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        if self.pickerTableView.cellForRowAtIndexPath(pickerCellIndexPath) != nil{
            self.pickerTableView.beginUpdates()
            self.pickerTableView.deleteRowsAtIndexPaths([pickerCellIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.numberofRows--
            self.pickerTableView.endUpdates()
        }
        else{
            self.pickerTableView.beginUpdates()
            self.pickerTableView.insertRowsAtIndexPaths([pickerCellIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.numberofRows++
            self.pickerTableView.endUpdates()
        }
        self.frame.size = self.pickerTableView.contentSize
        self.frame.origin = temp
    }
    
}
