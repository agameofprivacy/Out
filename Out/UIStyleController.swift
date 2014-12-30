//
//  UIStyleController.swift
//  Out
//
//  Created by Eddie Chen on 11/16/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class UIStyleController: NSObject {
    class func applyStyle(){
        var navigationBarAppearance:UINavigationBar = UINavigationBar.appearance()
        var navFont = UIFont(name: "HelveticaNeue-Light", size: 19.5)
        navigationBarAppearance.titleTextAttributes = NSDictionary(objectsAndKeys: navFont!, NSFontAttributeName)
        navigationBarAppearance.setTitleVerticalPositionAdjustment(0, forBarMetrics: UIBarMetrics.Default)
        var window:UIWindow = UIWindow.appearance()
        window.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }
}
