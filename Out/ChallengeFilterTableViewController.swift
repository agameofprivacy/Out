//
//  ChallengeFilterTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// TODO: Filters Applied are shown in gallery view

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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return challengeFilters.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ApplyFilters"{
            let galleryVC:AddChallengeViewController = segue.destinationViewController.childViewControllers[0] as AddChallengeViewController
            galleryVC.filters = self.filterStrings
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return challengeFilters[section].filterTitle
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return challengeFilters[section].filterParameters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChallengeFilterCell", forIndexPath: indexPath) as ChallengeFilterTableViewCell

        // Configure the cell...
        
        cell.challengeFilterTitleLabel.text = challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle
        
        if challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected || contains(filterStrings, challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }

    @IBAction func cancelBarButtonItemTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func applyBarButtonItemTapped(sender: UIBarButtonItem) {
        for filterCategory in challengeFilters{
            for filterParameter in filterCategory.filterParameters{
                if filterParameter.parameterSelected{
                    filterStrings += [filterParameter.parameterTitle]
                }
            }
        }
        ((self.parentViewController?.presentingViewController?.childViewControllers[0] as AddChallengeViewController).filters).removeAll(keepCapacity: true)
        ((self.parentViewController?.presentingViewController?.childViewControllers[0] as AddChallengeViewController).filters) += self.filterStrings
        (self.parentViewController?.presentingViewController?.childViewControllers[0] as AddChallengeViewController).viewDidLoad()
        dismissViewControllerAnimated(true, completion: nil)
    }
        // Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected = !challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected
        self.filterStrings = self.filterStrings.filter{($0 != self.challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterTitle)}
        self.tableView.reloadData()
    }
    

}
