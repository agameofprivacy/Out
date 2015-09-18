//
//  PeopleFilterViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import XLForm

class PeopleFilterViewController: XLFormViewController {
    
//    var tableView:TPKeyboardAvoidingTableView!
//    var filterCategories:[String] = ["Gender Identity", "Sexual Orientation"]
//    var filterDictionary:[String:[String]] = ["Gender Identity":["Man", "Woman", "Trans-man", "Trans-woman", "Genderqueer", "Non-binary"], "Sexual Orientation":["Lesbian", "Gay", "Bisexual", "Pansexual", "Asexual"]]

    var genderArray = ["Agender", "Androgyne", "Bigender", "Boi", "Butch", "Cisgender", "Female", "Femme", "FTM", "Genderfluid", "Genderqueer", "Gender non-conforming", "Intersex", "Male", "Man", "MTF", "Pangender", "Queer", "Third Gender", "Transgender", "Trans", "Trans man", "Trans woman", "Two spirit", "Woman", "No label", "Other"]
    
    var sexualOrientationArray = ["Asexual", "Bisexual", "Demisexual", "Gay", "Gray-Asexual", "Lesbian", "Pansexual", "Polysexual", "Pomosexual", "Queer", "Straight", "No label", "Other"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar init and layout
        self.navigationItem.title = "Filter"
        
        let closeButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        let applyButton = UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: "applyButtonTapped:")
        applyButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = applyButton
        
//        self.tableView = TPKeyboardAvoidingTableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
//        self.tableView.rowHeight = 48
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.view.addSubview(self.tableView)
        
        self.tableView.contentInset.top = 64
        
        // Do any additional setup after loading the view.
        let form = XLFormDescriptor(title: "filter")
        var section:XLFormSectionDescriptor
        var row:XLFormRowDescriptor

        section = XLFormSectionDescriptor.formSectionWithTitle("Age, Identity, and Orientation") 
        form.addFormSection(section)

        row = XLFormRowDescriptor(tag: "Gender Identity", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Gender Identity")
        row.selectorOptions = []
        let genderOptions:NSMutableArray = []
        for gender in self.genderArray{
            genderOptions.addObject(XLFormOptionsObject(value: gender, displayText: gender))
        }
        row.selectorOptions = genderOptions as [AnyObject]
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Sexual Orientation", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Sexual Orientation")
        row.selectorOptions = []
        let sexualOrientationOptions:NSMutableArray = []
        for sexualOrientation in self.sexualOrientationArray{
            sexualOrientationOptions.addObject(XLFormOptionsObject(value: sexualOrientation, displayText: sexualOrientation))
        }
        row.selectorOptions = genderOptions as [AnyObject]
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Minimum Age", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Minimum Age")
        row.selectorOptions = []
        let ageRange:NSMutableArray = []
        for (var i = 13; i <= 99; ++i){
            ageRange.addObject(XLFormOptionsObject(value: i, displayText: "\(i)"))
        }
        row.selectorOptions = ageRange as [AnyObject]
        row.title = "Minimum Age"
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Maximum Age", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Maximum Age")
        row.selectorOptions = []
        row.title = "Maximum Age"
        row.selectorOptions = ageRange as [AnyObject]
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Location") 
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "State", rowType: XLFormRowDescriptorTypeSelectorPickerViewInline, title: "State")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "AL", displayText: "Alabama"),
                XLFormOptionsObject(value: "AK", displayText: "Alaska"),
                XLFormOptionsObject(value: "AZ", displayText: "Arizona"),
                XLFormOptionsObject(value: "AR", displayText: "Arkansas"),
                XLFormOptionsObject(value: "CA", displayText: "California"),
                XLFormOptionsObject(value: "CO", displayText: "Colorado"),
                XLFormOptionsObject(value: "CT", displayText: "Connecticut"),
                XLFormOptionsObject(value: "DC", displayText: "Washington DC"),
                XLFormOptionsObject(value: "DE", displayText: "Delaware"),
                XLFormOptionsObject(value: "FL", displayText: "Florida"),
                XLFormOptionsObject(value: "GA", displayText: "Georgia"),
                XLFormOptionsObject(value: "HI", displayText: "Hawaii"),
                XLFormOptionsObject(value: "ID", displayText: "Idaho"),
                XLFormOptionsObject(value: "IL", displayText: "Illinois"),
                XLFormOptionsObject(value: "IN", displayText: "Indiana"),
                XLFormOptionsObject(value: "IA", displayText: "Iowa"),
                XLFormOptionsObject(value: "KS", displayText: "Kansas"),
                XLFormOptionsObject(value: "KY", displayText: "Kentucky"),
                XLFormOptionsObject(value: "LA", displayText: "Louisiana"),
                XLFormOptionsObject(value: "ME", displayText: "Maine"),
                XLFormOptionsObject(value: "MD", displayText: "Maryland"),
                XLFormOptionsObject(value: "MA", displayText: "Massachusetts"),
                XLFormOptionsObject(value: "MI", displayText: "Michigan"),
                XLFormOptionsObject(value: "MN", displayText: "Minnesota"),
                XLFormOptionsObject(value: "MS", displayText: "Mississippi"),
                XLFormOptionsObject(value: "MO", displayText: "Missouri"),
                XLFormOptionsObject(value: "MT", displayText: "Montana"),
                XLFormOptionsObject(value: "NE", displayText: "Nebraska"),
                XLFormOptionsObject(value: "NV", displayText: "Nevada"),
                XLFormOptionsObject(value: "NH", displayText: "New Hampshire"),
                XLFormOptionsObject(value: "NJ", displayText: "New Jersey"),
                XLFormOptionsObject(value: "NM", displayText: "New Mexico"),
                XLFormOptionsObject(value: "NY", displayText: "New York"),
                XLFormOptionsObject(value: "NC", displayText: "North Carolina"),
                XLFormOptionsObject(value: "ND", displayText: "North Dakota"),
                XLFormOptionsObject(value: "OH", displayText: "Ohio"),
                XLFormOptionsObject(value: "OK", displayText: "Oklahoma"),
                XLFormOptionsObject(value: "OR", displayText: "Oregon"),
                XLFormOptionsObject(value: "PA", displayText: "Pennsylvania"),
                XLFormOptionsObject(value: "RI", displayText: "Rhode Island"),
                XLFormOptionsObject(value: "SC", displayText: "South Carolina"),
                XLFormOptionsObject(value: "SD", displayText: "South Dakota"),
                XLFormOptionsObject(value: "TN", displayText: "Tennessee"),
                XLFormOptionsObject(value: "TX", displayText: "Texas"),
                XLFormOptionsObject(value: "UT", displayText: "Utah"),
                XLFormOptionsObject(value: "VT", displayText: "Vermont"),
                XLFormOptionsObject(value: "VA", displayText: "Virginia"),
                XLFormOptionsObject(value: "WA", displayText: "Washington"),
                XLFormOptionsObject(value: "WV", displayText: "West Virginia"),
                XLFormOptionsObject(value: "WI", displayText: "Wisconsin"),
                XLFormOptionsObject(value: "WY", displayText: "Wyoming")
        ]
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "City", rowType: XLFormRowDescriptorTypeText, title: "City")
        let paddingView6 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        row.cellConfig.setObject(paddingView6, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        section.addFormRow(row)

        section = XLFormSectionDescriptor.formSectionWithTitle("Culture") 
        form.addFormSection(section)

        row = XLFormRowDescriptor(tag: "Ethnicity", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Ethnicity")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "Taiwanese", displayText: "Taiwanese"),
                XLFormOptionsObject(value: "Italian", displayText: "Italian"),
                XLFormOptionsObject(value: "German", displayText: "German"),
                XLFormOptionsObject(value: "Irish", displayText: "Irish"),
                XLFormOptionsObject(value: "American", displayText: "American"),
                XLFormOptionsObject(value: "Jamaican", displayText: "Jamaican")
        ]
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Religion", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Religion")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "Protestant", displayText: "Protestant"),
                XLFormOptionsObject(value: "Catholic", displayText: "Catholic"),
                XLFormOptionsObject(value: "Jewish", displayText: "Jewish"),
                XLFormOptionsObject(value: "Buddhist", displayText: "Buddhist"),
                XLFormOptionsObject(value: "Agnostic", displayText: "Agnostic"),
                XLFormOptionsObject(value: "Atheist", displayText: "Atheist")
        ]
        section.addFormRow(row)

        
        self.form = form
        
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.filterCategories.count
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.filterCategories[section]
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "filterCell")
//        var categoryFilters:[String] = self.filterDictionary[self.filterCategories[indexPath.section]]!
//        cell.textLabel!.text = categoryFilters[indexPath.row]
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var categoryFilters:[String] = self.filterDictionary[self.filterCategories[section]]!
//        return categoryFilters.count
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Dismiss people filter view if Close button tapped
    func closeButtonTapped(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Apply people filter if Apply button tapped
    func applyButtonTapped(sender: UIBarButtonItem){
        let peopleGalleryVC = self.parentViewController?.presentingViewController?.childViewControllers[0] as! PeopleGalleryViewController
        let values = self.form.formValues()
        var filterDictionary:[String:[String]] = Dictionary(minimumCapacity: 0)
        for value in values{
            let valueActual: AnyObject = value.1
            if valueActual.isKindOfClass(XLFormOptionsObject){
                filterDictionary.updateValue(["\((valueActual as! XLFormOptionsObject).valueData())"], forKey: value.0 as! String)
            }
            else{
                if !valueActual.isKindOfClass(NSNull){
                    filterDictionary.updateValue(["\(valueActual as! String)"], forKey: value.0 as! String)
                }
            }
        }
        peopleGalleryVC.filterDictionary = filterDictionary
        peopleGalleryVC.loadPeople()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
