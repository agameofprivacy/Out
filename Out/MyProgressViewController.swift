//
//  MyProgressViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MyProgressViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var topPlaceholderImageView:UIImageView!
    var bottomPlaceholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Records"
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        
        var sortButton = UIBarButtonItem(title: "Sort", style: UIBarButtonItemStyle.Plain, target: self, action: "sortButtonTapped")
        sortButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = sortButton

        // Do any additional setup after loading the view.
        

        self.containerScrollView = UIScrollView(frame: CGRectMake(0, 236, 375, 437))
        self.view.addSubview(containerScrollView)
        self.bottomPlaceholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 476))
        self.bottomPlaceholderImageView.image = UIImage(named: "progress_bottom_placeholder")
        self.containerScrollView.contentSize = CGSize(width: 375, height: 476)
        self.containerScrollView.addSubview(self.bottomPlaceholderImageView)
        self.topPlaceholderImageView = UIImageView(frame: CGRectMake(0, 65, 375, 235))
        self.topPlaceholderImageView.image = UIImage(named: "progress_top_placeholder")
        self.view.addSubview(self.topPlaceholderImageView)
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
    
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func sortButtonTapped(){
        "sorted"
    }

}
