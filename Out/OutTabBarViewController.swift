//
//  OutTabBarViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import Parse
// Controller for application UITabBar

class OutTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let animalAvatarString = ((PFUser.currentUser()!)["avatar"] as! String) + "-icon"
        // Set UITabBarItem through a for loop
        for var index = 0; index <  self.tabBar.items?.count; ++index{
            
            // Instantiate UITabBarItem
            let tabItem : UITabBarItem = self.tabBar.items![index] as UITabBarItem
            
            // Switch assets for UITabBarItem in order
            switch index{
                
                // Dashboard
            case 0:
                tabItem.selectedImage = UIImage(named: "challengesSelected")
                tabItem.image = UIImage(named: "challengesUnselected")
                
                // Challenges
            case 1:
                tabItem.selectedImage = UIImage(named: "peopleSelected")
                tabItem.image = UIImage(named: "peopleUnselected")
                
                // Activity
            case 2:
                tabItem.selectedImage = UIImage(named: "activitySelected")
                tabItem.image = UIImage(named: "activityUnselected")
                
                // People
            case 3:
                tabItem.selectedImage = UIImage(named: "helpSelected")
                tabItem.image = UIImage(named: "helpUnselected")
                
                // Help
            case 4:
                tabItem.selectedImage = UIImage(named: animalAvatarString)
                tabItem.image = UIImage(named: animalAvatarString)
                
            default:
                print("no image resourced")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
