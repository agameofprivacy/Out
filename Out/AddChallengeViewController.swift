//
//  AddChallengeViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/8/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

extension Array {
    mutating func removeObjectAtIndexes(indexes: [Int]) {
        var indexSet = NSMutableIndexSet()
        
        for index in indexes {
            indexSet.addIndex(index)
        }
        
        indexSet.enumerateIndexesWithOptions(.Reverse) {
            self.removeAtIndex($0.0)
            return
        }
    }
    
    mutating func removeObjectAtIndexes(indexes: Int...) {
        removeObjectAtIndexes(indexes)
    }
}


class AddChallengeViewController: UICollectionViewController {

    var challengeModels:[ChallengeModel] = []
    var challengeModelsObjects:[AnyObject] = []
    var filters:[String] = []
    var currentChallengesStrings:[String] = []

    // TODO: Set filters default so gallery shows all challenges if no filter applied.

    @IBOutlet var challengeGalleryCollectionView: UICollectionView!
    @IBOutlet weak var challengeGalleryCardTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadAvailableChallenges()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeModelsObjects.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickFilters"{
            let FilterVC:ChallengeFilterTableViewController = segue.destinationViewController.childViewControllers[0] as ChallengeFilterTableViewController
            FilterVC.filterStrings = self.filters
        }
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var selectedChallengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as PFObject
        var newChallengeModel = PFObject(className: "UserChallengeData")
            newChallengeModel["alias"] = PFUser.currentUser().username
            newChallengeModel["title"] = selectedChallengeObject["title"]
            newChallengeModel["version"] = selectedChallengeObject["version"]
            newChallengeModel["isCurrent"] = true
            newChallengeModel["username"] = PFUser.currentUser()

            newChallengeModel.saveInBackground()
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func filterBarButtonItemTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("PickFilters", sender: self)
    }
    
    func loadAvailableChallenges(){
        self.challengeModelsObjects.removeAll(keepCapacity: true)
        self.currentChallengesStrings.removeAll(keepCapacity: true)
        var query = PFQuery(className:"Challenge")
        if filters.count > 0{
            query.whereKey("tags", containedIn: filters)
        }
        var currentChallengesQuery = PFQuery(className: "UserChallengeData")
        currentChallengesQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                for object in objects{
                    self.currentChallengesStrings += [(object["title"] as String)]
                }
                query.findObjectsInBackgroundWithBlock {
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        // The find succeeded.
                        self.challengeModelsObjects = objects
                        var indexForToRemove:[Int] = []
                        if self.challengeModelsObjects.count > 0{
                            for (index,challenge) in enumerate(self.challengeModelsObjects){
                                if contains(self.currentChallengesStrings, challenge["title"] as String){
                                    indexForToRemove += [index]
                                }
                            }
                            self.challengeModelsObjects.removeObjectAtIndexes(indexForToRemove)
                        }
                        self.challengeGalleryCollectionView.reloadData()
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error, error.userInfo!)
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
    }
    
    
}
