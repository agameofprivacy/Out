//
//  MentorViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MentorViewController: UIViewController {

    var containerScrollView:UIScrollView!
    var topPlaceholderImageView:UIImageView!
    var middlePlaceholderImageView:UIImageView!
    var bottomPlaceholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mentor"
        let reportButton = UIBarButtonItem(title: "Report", style: UIBarButtonItemStyle.Plain, target: self, action: "reportButtonTapped")
        reportButton.setTitleTextAttributes(NSDictionary(objectsAndKeys: NSFontAttributeName, UIFont(name: "HelveticaNeue-Medium", size: 18.0)!) as? [String : AnyObject], forState: UIControlState.Normal)
        reportButton.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = reportButton

        self.containerScrollView = UIScrollView(frame: CGRectMake(0, 175, 375, 392))
        self.view.addSubview(containerScrollView)
        self.containerScrollView.contentSize = CGSize(width: 375, height: 365)
        self.middlePlaceholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 419))
        self.middlePlaceholderImageView.image = UIImage(named: "mentor_middle_placeholder")
        self.containerScrollView.addSubview(self.middlePlaceholderImageView)
        self.topPlaceholderImageView = UIImageView(frame: CGRectMake(0, 65, 375, 175))
        self.topPlaceholderImageView.image = UIImage(named: "mentor_top_placeholder")
        self.view.addSubview(self.topPlaceholderImageView)
        self.bottomPlaceholderImageView = UIImageView(frame: CGRectMake(0, 563, 375, 54))
        self.bottomPlaceholderImageView.image = UIImage(named: "help_chat_bottom_placeholder")
        self.view.addSubview(self.bottomPlaceholderImageView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Present report mentor view if Report button tapped
    func reportButtonTapped(){
        print("report button tapped")
    }
}
