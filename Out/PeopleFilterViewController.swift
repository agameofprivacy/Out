//
//  PeopleFilterViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleFilterViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var placeholderImageView:UIImageView!
    
    override func viewDidLoad() {
        
        var closeButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped:")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        var applyButton = UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: "applyButtonTapped:")
        applyButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = applyButton

        self.view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.navigationItem.title = "Filter"
        super.viewDidLoad()
        self.containerScrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(containerScrollView)
        self.placeholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 1225))
        self.placeholderImageView.image = UIImage(named: "people_filter_placeholder")
        self.containerScrollView.contentSize = CGSize(width: 375, height: 1225)
        self.containerScrollView.addSubview(self.placeholderImageView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func closeButtonTapped(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyButtonTapped(sender: UIBarButtonItem){
        println("apply!")
    }

}
