//
//  AddChallengeViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class AddChallengeViewController: UIViewController {

    @IBOutlet weak var challengeGalleryCollectionView: UICollectionView!
    
    var challengeGalleryDataSource:UICollectionViewDataSource!
    var challengeGalleryDelegate:UICollectionViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        challengeGalleryCollectionView.dataSource = challengeGalleryDataSource
        challengeGalleryCollectionView.delegate = challengeGalleryDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
