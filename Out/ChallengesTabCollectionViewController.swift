//
//  ChallengesTabCollectionViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/7/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"


class ChallengesTabCollectionViewController: UICollectionViewController {

    var currentChallengesObjects:[AnyObject] = []
    
    @IBOutlet var currentChallengesCardsCollectionView: UICollectionView!
    @IBOutlet weak var challengesCardNumPageControl: UIPageControl!

    var currentChallenges:[Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrentChallenges()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadCurrentChallenges()
    }
    

//    override func viewDidAppear(animated: Bool) {
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return currentChallengesObjects.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCard", forIndexPath: indexPath) as ChallengeCardCollectionViewCell
        challengesCardNumPageControl.numberOfPages = self.currentChallengesObjects.count
        challengesCardNumPageControl.currentPage = 0
        
        // Configure the cell
        cell.cardLabel.text = self.currentChallengesObjects[indexPath.item]["title"] as String?
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor

        challengesCardNumPageControl.currentPage = indexPath.item

        return cell
    }
    
    func loadCurrentChallenges(){
        var queryIsCurrentIsCurrentUser = PFQuery(className:"UserChallengeData")
        queryIsCurrentIsCurrentUser.whereKey("isCurrent", equalTo:true)
        queryIsCurrentIsCurrentUser.whereKey("username", equalTo: PFUser.currentUser())
        queryIsCurrentIsCurrentUser.orderByDescending("createdAt")
        queryIsCurrentIsCurrentUser.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.currentChallengesObjects = objects
                self.currentChallengesCardsCollectionView.reloadData()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

    }

    @IBAction func addChallengeBarButtonItemTapped(sender: UIBarButtonItem) {
        println("Add Challenge")
    }
    

}