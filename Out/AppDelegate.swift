//
//  AppDelegate.swift
//  Out
//
//  Created by Eddie Chen on 10/7/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import LayerKit
import Parse
import ICETutorial

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LYRClientDelegate, UIAlertViewDelegate, ICETutorialControllerDelegate {
    
//    var visWindow: COSTouchVisualizerWindow?
//    var window: COSTouchVisualizerWindow? {
//        if visWindow == nil { visWindow = COSTouchVisualizerWindow(frame: UIScreen.mainScreen().bounds) }
//        visWindow?.backgroundColor = UIColor.clearColor()
//        visWindow?.fillColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
//        visWindow?.strokeColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
//        visWindow?.touchAlpha = 0.75
//        
//        visWindow?.rippleFillColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 0.3)
//        visWindow?.rippleStrokeColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 0.3)
//        visWindow?.rippleAlpha = 0.05
//        return visWindow
//    }
    
    // Added for normal operation without COSTouchVisualizer
    var window: UIWindow?
    var layerClient: LYRClient!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIStyleController.applyStyle()
        Parse.enableLocalDatastore()
        Parse.setApplicationId("BIV65YI6yH4JPzMDiMro4aHLX0THLJEq40X3XTfR", clientKey: "DjwDcyZzLPOkWl5GSLKeZwLzA8YWdKYE9nM2ZfmC")

        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier("7dec739280c7d95ffcb010852c78a6d4")
        BITHockeyManager.sharedHockeyManager().startManager()
        BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation()
        self.window?.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        
        
        let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
//        if isValidAppID() {
//            
//            // Show a usage the first time the app is launched
//            showFirstTimeMessage()
//            
//            // Initializes a LYRClient object
//            let appID = NSUUID(UUIDString: LQSLayerAppIDString)
//            layerClient = LYRClient(appID: appID)
////            layerClient.delegate = self
//            
//            var controller:LoginViewController = LoginViewController()
//            controller.layerClient = self.layerClient
//            
//            self.window?.rootViewController = UINavigationController(rootViewController: controller)
//            // Connect to Layer
//            // See "Quick Start - Connect" for more details
//            // https://developer.layer.com/docs/quick-start/ios#connect
//            
////          
//            
////            // Request an authentication nonce from Layer
////            layerClient.requestAuthenticationNonceWithCompletion({ (nonce, error) -> Void in
////                print("Authentifcation nonce \(nonce)")
////                if (nonce != nil){
////                    var user = PFUser.currentUser()!
////                    var userID = user.objectId!
////
////                    PFCloud.callFunctionInBackground("generateToken", withParameters: ["nonce":nonce, "userID":userID]){(token, error) -> Void in
////                        if (error != nil){
////                            // Send the Identity Token to Layer to authenticate the user
////                            self.layerClient.authenticateWithIdentityToken(token as! String, completion: {(authenticatedUserID, error) -> Void in
////                                if (error != nil){
////                                    print("Parse User authenticated with Layer Identity Token")
////                                }
////                                else{
////                                    print("Parse User failed to authenticate with token with error: \(error)")
////                                }
////                            })
////                        }
////                        else{
////                            print("Parse Cloud function failed to be called to generate token with error: \(error)")
////                        }
////                    }
////                }
////            })
//
//            
////            LayerAuthenticationHelper(layerClient: layerClient).authenticateWithLayer { error in
////                if let error = error {
////                    print("Failed to connect to Layer: \(error.localizedDescription)")
////                } else {
//////                    let navigationController = self.window?.rootViewController as! UINavigationController
//////                    (navigationController.topViewController as ChatViewController).layerClient = self.layerClient
////                    print("layer authentication success")
////                    // Register for push
//////                    self.registerApplicationForPushNotifications(application)
////                }
////            }
//        }

        
        return true
    }
    
    // MARK: - Push Notification Methods
    
//    func registerApplicationForPushNotifications(application: UIApplication) {
//        // Set up push notifications
//        // For more information about Push, check out:
//        // https://developer.layer.com/docs/guides/ios#push-notification
//        
//        // Checking if app is running iOS 8
//        if application.respondsToSelector("registerForRemoteNotifications") {
//            // Register device for iOS8
//            let notificationSettings = UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil)
//            application.registerUserNotificationSettings(notificationSettings)
//            application.registerForRemoteNotifications()
//        } else {
//            // Register device for iOS7
//            application.registerForRemoteNotificationTypes(.Alert | .Badge | .Sound)
//        }
//    }

    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["global"]
        currentInstallation.saveInBackgroundWithBlock(nil)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }
    
    func applicationWillTerminate(application: UIApplication) {
//        PFInstallation.currentInstallation().removeObjectForKey("currentUser")
//        PFInstallation.currentInstallation().saveInBackground()
//        PFUser.logOut()
    }
//    func tutorialController(tutorialController: ICETutorialController!, didClickOnLeftButton sender: UIButton!) {
//        print("left button clicked")
//    }
//    
//    func tutorialController(tutorialController: ICETutorialController!, didClickOnRightButton sender: UIButton!) {
//        print("right button clicked")
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // MARK: - LYRClientDelegate
    
    func layerClient(client: LYRClient!, didReceiveAuthenticationChallengeWithNonce nonce: String!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didAuthenticateAsUserID userID: String!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFailOperationWithError error: NSError!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFailSynchronizationWithError error: NSError!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFinishContentTransfer contentTransferType: LYRContentTransferType, ofObject object: AnyObject!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFinishSynchronizationWithChanges changes: [AnyObject]!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didLoseConnectionWithError error: NSError!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, objectsDidChange changes: [AnyObject]!) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, willAttemptToConnect attemptNumber: UInt, afterDelay delayInterval: NSTimeInterval, maximumNumberOfAttempts attemptLimit: UInt) {
        print(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, willBeginContentTransfer contentTransferType: LYRContentTransferType, ofObject object: AnyObject!, withProgress progress: LYRProgress!) {
        print(__FUNCTION__)
    }
    
    func layerClientDidConnect(client: LYRClient!) {
        print(__FUNCTION__)
    }
    
    func layerClientDidDeauthenticate(client: LYRClient!) {
        print(__FUNCTION__)
    }
    
    func layerClientDidDisconnect(client: LYRClient!) {
        print(__FUNCTION__)
    }

    
    
//    func isValidAppID() -> Bool {
//        if LQSLayerAppIDString == "LAYER_APP_ID" {
//            let alert = UIAlertView(
//                title: "\u{1F625}", //"😥"
//                message: "To correctly use this project you need to replace LAYER_APP_ID in AppDelegate.m (line 11) with your App ID from developer.layer.com.",
//                delegate: self,
//                cancelButtonTitle: nil)
//            
//            alert.addButtonWithTitle("OK")
//            alert.show()
//            return false
//        }
//        return true
//    }

    
    func showFirstTimeMessage() {
        let LQSApplicationHasLaunchedOnceDefaultsKey = "applicationHasLaunchedOnce"
        
        if !NSUserDefaults.standardUserDefaults().boolForKey(LQSApplicationHasLaunchedOnceDefaultsKey) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: LQSApplicationHasLaunchedOnceDefaultsKey)
            
            // This is the first launch ever
            
            UIAlertView(
                title: "Hello!",
                message: "This is a very simple example of a chat app using Layer. Launch this app on a Simulator and a Device to start a 1:1 conversation. If you shake the Device the navbar color will change on both the Simulator and Device.",
                delegate: nil,
                cancelButtonTitle: "Got It!").show()
        }
    }

    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if alertView.buttonTitleAtIndex(buttonIndex) == "OK" {
            abort()
        }
    }

    
}

