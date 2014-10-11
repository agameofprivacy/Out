//
//  ChallengeFilterTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengeFilterTableViewController: UITableViewController {

    
    // Array of tuples of type (Filter Title, [Filter Accessory Items]) for Filters
    var challengeFilters:[(filterTitle:String, filterDescription:String, filterParameters:[(parameterTitle:String, parameterSelected:Bool)])] = [("Difficulty", "intense, intermediate, or casual", [("Intense", true), ("Intermediate", true), ("Casual", true)]), ("People", "strangers, friends, or family", [("Strangers", true), ("Friends", true), ("Family", true)]), ("Places", "school, work, or home", [("School", true), ("Work", true), ("Home", true)])]
    var filterStrings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        if challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected{
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
        self.tableView.reloadData()
    }
    

}
