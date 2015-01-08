//
//  ChallengeFilterTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// TODO: Filters Applied are shown in gallery view


// Controller for challenge filter table view, displays available filters and lets user apply selected filters
class ChallengeFilterTableViewController: UITableViewController {

    // Array of tuples of type (Filter Title, [Filter Accessory Items]) for Filters
    var challengeFilters:[(filterTitle:String, filterDescription:String, filterParameters:[(parameterTitle:String, parameterSelected:Bool)])] = [("Difficulty", "intense, intermediate, or casual", [("Intense", false), ("Intermediate", false), ("Casual", false)]), ("People", "strangers, friends, or family", [("Strangers", false), ("Friends", false), ("Family", false)]), ("Places", "school, work, or home", [("School", false), ("Work", false), ("Home", false)])]
    var filterStrings:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return challengeFilters.count
    }
    
    // Prepare for apply filters segue, pass selected filters as a string array to destination vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ApplyFilters"{
            let galleryVC:ChallengeGalleryViewController = segue.destinationViewController.childViewControllers[0] as ChallengeGalleryViewController
            galleryVC.filters = self.filterStrings
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return challengeFilters[section].filterTitle
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeFilters[section].filterParameters.count
    }

    // Table view data source method
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChallengeFilterCell", forIndexPath: indexPath) as ChallengeFilterTableViewCell
        cell.challengeFilterTitleLabel.text = challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle
        if challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected || contains(filterStrings, challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }

    // Dismiss modal filter view if Cancel button tapped
    @IBAction func cancelBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Initiate filtering sequence if Apply button tapped
    @IBAction func applyBarButtonItemTapped(sender: UIBarButtonItem) {
        for filterCategory in challengeFilters{
            for filterParameter in filterCategory.filterParameters{
                if filterParameter.parameterSelected{
                    filterStrings += [filterParameter.parameterTitle]
                }
            }
        }
        ((self.parentViewController?.presentingViewController?.childViewControllers[0] as ChallengeGalleryViewController).filters).removeAll(keepCapacity: true)
        ((self.parentViewController?.presentingViewController?.childViewControllers[0] as ChallengeGalleryViewController).filters) += self.filterStrings
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Modify row accessory state if did select row at index path
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected = !challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected
        self.filterStrings = self.filterStrings.filter{($0 != self.challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle)}
        self.tableView.reloadData()
    }
    

}
