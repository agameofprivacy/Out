//
//  HelpChatViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class HelpChatViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var topPlaceholderImageView:UIImageView!
    var bottomPlaceholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Help"
        var endButton = UIBarButtonItem(title: "End", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonTapped")

        endButton.setTitleTextAttributes(NSDictionary(objectsAndKeys: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!, NSFontAttributeName), forState: UIControlState.Normal)
        endButton.tintColor = UIColor.redColor()
        self.navigationItem.leftBarButtonItem = endButton

        self.containerScrollView = UIScrollView(frame: CGRectMake(0, 0, 375, 667))
        self.view.addSubview(containerScrollView)
        self.containerScrollView.contentSize = CGSize(width: 375, height: 954)
        self.topPlaceholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 905))
        self.topPlaceholderImageView.image = UIImage(named: "help_chat_top_placeholder")
        self.containerScrollView.addSubview(self.topPlaceholderImageView)
        self.bottomPlaceholderImageView = UIImageView(frame: CGRectMake(0, 613, 375, 54))
        self.bottomPlaceholderImageView.image = UIImage(named: "help_chat_bottom_placeholder")
        self.view.addSubview(self.bottomPlaceholderImageView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
