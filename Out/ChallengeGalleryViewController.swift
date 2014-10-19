//
//  ChallengeGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/14/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit


class ChallengeGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var challengeGallery:UICollectionView!
    let layout: ChallengeGalleryCollectionViewFlowLayout = ChallengeGalleryCollectionViewFlowLayout()

    var activityIndicator: UIActivityIndicatorView!

    let horizontalSectionInset:CGFloat = 8.0
    let verticalSectionInset:CGFloat = 12.0
    
    var challengeModelsObjects:[AnyObject] = []
    var filters:[String] = []
    var currentChallengesStrings:[String] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // layout.estimatedItemSize = CGSize(width: self.view.bounds.width, height: 200)
        layout.itemSize = CGSize(width: self.view.frame.size.width - horizontalSectionInset * 2, height: 210)
        layout.sectionInset.left = horizontalSectionInset
        layout.sectionInset.right = horizontalSectionInset
        layout.sectionInset.top = verticalSectionInset
        layout.sectionInset.bottom = verticalSectionInset

        challengeGallery = UICollectionView(frame: CGRectMake(self.view.frame.origin.x, UIScreen.mainScreen().bounds.origin.y, self.view.frame.size.width, UIScreen.mainScreen().bounds.size.height), collectionViewLayout: layout)

        challengeGallery.autoresizesSubviews = true
        challengeGallery!.dataSource = self
        challengeGallery!.delegate = self
        challengeGallery!.registerClass(ChallengeGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeGalleryCard")
        challengeGallery!.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        
        self.view.addSubview(challengeGallery!)

        activityIndicator = UIActivityIndicatorView(frame: self.challengeGallery.frame)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.view.addSubview(activityIndicator)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadAvailableChallenges()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickFilters"{
            let FilterVC:ChallengeFilterTableViewController = segue.destinationViewController.childViewControllers[0] as ChallengeFilterTableViewController
            FilterVC.filterStrings = self.filters
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeModelsObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var challengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as PFObject
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeGalleryCard", forIndexPath: indexPath) as ChallengeGalleryCollectionViewCell
        cell.titleLabel.text = challengeObject["title"] as String?
        var reasonType:String = challengeObject["reason"]![0] as String
        var reasonText:String = challengeObject["reason"]![1] as String
        cell.reasonLabel.text = "\(reasonType): \(reasonText)"
        cell.introLabel.text = challengeObject["blurb"] as String?
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor
        return cell
    }

    
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func filterBarButtonItemTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("PickFilters", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var selectedChallengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as PFObject
        var newChallengeModel = PFObject(className: "UserChallengeData")
        newChallengeModel["alias"] = PFUser.currentUser().username
        newChallengeModel["title"] = selectedChallengeObject["title"]
        newChallengeModel["version"] = selectedChallengeObject["version"]
        newChallengeModel["isCurrent"] = true
        newChallengeModel["username"] = PFUser.currentUser()
        newChallengeModel["challenge"] = selectedChallengeObject
        newChallengeModel["currentStepCount"] = 0
        
        newChallengeModel.saveInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func loadAvailableChallenges(){
        self.challengeGallery.hidden = true
        self.activityIndicator.startAnimating()
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
                        self.challengeGallery!.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.challengeGallery.hidden = false
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
