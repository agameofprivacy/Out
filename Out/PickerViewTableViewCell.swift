//
//  PickerViewTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/25/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PickerViewTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, CollectStepData{

    var pickerView:UIPickerView!
    var values:[String]!
    var key:String!
    
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 18.0)

    var userDataDictionary:[String:String] = ["":""]

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.pickerView = UIPickerView(frame: CGRectZero)
        self.pickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.showsSelectionIndicator = true
        self.pickerView.hidden = true
        contentView.addSubview(self.pickerView)
        
        var viewsDictionary = ["pickerView":pickerView]
        var metricsDictionary = ["zeroMargin":0]
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-120-[pickerView]-8-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-zeroMargin-[pickerView]-zeroMargin-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(horizontalConstraints)
        contentView.addConstraints(verticalConstraints)
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var valueLabel = UILabel()
        valueLabel.textAlignment = NSTextAlignment.Right
        valueLabel.font = valueFont
        valueLabel.text = self.values[row]
        return valueLabel
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func collectData() -> [String : String] {
        var selectedRow = self.pickerView.selectedRowInComponent(0)
        self.userDataDictionary = [key:values[selectedRow]]
        return self.userDataDictionary
    }
}
