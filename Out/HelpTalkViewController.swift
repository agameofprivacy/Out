//
//  HelpTalkViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Controller for help talk view
class HelpTalkViewController: UIViewController {

    var placeholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.placeholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 667))
        self.placeholderImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.placeholderImageView.image = UIImage(named: "help_talk_placeholder")
        self.placeholderImageView.userInteractionEnabled = true
        let endTalkRecognizer = UITapGestureRecognizer(target: self, action: "endTalkTapped")
        self.placeholderImageView.addGestureRecognizer(endTalkRecognizer)
        self.view.addSubview(self.placeholderImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func endTalkTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
