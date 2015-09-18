//
//  LoginViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import ICETutorial
import TPKeyboardAvoiding
import Parse


private let LQSLayerAppIDString = "2b505222-c8f2-11e4-9b75-eae81f0006da"

#if arch(i386) || arch(x86_64) // simulator
    let LQSCurrentUserID     = "Simulator"
    let LQSParticipantUserID = "Device"
    #else // device
let LQSCurrentUserID     = "Device"
let LQSParticipantUserID = "Simulator"
#endif

let LQSInitialMessageText = "Hey \(LQSParticipantUserID)! This is your friend, \(LQSCurrentUserID)."
let LQSParticipant2UserID = "Dashboard"

typealias AuthenticationCompletionBlock = (error: NSError?) -> Void
typealias IdentityTokenCompletionBlock  = (String?, NSError?) -> Void


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
    var loginButton:UIButton = UIButton(type: UIButtonType.System)

    // Boolean to determine whether to present tutorial automatically (on app launch)
    var showTutorial = true
    
    // Boolean to determine whether to hide containerScrollView
    var scrollViewHidden = true
    
    override func viewDidLoad() {
        if((PFUser.currentUser()) != nil){
            self.loginLayer()
        }
        else{
            // Hide UIStatusBar
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
            self.navigationController?.setNavigationBarHidden(true, animated: false)

            super.viewDidLoad()
            
            containerScrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
            self.containerScrollView.hidden = scrollViewHidden
            self.view.backgroundColor = UIColor.whiteColor()
            print("showTutorial IS \(showTutorial)")
            if (showTutorial){

                // Initialize tutorial pages texts, and pictures.
                let layer0: ICETutorialPage = ICETutorialPage(title: "", subTitle: "", pictureName: "Logo_tutorial", duration: 2.5)
                let layer1: ICETutorialPage = ICETutorialPage(title: "Dashboard", subTitle: "Get an overview of your challenges\nand your current challenges.", pictureName: "Dashboard_tutorial", duration: 4.0)
                let layer2: ICETutorialPage = ICETutorialPage(title: "Challenges", subTitle: "Take on challenges to go forward\nin your coming out journey.", pictureName: "Challenges_tutorial", duration: 4.0)
                let layer3: ICETutorialPage = ICETutorialPage(title: "Activity", subTitle: "See challenges completed by people\nyou follow and cheer them up.", pictureName: "Activity_tutorial", duration: 4.0)
                let layer4: ICETutorialPage = ICETutorialPage(title: "People", subTitle: "Find and connect with others with\n similar backgrounds as you.", pictureName: "People_tutorial", duration: 4.0)
                let layer5: ICETutorialPage = ICETutorialPage(title: "Help", subTitle: "Reach out for help if you would like\nsomeone to talk to or chat with.", pictureName: "Help_tutorial", duration: 4.0)

                // Set the common style for Titles and Description (can be overrided on each page).
                let titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
                titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 26.0)
                titleStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
                titleStyle.linesNumber = 1
                titleStyle.offset = 175
                
                // Set the common style for SubTitles and Description (can be overrided on each page).
                let subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
                subStyle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
                subStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
                subStyle.linesNumber = 2
                subStyle.offset = 135
                
                
                let listPages: [ICETutorialPage] = [layer0, layer1, layer2, layer3, layer4, layer5]
                
                controller = ICETutorialController(pages: listPages, delegate: self)
                ICETutorialStyle.sharedInstance().titleStyle = titleStyle
                ICETutorialStyle.sharedInstance().subTitleStyle = subStyle

                controller.autoScrollEnabled = true
                controller.startScrolling()
                // present ICETutorial view
                self.presentViewController(controller, animated: false, completion: nil)
            }
            
            
            // Initialize logoImage UIImageView
            logoImageView = UIImageView(frame: CGRectZero)
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            logoImageView.image = UIImage(named: "out_logo_png")
            logoImageView.userInteractionEnabled = true
            let viewTutorial = UITapGestureRecognizer(target: self, action: "viewTutorial")
            logoImageView.addGestureRecognizer(viewTutorial)
            containerScrollView.addSubview(logoImageView)

            // Initialize alias UITextField
            aliasTextField = UITextField(frame: CGRectZero)
            aliasTextField.translatesAutoresizingMaskIntoConstraints = false
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
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.keyboardType = UIKeyboardType.Default
            passwordTextField.placeholder = "passcode"
            passwordTextField.textAlignment = NSTextAlignment.Left
            passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
            passwordTextField.borderStyle = UITextBorderStyle.None
            passwordTextField.secureTextEntry = true
            containerScrollView.addSubview(passwordTextField)
            
            // Initialize login UIButton properties
            loginButton.translatesAutoresizingMaskIntoConstraints = false
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
            
            let horizontalCenterConstraint = NSLayoutConstraint(item: self.logoImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.containerScrollView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
            let horizontalLogoConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=109.5-[logoImageView(101)]->=109.5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
            let horizontalFormConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[aliasTextField(>=280)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
            
            let verticalTopConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=70-[logoImageView(101)]-20-[aliasTextField(44)]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metricsDictionary, views: viewsDictionary)
            let verticalSecondConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aliasTextField(44)]-0-[passwordTextField(44)]-20-[loginButton(44)]->=20-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: metricsDictionary, views: viewsDictionary)

            self.containerScrollView.addConstraint(horizontalCenterConstraint)
            self.containerScrollView.addConstraints(horizontalFormConstraints)
            self.containerScrollView.addConstraints(horizontalLogoConstraints)
            self.containerScrollView.addConstraints(verticalTopConstraints)
            self.containerScrollView.addConstraints(verticalSecondConstraints)
            
            self.view.addSubview(containerScrollView)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "LoggedIn"){
//            // Request an authentication nonce from Layer
//            layerClient.requestAuthenticationNonceWithCompletion({ (nonce, error) -> Void in
//                if (nonce != nil){
//                    var user = PFUser.currentUser()!
//                    var userID = user.objectId!
//                    
//                    PFCloud.callFunctionInBackground("generateToken", withParameters: ["nonce":nonce, "userID":userID]){(token, error) -> Void in
//                        if (error != nil){
//                            // Send the Identity Token to Layer to authenticate the user
//                            self.layerClient.authenticateWithIdentityToken(token as! String, completion: {(authenticatedUserID, error) -> Void in
//                                if (error != nil){
//                                    print("Parse User authenticated with Layer Identity Token")
//                                }
//                                else{
//                                    print("Parse User failed to authenticate with token with error: \(error)")
//                                }
//                            })
//                        }
//                        else{
//                            print("Parse Cloud function failed to be called to generate token with error: \(error)")
//                        }
//                    }
//                }
//            })
//
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Empties form fields when login view disappears
    override func viewDidDisappear(animated: Bool) {
//        if (aliasTextField.text != nil || passwordTextField.text != nil){
//            aliasTextField.text = ""
//            passwordTextField.text = ""
//        }
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
        print("signup!")
    }

    // Login button tapped to authenticate provided user credentials
    func loginButtonTapped(sender: UIButton) {
        self.loginButton.enabled = false
        self.aliasTextField.enabled = false
        self.passwordTextField.enabled = false
        PFUser.logInWithUsernameInBackground(self.aliasTextField.text!, password:self.passwordTextField.text!) {
            (user, error) -> Void in
            if (error == nil) {
                // Do stuff after successful login.
                PFInstallation.currentInstallation()["currentUser"] = PFUser.currentUser()
                PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil)
                self.loginLayer()
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
        
        let layer0: ICETutorialPage = ICETutorialPage(title: "", subTitle: "", pictureName: "Logo_tutorial", duration: 2.5)
        let layer1: ICETutorialPage = ICETutorialPage(title: "Dashboard", subTitle: "Get an overview of your challenges\nand your current challenges.", pictureName: "Dashboard_tutorial", duration: 4.0)
        let layer2: ICETutorialPage = ICETutorialPage(title: "Challenges", subTitle: "Take on challenges to go forward\nin your coming out journey.", pictureName: "Challenges_tutorial", duration: 4.0)
        let layer3: ICETutorialPage = ICETutorialPage(title: "Activity", subTitle: "See challenges completed by people\nyou follow and cheer them up.", pictureName: "Activity_tutorial", duration: 4.0)
        let layer4: ICETutorialPage = ICETutorialPage(title: "People", subTitle: "Find and connect with others with\n similar backgrounds as you.", pictureName: "People_tutorial", duration: 4.0)
        let layer5: ICETutorialPage = ICETutorialPage(title: "Help", subTitle: "Reach out for help if you would like\nsomeone to talk to or chat with.", pictureName: "Help_tutorial", duration: 4.0)
        
        // Set the common style for SubTitles and Description (can be overrided on each page).
        let titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        titleStyle.font = UIFont(name: "HelveticaNeue-Light", size: 26.0)
        titleStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        titleStyle.linesNumber = 1
        titleStyle.offset = 210

        // Set the common style for Titles and Description (can be overrided on each page).
        let subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        subStyle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        subStyle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        subStyle.linesNumber = 2
        subStyle.offset = 160
        
        let listPages: [ICETutorialPage] = [layer0, layer1, layer2, layer3, layer4, layer5]
        
        controller = ICETutorialController(pages: listPages, delegate: self)
        ICETutorialStyle.sharedInstance().titleStyle = titleStyle
        ICETutorialStyle.sharedInstance().subTitleStyle = subStyle

        controller.startScrolling()
        controller.autoScrollEnabled = true
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func tutorialControllerDidReachLastPage(tutorialController: ICETutorialController!) {
        tutorialController.startScrolling()
    }
    
    func loginLayer(){
        
        // Connect to Layer
        // See "Quick Start - Connect" for more details
//        // https://developer.layer.com/docs/quick-start/ios#connect
//        if ((UIApplication.sharedApplication().delegate as! AppDelegate).layerClient == nil){
//            let appID = NSUUID(UUIDString: LQSLayerAppIDString)
//            (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient = LYRClient(appID: appID)
//        }
//        if !(UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.isConnected{
//            (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.connectWithCompletion { (success, error) -> Void in
//                if (!success){
//                    print("Failed to connect to Layer: \(error)")
//                }
//                else{
//                    let user:PFUser = PFUser.currentUser()!
//                    let userID:NSString = user.objectId!
//                    self.authenticateLayerWithUserID(userID as String, authenticationCompletion: { (error) -> Void in
//                        if (error == nil){
//                            self.performSegueWithIdentifier("LoggedIn", sender: nil)
//                        }
//                        else{
//                            print("Failed Authenticating Layer Client with error: \(error)")
//                        }
//                    })
//                }
//            }
//        }
//        else{
//            let user:PFUser = PFUser.currentUser()!
//            let userID:NSString = user.objectId!
//            self.authenticateLayerWithUserID(userID as String, authenticationCompletion: { (error) -> Void in
//                if (error == nil){
//                    self.performSegueWithIdentifier("LoggedIn", sender: nil)
//                }
//                else{
//                    print("Failed Authenticating Layer Client with error: \(error)")
//                }
//            })
//        }
        self.performSegueWithIdentifier("LoggedIn", sender: nil)
    }
    
//    func authenticateLayerWithUserID(userID: String, authenticationCompletion: AuthenticationCompletionBlock) {
//        // Check to see if the layerClient is already authenticated.
//        let authenticatedUserID = (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.authenticatedUserID
//        print(authenticatedUserID)
//        if authenticatedUserID != nil{
//            // If the layerClient is authenticated with the requested userID, complete the authentication process.
//            if authenticatedUserID == userID {
//                print("Layer Authenticated as User \(authenticatedUserID)")
//                authenticationCompletion(error: nil)
//            } else {
//                // If the authenticated userID is different, then deauthenticate the current client and re-authenticate with the new userID.
//                (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.deauthenticateWithCompletion { success, error in
//                    if success {
//                        self.authenticationTokenWithUserId(userID, authenticationCompletion: authenticationCompletion)
//                    } else if let error = error {
//                        authenticationCompletion(error: error)
//                    } else {
//                        assertionFailure("Must have an error when success = false")
//                    }
//                }
//            }
//        } else {
//            // If the layerClient isn't already authenticated, then authenticate.
//            authenticationTokenWithUserId(userID, authenticationCompletion: authenticationCompletion)
//        }
//    }
    
//    func authenticationTokenWithUserId(userID: String, authenticationCompletion: AuthenticationCompletionBlock) {
//        // 1. Request an authentication Nonce from Layer
//        (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.requestAuthenticationNonceWithCompletion { nonce, error in
//            if nonce == nil {
//                authenticationCompletion(error: error)
//                return
//            }
//            
//            // 2. Acquire identity Token from Layer Identity Service
//            self.requestIdentityTokenForUserID(userID, appID: (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.appID.UUIDString, nonce: nonce) { identityToken, error in
//                if identityToken == nil {
//                    authenticationCompletion(error: error)
//                    return
//                }
//                
//                // 3. Submit identity token to Layer for validation
//                (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.authenticateWithIdentityToken(identityToken) { authenticatedUserID, error in
//                    if authenticatedUserID != nil {
//                        print("Layer Authenticated as User: \(authenticatedUserID)")
//                        authenticationCompletion(error: nil)
//                    } else {
//                        authenticationCompletion(error: error)
//                    }
//                }
//            }
//        }
//    }
    
    func requestIdentityTokenForUserID(userID: String, appID: String, nonce: String, tokenCompletion: IdentityTokenCompletionBlock) {
        let identityTokenURL = NSURL(string: "https://layer-identity-provider.herokuapp.com/identity_tokens")!
        let request = NSMutableURLRequest(URL: identityTokenURL)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let parameters = ["app_id": appID, "user_id": userID, "nonce": nonce]
        let requestBody: NSData?
        do {
            requestBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        } catch _ {
            requestBody = nil
        }
        request.HTTPBody = requestBody
        
        let sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                tokenCompletion(nil, error)
                return
            }
            
            // Deserialize the response
//            let responseObject = NSJSONSerialization.JSONObjectWithData(data!, options: [])
//            if responseObject["error"] == nil {
//                let identityToken = responseObject["identity_token"] as! String
//                tokenCompletion(identityToken, nil)
//            } else {
//                let domain = "layer-identity-provider.herokuapp.com"
//                let code = responseObject["status"]!!.integerValue
//                let userInfo = [
//                    NSLocalizedDescriptionKey: "Layer Identity Provider Returned an Error.",
//                    NSLocalizedRecoverySuggestionErrorKey: "There may be a problem with your APPID."
//                ]
//                
//                let error = NSError(domain: domain, code: code, userInfo: userInfo)
//                tokenCompletion(nil, error)
//            }
        }
        dataTask.resume()
    }


}
