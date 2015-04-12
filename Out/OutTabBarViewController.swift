//
//  OutTabBarViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for application UITabBar

class OutTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    
        // Set UITabBarItem through a for loop
        for var index = 0; index <  self.tabBar.items?.count; ++index{
            
            // Instantiate UITabBarItem
            var tabItem : UITabBarItem = self.tabBar.items![index] as! UITabBarItem

            // Switch assets for UITabBarItem in order
            switch index{
            
            // Dashboard
            case 0:
                tabItem.selectedImage = UIImage(named: "activitySelected")
                tabItem.image = UIImage(named: "activityUnselected")

            // Challenges
            case 1:
                tabItem.selectedImage = UIImage(named: "challengesSelected")
                tabItem.image = UIImage(named: "challengesUnselected")
                
            // Activity
            case 2:
                tabItem.selectedImage = UIImage(named: "peopleSelected")
                tabItem.image = UIImage(named: "peopleUnselected")
                
            // People
            case 3:
                tabItem.selectedImage = UIImage(named: "helpSelected")
                tabItem.image = UIImage(named: "helpUnselected")
                
            // Help
            case 4:
                tabItem.selectedImage = UIImage(named: "dashboardSelected")
                tabItem.image = UIImage(named: "dashboardUnselected")

            default:
                println("no image resourced")
            }
        }
        
//        var activityTabBarItem:UITabBarItem = self.tabBar.items![0] as! UITabBarItem
//        activityTabBarItem.badgeValue = "!"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
////        println(item.)
//        if(find(tabBar.items as! [UITabBarItem], item) == 0) && tabBar.selectedItem == item{
//            println("scroll!")
//            println(self.childViewControllers[0].childViewControllers)
//            (self.childViewControllers[0].childViewControllers[0] as! ActivityTabViewController).tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
