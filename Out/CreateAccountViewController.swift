//
//  CreateAccountViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/1/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var instructionLabel:UILabel!
    var aliasTextField:UITextField!
    var passwordTextField:UITextField!
    var passwordConfirmTextField:UITextField!
    var createAccountButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create Account"
        
        containerScrollView = UIScrollView(frame: self.view.frame)
        containerScrollView.alwaysBounceVertical = true
        
        self.view.addSubview(containerScrollView)

        let labelWidth = UIScreen.mainScreen().bounds.size.width - 24

        instructionLabel = UILabel(frame: CGRectZero)
        instructionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        instructionLabel.text = "Create an account using an anonymous alias"
        instructionLabel.numberOfLines = 0
        instructionLabel.preferredMaxLayoutWidth = labelWidth
        instructionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        containerScrollView.addSubview(instructionLabel)

        aliasTextField = UITextField(frame: CGRectZero)
        aliasTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        aliasTextField.keyboardType = UIKeyboardType.Default
        aliasTextField.autocorrectionType = UITextAutocorrectionType.No
        aliasTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        aliasTextField.placeholder = "alias"
        aliasTextField.borderStyle = UITextBorderStyle.RoundedRect
        aliasTextField.autocapitalizationType = UITextAutocapitalizationType.None
        containerScrollView.addSubview(aliasTextField)

        passwordTextField = UITextField(frame: CGRectZero)
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.keyboardType = UIKeyboardType.NumberPad
        passwordTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordTextField.placeholder = "passcode"
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.secureTextEntry = true
        containerScrollView.addSubview(passwordTextField)

        passwordConfirmTextField = UITextField(frame: CGRectZero)
        passwordConfirmTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordConfirmTextField.keyboardType = UIKeyboardType.NumberPad
        passwordConfirmTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordConfirmTextField.placeholder = "confirm passcode"
        passwordConfirmTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordConfirmTextField.secureTextEntry = true
        containerScrollView.addSubview(passwordConfirmTextField)
        
        createAccountButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        createAccountButton.addTarget(self, action: "createAccountButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        createAccountButton.setTitle("Create", forState: UIControlState.Normal)
        createAccountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        createAccountButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blackColor().CGColor
        createAccountButton.layer.cornerRadius = 5
        containerScrollView.addSubview(createAccountButton)

        let viewsDictionary = ["instructionLabel":instructionLabel, "aliasTextField":aliasTextField, "passwordTextField":passwordTextField, "passwordConfirmTextField":passwordConfirmTextField, "createAccountButton":createAccountButton]
        
        let metricsDictionary = ["longVerticalSpace": 33,"mediumVerticalSpace": 20, "shortVerticalSpace": 16, "labelWidth":labelWidth]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-<=12-[instructionLabel(==labelWidth)]-<=12-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)
        
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=40-[instructionLabel]-mediumVerticalSpace-[aliasTextField(44)]-shortVerticalSpace-[passwordTextField(44)]-shortVerticalSpace-[passwordConfirmTextField(44)]->=40-[createAccountButton(44)]->=236-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        self.containerScrollView.addConstraints(horizontalConstraints)
        self.containerScrollView.addConstraints(verticalConstraints)
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        aliasTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createAccountButtonTapped(sender:UIButton){
        self.createAccountButton.enabled = false
        if self.aliasTextField.text != nil{
            if self.passwordTextField.text != nil && self.passwordTextField.text == self.passwordConfirmTextField.text {
                var user = PFUser()
                user.username = self.aliasTextField.text
                user.password = self.passwordConfirmTextField.text
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, error: NSError!) -> Void in
                    if error == nil {
                        // Hooray! Let them use the app now.
                        var followerFollowingObject = PFObject(className: "FollowerFollowing")
                        followerFollowingObject["ownerUser"] = PFUser.currentUser()
                        followerFollowingObject["requestsFromUsers"] = []
                        followerFollowingObject["followingUsers"] = []
                        followerFollowingObject.saveInBackground()
                        self.performSegueWithIdentifier("AccountCreated", sender: nil)
                    } else {
                        // Show the errorString somewhere and let the user try again.
                    }
                }
                
            }
            else{
                self.createAccountButton.enabled = true
            }
        }
        else{
            self.createAccountButton.enabled = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
