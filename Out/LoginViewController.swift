//
//  LoginViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit


// Controller for the login screen as well as ICETutorial pages
class LoginViewController: UIViewController, ICETutorialControllerDelegate {
    
    // Container TPKeyboardAvoidingScrollView for login view
    var containerScrollView:TPKeyboardAvoidingScrollView!

    // Controller for ICETutorial
    var controller:ICETutorialController!
    
    // Login form views
    var aliasTextField:UITextField!
    var passwordTextField:UITextField!
    var logoImageView:UIImageView!
    var loginButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton

    // Boolean to determine whether to present tutorial automatically (on app launch)
    var showTutorial = true
    
    // Boolean to determine whether to hide containerScrollView
    var scrollViewHidden = true
    
    override func viewDidLoad() {

        // Hide UIStatusBar
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        super.viewDidLoad()
        
        containerScrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.containerScrollView.hidden = scrollViewHidden
        self.view.backgroundColor = UIColor.whiteColor()

        if (showTutorial){

            // Initialize tutorial pages texts, and pictures.
            var layer0: ICETutorialPage = ICETutorialPage(title: "", subTitle: "", pictureName: "Logo_tutorial", duration: 2.5)
            var layer1: ICETutorialPage = ICETutorialPage(title: "Dashboard", subTitle: "Get an overview of your challenges\nand your current challenges.", pictureName: "Dashboard_tutorial", duration: 4.0)
            var layer2: ICETutorialPage = ICETutorialPage(title: "Challenges", subTitle: "Take on challenges to go forward\nin your coming out journey.", pictureName: "Challenges_tutorial", duration: 4.0)
            var layer3: ICETutorialPage = ICETutorialPage(title: "Activity", subTitle: "See challenges completed by people\nyou follow and cheer them up.", pictureName: "Activity_tutorial", duration: 4.0)
            var layer4: ICETutorialPage = ICETutorialPage(title: "People", subTitle: "Find and connect with others with\n similar backgrounds as you.", pictureName: "People_tutorial", duration: 4.0)
            var layer5: ICETutorialPage = ICETutorialPage(title: "Help", subTitle: "Reach out for help if you would like\nsomeone to talk to or chat with.", pictureName: "Help_tutorial", duration: 4.0)

            // Set the common style for Titles and Description (can be overrided on each page).
            var titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
            titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 26.0)
            titleStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
            titleStyle.linesNumber = 1
            titleStyle.offset = 210
            
            // Set the common style for SubTitles and Description (can be overrided on each page).
            var subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
            subStyle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            subStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
            subStyle.linesNumber = 2
            subStyle.offset = 160
            
            
            var listPages: [ICETutorialPage] = [layer0, layer1, layer2, layer3, layer4, layer5]
            
            controller = ICETutorialController(pages: listPages, delegate: self)
            ICETutorialStyle.sharedInstance().titleStyle = titleStyle
            ICETutorialStyle.sharedInstance().subTitleStyle = subStyle
            controller.startScrolling()
            
            // present ICETutorial view
            self.presentViewController(controller, animated: false, completion: nil)
        }
        
        
        // Initialize logoImage UIImageView
        logoImageView = UIImageView(frame: CGRectZero)
        logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        logoImageView.image = UIImage(named: "out_logo.png")
        logoImageView.userInteractionEnabled = true
        var viewTutorial = UITapGestureRecognizer(target: self, action: "viewTutorial")
        logoImageView.addGestureRecognizer(viewTutorial)
        containerScrollView.addSubview(logoImageView)

        // Initialize alias UITextField
        aliasTextField = UITextField(frame: CGRectZero)
        aliasTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        aliasTextField.keyboardType = UIKeyboardType.Default
        aliasTextField.autocorrectionType = UITextAutocorrectionType.No
        aliasTextField.placeholder = "alias"
        aliasTextField.textAlignment = NSTextAlignment.Left
        aliasTextField.borderStyle = UITextBorderStyle.None
        aliasTextField.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        aliasTextField.autocapitalizationType = UITextAutocapitalizationType.None
        containerScrollView.addSubview(aliasTextField)
        
        // Initialize password UITextField
        passwordTextField = UITextField(frame: CGRectZero)
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.keyboardType = UIKeyboardType.Default
        passwordTextField.placeholder = "passcode"
        passwordTextField.textAlignment = NSTextAlignment.Left
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        passwordTextField.borderStyle = UITextBorderStyle.None
        passwordTextField.secureTextEntry = true
        containerScrollView.addSubview(passwordTextField)
        
        // Initialize login UIButton properties
        loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        loginButton.addTarget(self, action: "loginButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blackColor().CGColor
        loginButton.layer.cornerRadius = 5
        containerScrollView.addSubview(loginButton)
        

        // Constraints and layout for login view
        let viewsDictionary = ["logoImageView":logoImageView, "aliasTextField":aliasTextField, "passwordTextField":passwordTextField, "loginButton":loginButton]
        let metricsDictionary = ["longVerticalSpace": 33,"mediumVerticalSpace": 20, "shortVerticalSpace": 16]
        let horizontalLogoConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=137-[logoImageView(101)]->=137-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalFormConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[aliasTextField(>=280)]-20-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalTopConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=70-[logoImageView(101)]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalSecondConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[logoImageView(101)]-20-[aliasTextField(44)]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalBottomConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aliasTextField(44)]-shortVerticalSpace-[passwordTextField(44)]->=40-[loginButton(44)]->=20-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)

        self.containerScrollView.addConstraints(horizontalFormConstraints)
        self.containerScrollView.addConstraints(horizontalLogoConstraints)
        self.containerScrollView.addConstraints(verticalTopConstraints)
        self.containerScrollView.addConstraints(verticalSecondConstraints)
        self.containerScrollView.addConstraints(verticalBottomConstraints)
        
        self.view.addSubview(containerScrollView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Empties form fields when login view disappears
    override func viewDidDisappear(animated: Bool) {
        aliasTextField.text = ""
        passwordTextField.text = ""
    }
    

    // Login(left) button tapped to dismiss ICETutorial view
    func tutorialController(tutorialController: ICETutorialController!, didClickOnLeftButton sender: UIButton!) {
        self.containerScrollView.hidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        self.aliasTextField.becomeFirstResponder()
    }

    // Signup(right) button tapped to present modal signup view
    func tutorialController(tutorialController: ICETutorialController!, didClickOnRightButton sender: UIButton!) {
        self.containerScrollView.hidden = true
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("signup", sender: self)
        self.containerScrollView.hidden = false
        self.aliasTextField.resignFirstResponder()
        println("signup!")
    }

    // Login button tapped to authenticate provided user credentials
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
    
    // Initializes and presents ICETutorial pages
    func viewTutorial(){
        // Init the pages texts, and pictures.
        
        var layer0: ICETutorialPage = ICETutorialPage(title: "", subTitle: "", pictureName: "Logo_tutorial", duration: 2.5)
        var layer1: ICETutorialPage = ICETutorialPage(title: "Dashboard", subTitle: "Get an overview of your challenges\nand your current challenges.", pictureName: "Dashboard_tutorial", duration: 4.0)
        var layer2: ICETutorialPage = ICETutorialPage(title: "Challenges", subTitle: "Take on challenges to go forward\nin your coming out journey.", pictureName: "Challenges_tutorial", duration: 4.0)
        var layer3: ICETutorialPage = ICETutorialPage(title: "Activity", subTitle: "See challenges completed by people\nyou follow and cheer them up.", pictureName: "Activity_tutorial", duration: 4.0)
        var layer4: ICETutorialPage = ICETutorialPage(title: "People", subTitle: "Find and connect with others with\n similar backgrounds as you.", pictureName: "People_tutorial", duration: 4.0)
        var layer5: ICETutorialPage = ICETutorialPage(title: "Help", subTitle: "Reach out for help if you would like\nsomeone to talk to or chat with.", pictureName: "Help_tutorial", duration: 4.0)
        
        // Set the common style for SubTitles and Description (can be overrided on each page).
        var titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 26.0)
        titleStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        titleStyle.linesNumber = 1
        titleStyle.offset = 210

        // Set the common style for Titles and Description (can be overrided on each page).
        var subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        subStyle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        subStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        subStyle.linesNumber = 2
        subStyle.offset = 160
        
        var listPages: [ICETutorialPage] = [layer0, layer1, layer2, layer3, layer4, layer5]
        
        controller = ICETutorialController(pages: listPages, delegate: self)
        ICETutorialStyle.sharedInstance().titleStyle = titleStyle
        ICETutorialStyle.sharedInstance().subTitleStyle = subStyle
        controller.startScrolling()
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}
