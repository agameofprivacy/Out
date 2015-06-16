//
//  ChallengeGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/20/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import Parse
// Controller for challenge gallery view, loads and displays challenges available for current user
class ChallengeGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var challengesTableView:UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    var challengeModelsObjects:[AnyObject] = []
    var filters:[String] = []
    var currentChallengesStrings:[String] = []
    
    var challengeTabVC:ChallengesTabViewController!
    
    var noChallengeView:UIView!
    
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
        self.challengesTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        
        self.challengesTableView.registerClass(ChallengeGalleryTableViewCell.self, forCellReuseIdentifier: "ChallengeGalleryTableViewCell")
        
        self.view.addSubview(challengesTableView)

        self.activityIndicator = UIActivityIndicatorView(frame: self.challengesTableView.frame)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.activityIndicator.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.view.addSubview(self.activityIndicator)
        
        // noChallengeView init and layout
        
        self.noChallengeView = UIView(frame: self.challengesTableView.frame)
        self.noChallengeView.center = self.challengesTableView.center
        
        let noChallengeViewTitle = UILabel(frame: CGRectMake(0, 2 * self.noChallengeView.frame.height / 5, self.noChallengeView.frame.width, 32))
        noChallengeViewTitle.text = "No More Activities"
        noChallengeViewTitle.textAlignment = NSTextAlignment.Center
        noChallengeViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noChallengeViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noChallengeView.addSubview(noChallengeViewTitle)
        
        let noChallengeViewSubtitle = UILabel(frame: CGRectMake(0, 2 * self.noChallengeView.frame.height / 5 + 31, self.noChallengeView.frame.width, 30))
        noChallengeViewSubtitle.text = "you're done with them all!"
        noChallengeViewSubtitle.textAlignment = NSTextAlignment.Center
        noChallengeViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noChallengeViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noChallengeView.addSubview(noChallengeViewSubtitle)
        
        self.noChallengeView.hidden = true
        self.view.addSubview(self.noChallengeView)
    }
    
    override func viewDidAppear(animated: Bool) {
        loadAvailableChallenges()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for pick filters segue, pass currently selected filters to be marked in destination vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickFilters"{
            let FilterVC:ChallengeFilterTableViewController = segue.destinationViewController.childViewControllers[0] as! ChallengeFilterTableViewController
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

        let challengeObject:PFObject = self.challengeModelsObjects[indexPath.item] as! PFObject

        let cell:ChallengeGalleryTableViewCell = self.challengesTableView.dequeueReusableCellWithIdentifier("ChallengeGalleryTableViewCell") as! ChallengeGalleryTableViewCell
        cell.titleLabel.text = challengeObject["title"] as! String?
        let reasonType:String = challengeObject["reason"]![0] as! String
        let reasonText:String = challengeObject["reason"]![1] as! String
        cell.reasonLabel.text = "\(reasonType): \(reasonText)"
        cell.introLabel.text = challengeObject["blurb"] as! String?
        
        return cell
    }
    
    // Add challenge to user's current challenges on Parse if challenge tapped, then reload available challenges in current view
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedChallengeObject:PFObject = self.challengeModelsObjects[indexPath.row] as! PFObject

        let newChallengeModel = PFObject(className: "UserChallengeData")
        newChallengeModel["alias"] = PFUser.currentUser()!.username
        newChallengeModel["title"] = selectedChallengeObject["title"]
        newChallengeModel["version"] = selectedChallengeObject["version"]
        newChallengeModel["isCurrent"] = true
        newChallengeModel["username"] = PFUser.currentUser()
        newChallengeModel["challenge"] = selectedChallengeObject
        newChallengeModel["currentStepCount"] = 0
        newChallengeModel["challengeTrackNumber"] = "0"
        newChallengeModel["stepContent"] = []

        newChallengeModel.saveInBackgroundWithBlock{(succeeded, error) -> Void in
            if error == nil{
                self.challengeTabVC.loadCurrentChallenges()
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
            self.noChallengeView.hidden = true
    }
    
    // Load available challenges from Parse
    func loadAvailableChallenges(){

        self.challengesTableView.hidden = true
        self.activityIndicator.startAnimating()
        self.challengeModelsObjects.removeAll(keepCapacity: true)
        self.currentChallengesStrings.removeAll(keepCapacity: true)
        
        let query = PFQuery(className:"Challenge")
        // Apply filters if count of filter strings is greater than 0
        if filters.count > 0{
            query.whereKey("tags", containedIn: filters)
        }
        
        // Query challenges already current to the user
        let currentChallengesQuery = PFQuery(className: "UserChallengeData")
        currentChallengesQuery.whereKey("username", equalTo: PFUser.currentUser()!)

        currentChallengesQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                // Found user's current challenges, add challenge title to currentChallengesStrings
                for object in objects as! [PFObject]{
                    self.currentChallengesStrings += [(object["title"] as! String)]
                }
                query.findObjectsInBackgroundWithBlock {
                    (objects, error) -> Void in
                    if error == nil {
                        // Found challenges that satisfy filter selection
                        self.challengeModelsObjects = objects!
                        var indexForToRemove:[Int] = []
                        // Remove challenges that are already current to user
                        if self.challengeModelsObjects.count > 0{
                            for (index,challenge) in self.challengeModelsObjects.enumerate(){
                                if self.currentChallengesStrings.contains(challenge["title"] as! String){
                                    indexForToRemove += [index]
                                }
                            }
                            self.challengeModelsObjects.removeObjectAtIndexes(indexForToRemove)
                        }
                        self.challengesTableView!.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                        self.activityIndicator.stopAnimating()
                        self.challengesTableView.hidden = false
                        if self.challengeModelsObjects.count == 0{
                            self.noChallengeView.hidden = false
                        }
                        else{
                            self.noChallengeView.hidden = true
                        }
                    } else {
                        // Log details of the failure
                        NSLog("Error: %@ %@", error!, error!.userInfo)
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
    }
    
    // Dismiss challenge gallery view if Close button tapped
    @IBAction func closeBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Present filter view if Filter button tapped
    @IBAction func filterBarButtonItemTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("PickFilters", sender: self)
    }

}

// Helper Array extension to remove objects in array
extension Array {
    mutating func removeObjectAtIndexes(indexes: [Int]) {
        let indexSet = NSMutableIndexSet()

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