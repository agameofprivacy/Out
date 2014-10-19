//
//  LoginViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

//    @IBOutlet weak var aliasTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
    
    var aliasTextField:UITextField!
    var passwordTextField:UITextField!
    var instructionLabel:UILabel!
    var loginButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var createAccountButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel = UILabel(frame: CGRectZero)
        instructionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        instructionLabel.text = "Log in or create an account"
        instructionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.view.addSubview(instructionLabel)
        
        aliasTextField = UITextField(frame: CGRectZero)
        aliasTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        aliasTextField.keyboardType = UIKeyboardType.Default
        aliasTextField.autocorrectionType = UITextAutocorrectionType.No
        aliasTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        aliasTextField.placeholder = "alias"
        aliasTextField.borderStyle = UITextBorderStyle.RoundedRect
        aliasTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.view.addSubview(aliasTextField)
        
        passwordTextField = UITextField(frame: CGRectZero)
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.keyboardType = UIKeyboardType.NumberPad
        passwordTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordTextField.placeholder = "passcode"
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.secureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        loginButton.addTarget(self, action: "loginButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        self.view.addSubview(loginButton)
        
        createAccountButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        createAccountButton.addTarget(self, action: "createAccountButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        createAccountButton.setTitle("Create an Account Anonymously", forState: UIControlState.Normal)
        createAccountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left

        self.view.addSubview(createAccountButton)
        
        let viewsDictionary = ["instructionLabel":instructionLabel, "aliasTextField":aliasTextField, "passwordTextField":passwordTextField, "loginButton":loginButton, "createAccountButton":createAccountButton]
        
        let metricsDictionary = ["longVerticalSpace": 33,"mediumVerticalSpace": 25, "shortVerticalSpace": 16]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-<=20-[instructionLabel(<=374)]-<=20-|", options: NSLayoutFormatOptions.AlignAllTop, metrics: metricsDictionary, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=36-[instructionLabel]-mediumVerticalSpace-[aliasTextField]-shortVerticalSpace-[passwordTextField]->=mediumVerticalSpace-[loginButton]-shortVerticalSpace-[createAccountButton]-<=322-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalConstraints)
        
        aliasTextField.becomeFirstResponder()
        
        
        
        var currentUser = PFUser.currentUser()
        // Do any additional setup after loading the view.
        if currentUser != nil {
            // Do stuff with the user
        } else {
            // Show the signup or login screen
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonTapped(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(self.aliasTextField.text, password:self.passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("LoggedIn", sender: nil)
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    func createAccountButtonTapped(sender: UIButton){
        performSegueWithIdentifier("CreateAccount", sender: self)
    }

}
