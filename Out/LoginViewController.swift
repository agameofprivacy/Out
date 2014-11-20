//
//  LoginViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var containerScrollView:UIScrollView!
    var aliasTextField:UITextField!
    var passwordTextField:UITextField!
    var instructionLabel:UILabel!
    var loginButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var createAccountButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Login"
        
        containerScrollView = UIScrollView(frame: self.view.frame)
        containerScrollView.alwaysBounceVertical = true

        self.view.addSubview(containerScrollView)
        
        
        let labelWidth = UIScreen.mainScreen().bounds.size.width - 24
        
        instructionLabel = UILabel(frame: CGRectZero)
        instructionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        instructionLabel.text = "Log in or create an account"
        instructionLabel.numberOfLines = 0
        instructionLabel.preferredMaxLayoutWidth = labelWidth
        instructionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        containerScrollView.addSubview(instructionLabel)
        
        aliasTextField = UITextField(frame: CGRectZero)
        aliasTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        aliasTextField.keyboardType = UIKeyboardType.Default
        aliasTextField.autocorrectionType = UITextAutocorrectionType.No
//        aliasTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        aliasTextField.placeholder = "alias"
        aliasTextField.borderStyle = UITextBorderStyle.RoundedRect
        aliasTextField.autocapitalizationType = UITextAutocapitalizationType.None
        containerScrollView.addSubview(aliasTextField)
        
        passwordTextField = UITextField(frame: CGRectZero)
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.keyboardType = UIKeyboardType.NumberPad
//        passwordTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordTextField.placeholder = "passcode"
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.secureTextEntry = true
        containerScrollView.addSubview(passwordTextField)
        
        loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        loginButton.addTarget(self, action: "loginButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blackColor().CGColor
        loginButton.layer.cornerRadius = 5
        containerScrollView.addSubview(loginButton)
        
        createAccountButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        createAccountButton.addTarget(self, action: "createAccountButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        createAccountButton.setTitle("Create Account", forState: UIControlState.Normal)
        createAccountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        createAccountButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blackColor().CGColor
        createAccountButton.layer.cornerRadius = 5
        containerScrollView.addSubview(createAccountButton)
        
        
        let viewsDictionary = ["instructionLabel":instructionLabel, "aliasTextField":aliasTextField, "passwordTextField":passwordTextField, "loginButton":loginButton, "createAccountButton":createAccountButton]
        
        let metricsDictionary = ["longVerticalSpace": 33,"mediumVerticalSpace": 20, "shortVerticalSpace": 16, "labelWidth":labelWidth]
        
        let horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-<=12-[instructionLabel(==labelWidth)]-<=12-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metricsDictionary, views: viewsDictionary)

        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=40-[instructionLabel]-mediumVerticalSpace-[aliasTextField(44)]-shortVerticalSpace-[passwordTextField(44)]->=40-[loginButton(44)]-shortVerticalSpace-[createAccountButton(44)]->=236-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        self.containerScrollView.addConstraints(horizontalConstraints)
        self.containerScrollView.addConstraints(verticalConstraints)
        
        
        var currentUser = PFUser.currentUser()
        // Do any additional setup after loading the view.
        if currentUser != nil {
            // Do stuff with the user
        } else {
            // Show the signup or login screen
        }
//        aliasTextField.becomeFirstResponder()

    }

    
    override func viewDidAppear(animated: Bool) {
        self.aliasTextField.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        aliasTextField.text = ""
        passwordTextField.text = ""
    }
    
    func loginButtonTapped(sender: UIButton) {
        self.loginButton.enabled = false
        self.aliasTextField.enabled = false
        self.passwordTextField.enabled = false
        PFUser.logInWithUsernameInBackground(self.aliasTextField.text, password:self.passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("LoggedIn", sender: nil)
            } else {
                // The login failed. Check error to see why.
                self.loginButton.enabled = true
                self.aliasTextField.enabled = true
                self.passwordTextField.enabled = true
            }
        }
    }
    
    func createAccountButtonTapped(sender: UIButton){
        performSegueWithIdentifier("CreateAccount", sender: self)
    }

}
