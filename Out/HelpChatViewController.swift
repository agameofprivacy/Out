//
//  HelpChatViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for help chat view
class HelpChatViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var topPlaceholderImageView:UIImageView!
    var bottomPlaceholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // UINavigationBar init and layout
        self.navigationItem.title = "Help"

        let endButton = UIBarButtonItem(title: "End", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonTapped")
        endButton.setTitleTextAttributes(NSDictionary(object: NSFontAttributeName, forKey: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!) as? [String : AnyObject], forState: UIControlState.Normal)
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
    }
    
    func endButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
