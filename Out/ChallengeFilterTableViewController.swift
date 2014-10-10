//
//  ChallengeFilterTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import Realm

class ChallengeFilterTableViewController: UITableViewController {

    
    // Array of tuples of type (Filter Title, [Filter Accessory Items]) for Filters
    var challengeFilters:[(filterTitle:String, filterDescription:String, filterParameters:[(parameterTitle:String, parameterSelected:Bool)])] = [("Difficulty", "intense, intermediate, or casual", [("Intense", false), ("Intermediate", false), ("Casual", false)]), ("People", "strangers, friends, or family", [("Strangers", false), ("Friends", false), ("Family", false)]), ("Places", "school, work, or home", [("School", false), ("Work", false), ("Home", false)])]

    
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
        var testUser = User()
        
        testUser.alias = "agameofprivacy"
        testUser.age = 25
        testUser.genderIdentity = "Male"
        testUser.sexualOrientation = "Gay"
        testUser.avatar = "Dog"
        testUser.color = "Black"
        testUser.ethnicity = "Taiwanese"
        testUser.city = "New York"
        testUser.state = "NY"
        testUser.currentChallengesKeys = ["1", "2", "3"]
        testUser.completedChallengesKeys = ["1", "2", "3"]
        
        // Get the default Realm
        
        let realm = RLMRealm.defaultRealm()
        
        println(realm.path)

    }
    // Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected = !challengeFilters[indexPath.section].filterParameters[indexPath.row].parameterSelected
        self.tableView.reloadData()
    }
    

}
