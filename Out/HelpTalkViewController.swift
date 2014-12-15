//
//  HelpTalkViewController.swift
//  Out
//
//  Created by Eddie Chen on 12/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class HelpTalkViewController: UIViewController {

    var placeholderImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.placeholderImageView = UIImageView(frame: CGRectMake(0, 0, 375, 667))
        self.placeholderImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.placeholderImageView.image = UIImage(named: "help_talk_placeholder")
        self.placeholderImageView.userInteractionEnabled = true
        var endTalkRecognizer = UITapGestureRecognizer(target: self, action: "endTalkTapped")
        self.placeholderImageView.addGestureRecognizer(endTalkRecognizer)
        self.view.addSubview(self.placeholderImageView)
        
//        self.navigationItem.title = "Help"
//        var endButton = UIBarButtonItem(title: "End", style: UIBarButtonItemStyle.Plain, target: self, action: "endButtonTapped")
//        endButton.setTitleTextAttributes(NSDictionary(objectsAndKeys: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!, NSFontAttributeName), forState: UIControlState.Normal)
//        endButton.tintColor = UIColor.redColor()
//        self.navigationItem.leftBarButtonItem = endButton
        
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
    
    func endTalkTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
