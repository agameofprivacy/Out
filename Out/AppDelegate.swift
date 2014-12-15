//
//  AppDelegate.swift
//  Out
//
//  Created by Eddie Chen on 10/7/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ICETutorialControllerDelegate {
    
    var visWindow: COSTouchVisualizerWindow?
    var window: COSTouchVisualizerWindow? {
        if visWindow == nil { visWindow = COSTouchVisualizerWindow(frame: UIScreen.mainScreen().bounds) }
        visWindow?.backgroundColor = UIColor.clearColor()
        visWindow?.fillColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        visWindow?.strokeColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        visWindow?.touchAlpha = 0.75
        
        visWindow?.rippleFillColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 0.3)
        visWindow?.rippleStrokeColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 0.3)
        visWindow?.rippleAlpha = 0.05
        return visWindow
    }
    


    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIStyleController.applyStyle()
        Parse.setApplicationId("BIV65YI6yH4JPzMDiMro4aHLX0THLJEq40X3XTfR", clientKey: "DjwDcyZzLPOkWl5GSLKeZwLzA8YWdKYE9nM2ZfmC")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier("7dec739280c7d95ffcb010852c78a6d4")
        BITHockeyManager.sharedHockeyManager().startManager()
        BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation()
        
//        // Override point for customization after application launch.
//        self.window!.backgroundColor = UIColor.whiteColor()
//        
//        // Init the pages texts, and pictures.
//        var layer1: ICETutorialPage = ICETutorialPage(title: "Picture 1", subTitle: "Champs-Elysées by night", pictureName: "tutorial_background_00.jpg", duration: 3.0)
//        var layer2: ICETutorialPage = ICETutorialPage(title: "Picture 2", subTitle: "The Eiffel Tower with\n cloudy weather", pictureName: "tutorial_background_01.jpg", duration: 3.0)
//        var layer3: ICETutorialPage = ICETutorialPage(title: "Picture 3", subTitle: "An other famous street of Paris", pictureName: "tutorial_background_02.jpg", duration: 3.0)
//        var layer4: ICETutorialPage = ICETutorialPage(title: "Picture 4", subTitle: "The Eiffel Tower with a better weather", pictureName: "tutorial_background_03.jpg", duration: 3.0)
//        var layer5: ICETutorialPage = ICETutorialPage(title: "Picture 5", subTitle: "The Louvre's Museum Pyramide", pictureName: "tutorial_background_04.jpg", duration: 3.0)
//        
//        // Set the common style for SubTitles and Description (can be overrided on each page).
//        var titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
//        titleStyle.font = UIFont(name: "Helvetica-Bold", size: 17.0)
//        titleStyle.textColor = UIColor.whiteColor()
//        titleStyle.linesNumber = 1
//        titleStyle.offset = 180
//        
//        var subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
//        subStyle.font = UIFont(name: "Helvetica", size: 15.0)
//        subStyle.textColor = UIColor.whiteColor()
//        subStyle.linesNumber = 1
//        subStyle.offset = 150
//        
//        
//        var listPages: [ICETutorialPage] = [layer1, layer2, layer3, layer4, layer5]
//        
//        var controller: ICETutorialController = ICETutorialController(pages: listPages, delegate: self)
//        ICETutorialStyle.sharedInstance().titleStyle = titleStyle
//        ICETutorialStyle.sharedInstance().subTitleStyle = subStyle
//        controller.startScrolling()
//        
//        self.window?.rootViewController = controller
        return true

        
    }
    
//    func tutorialController(tutorialController: ICETutorialController!, didClickOnLeftButton sender: UIButton!) {
//        println("left button clicked")
//    }
//    
//    func tutorialController(tutorialController: ICETutorialController!, didClickOnRightButton sender: UIButton!) {
//        println("right button clicked")
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

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

