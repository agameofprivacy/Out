//
//  CreateAccountViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import XLForm
import Parse
// Controller for signup view
class CreateAccountViewController: XLFormViewController {

    
    var genderArray = ["Agender", "Androgyne", "Bigender", "Boi", "Butch", "Cisgender", "Female", "Femme", "FTM", "Genderfluid", "Genderqueer", "Gender non-conforming", "Intersex", "Male", "Man", "MTF", "Pangender", "Queer", "Third Gender", "Transgender", "Trans", "Trans man", "Trans woman", "Two spirit", "Woman", "No label", "Other"]
    
    var sexualOrientationArray = ["Asexual", "Bisexual", "Demisexual", "Gay", "Gray-Asexual", "Lesbian", "Pansexual", "Polysexual", "Pomosexual", "Queer", "Straight", "No label", "Other"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize and place close and confirm buttons
        let closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.title = "Signup"
        let confirmButton = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Plain, target: self, action: "confirmButtonTapped:")
        confirmButton.tintColor = UIColor.blackColor()
        confirmButton.enabled = false
        self.navigationItem.rightBarButtonItem = confirmButton
        
        
        // Initiate XLForm objects
        let form = XLFormDescriptor(title:"Signup")
        var section:XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        // Alias & password section
        section = XLFormSectionDescriptor.formSectionWithTitle("Login (Required)") 
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "Alias", rowType: XLFormRowDescriptorTypeAccount, title: "Alias")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        let paddingView1 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView1, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Password", rowType: XLFormRowDescriptorTypePassword, title: "Password")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView2, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Verify Password", rowType: XLFormRowDescriptorTypePassword, title: "Verify Password")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        let paddingView3 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView3, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)
        
        // Background section
        section = XLFormSectionDescriptor.formSectionWithTitle("Background (Optional)") 
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
        
        row = XLFormRowDescriptor(tag: "Avatar", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Avatar")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "elephant", displayText: "Elephant"),
                XLFormOptionsObject(value: "snake", displayText: "Snake"),
                XLFormOptionsObject(value: "butterfly", displayText: "Butterfly"),
                XLFormOptionsObject(value: "snail", displayText: "Snail"),
                XLFormOptionsObject(value: "horse", displayText: "Horse"),
                XLFormOptionsObject(value: "bird", displayText: "Bird"),
                XLFormOptionsObject(value: "turtle", displayText: "Turtle"),
                XLFormOptionsObject(value: "sheep", displayText: "Sheep"),
                XLFormOptionsObject(value: "bear", displayText: "Bear"),
                XLFormOptionsObject(value: "littleBird", displayText: "Little Bird"),
                XLFormOptionsObject(value: "rabbit", displayText: "Rabbit"),
                XLFormOptionsObject(value: "caterpillar", displayText: "Caterpillar"),
                XLFormOptionsObject(value: "crab", displayText: "Crab"),
                XLFormOptionsObject(value: "fish", displayText: "Fish"),
                XLFormOptionsObject(value: "cat", displayText: "Cat")
            ]
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Color", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Color")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "orange", displayText: "Orange"),
                XLFormOptionsObject(value: "brown", displayText: "Brown"),
                XLFormOptionsObject(value: "teal", displayText: "Teal"),
                XLFormOptionsObject(value: "purple", displayText: "Purple"),
                XLFormOptionsObject(value: "pink", displayText: "Pink"),
                XLFormOptionsObject(value: "lightBlue", displayText: "Light Blue"),
                XLFormOptionsObject(value: "yellowGreen", displayText: "Yellow Green"),
                XLFormOptionsObject(value: "vibrantBlue", displayText: "Vibrant Blue"),
                XLFormOptionsObject(value: "vibrantGreen", displayText: "Vibrant Green")
            ]
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Age", rowType: XLFormRowDescriptorTypeInteger, title: "Age")
        let paddingView4 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        row.cellConfig.setObject(paddingView4, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Ethnicity", rowType: XLFormRowDescriptorTypeText, title: "Ethnicity")
        let paddingView5 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        row.cellConfig.setObject(paddingView5, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Religion", rowType: XLFormRowDescriptorTypeSelectorPickerViewInline, title: "Religion")
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

        row = XLFormRowDescriptor(tag: "Bio", rowType: XLFormRowDescriptorTypeText, title: "Bio")
        let paddingView7 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        row.cellConfig.setObject(paddingView7, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        section.addFormRow(row)

        
        self.form = form
    }
    
    
    // Detect password match to enable Confirm button
    override func textFieldDidEndEditing(textField: UITextField) {
        
        let nullObject = NSNull()
        var values = self.form.formValues()
        if (values["Alias"] as? NSNull == nullObject) || (values["Password"] as? NSNull == nullObject) || (values["Verify Password"] as? NSNull == nullObject){
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        else{
            if (values["Password"] as! String == values["Verify Password"] as! String){
                self.navigationItem.rightBarButtonItem?.enabled = true
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Dismiss modal signup view if Close button tapped
    func closeButtonTapped(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Initiate account creation if Confirm button tapped
    func confirmButtonTapped(sender:UIBarButtonItem){
        _ = NSNull()

        var values = self.form.formValues()
        let user = PFUser()

        user.username = values["Alias"] as? String
        user.password = values["Password"] as? String
        user["age"] = values["Age"] as! Int
        user["genderIdentity"] = (values["Gender Identity"] as! XLFormOptionsObject).valueData()
        user["sexualOrientation"] = (values["Sexual Orientation"] as! XLFormOptionsObject).valueData()
        user["avatar"] = (values["Avatar"] as! XLFormOptionsObject).valueData()
        user["color"] = (values["Color"] as! XLFormOptionsObject).valueData()
        user["ethnicity"] = values["Ethnicity"] as! String
        user["city"] = values["City"] as! String
        user["religion"] = (values["Religion"] as! XLFormOptionsObject).valueData()
        user["state"] = (values["State"] as! XLFormOptionsObject).valueData()
        user["shortBio"] = values["Bio"] as! String
        user["followingRequested"] = []
        user["followingRequestsFrom"] = []
        
        user.signUpInBackgroundWithBlock {
            (succeeded, error) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                let followerFollowingObject = PFObject(className: "FollowerFollowing")
                followerFollowingObject["ownerUser"] = PFUser.currentUser()
                followerFollowingObject["requestsFromUsers"] = []
                followerFollowingObject["followingUsers"] = []
                followerFollowingObject["followers"] = []
                followerFollowingObject.saveInBackgroundWithBlock(nil)
                self.performSegueWithIdentifier("AccountCreated", sender: nil)
            } else {
                // Show the errorString somewhere and let the user try again.
            }
        }

    }
}
