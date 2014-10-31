//
//  ChallengeGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/20/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var challengesTableView:UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    var challengeModelsObjects:[AnyObject] = []
    var filters:[String] = []
    var currentChallengesStrings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengesTableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
        self.challengesTableView.dataSource = self
        self.challengesTableView.delegate = self
        self.challengesTableView.alwaysBounceVertical = true
        self.challengesTableView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.challengesTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.challengesTableView.rowHeight = UITableViewAutomaticDimension
        self.challengesTableView.estimatedRowHeight = 150
        self.challengesTableView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 10, right: 0)
        
        self.challengesTableView.registerClass(ChallengeGalleryTableViewCell.self, forCellReuseIdentifier: "ChallengeGalleryTableViewCell")
        
        self.view.addSubview(challengesTableView)

        self.activityIndicator = UIActivityIndicatorView(frame: self.challengesTableView.frame)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.activityIndicator.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.view.addSubview(self.activityIndicator)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadAvailableChallenges()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickFilters"{
            let FilterVC:ChallengeFilterTableViewController = segue.destinationViewController.childViewControllers[0] as ChallengeFilterTableViewController
            FilterVC.filterStrings = self.filters
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.challengeModelsObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var challengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as PFObject

        let cell:ChallengeGalleryTableViewCell = self.challengesTableView.dequeueReusableCellWithIdentifier("ChallengeGalleryTableViewCell") as ChallengeGalleryTableViewCell
        cell.titleLabel.text = challengeObject["title"] as String?
        var reasonType:String = challengeObject["reason"]![0] as String
        var reasonText:String = challengeObject["reason"]![1] as String
        cell.reasonLabel.text = "\(reasonType): \(reasonText)"
        cell.introLabel.text = challengeObject["blurb"] as String?
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var selectedChallengeObject:PFObject = self.challengeModelsObjects[indexPath.row] as PFObject

        var newChallengeModel = PFObject(className: "UserChallengeData")
        newChallengeModel["alias"] = PFUser.currentUser().username
        newChallengeModel["title"] = selectedChallengeObject["title"]
        newChallengeModel["version"] = selectedChallengeObject["version"]
        newChallengeModel["isCurrent"] = true
        newChallengeModel["username"] = PFUser.currentUser()
        newChallengeModel["challenge"] = selectedChallengeObject
        newChallengeModel["currentStepCount"] = 0
        newChallengeModel["challengeTrackNumber"] = ""
        newChallengeModel["stepContent"] = []

        newChallengeModel.saveInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadAvailableChallenges(){
        self.challengesTableView.hidden = true
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
                        self.challengesTableView!.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.challengesTableView.hidden = false
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
    
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func filterBarButtonItemTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("PickFilters", sender: self)
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