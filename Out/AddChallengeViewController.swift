//
//  AddChallengeViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class AddChallengeViewController: UICollectionViewController {

    var challengeModels:[ChallengeModel] = []
    var challengeModelsObjects:[AnyObject] = []
    var filters:[String] = []
    
    @IBOutlet var challengeGalleryCollectionView: UICollectionView!
    @IBOutlet weak var challengeGalleryCardTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var query = PFQuery(className:"Challenge")
        query.whereKey("tags", containedIn: filters)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.challengeModelsObjects = objects
                self.challengeGalleryCollectionView.reloadData()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeModelsObjects.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var challengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as PFObject
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeGalleryCard", forIndexPath: indexPath) as ChallengeGalleryCollectionViewCell

        cell.challengeGalleryCardTitleLabel.text = challengeObject["title"] as String?
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor

        return cell
    }
    
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
