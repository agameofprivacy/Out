//
//  PeopleGalleryViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/2/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class PeopleGalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var peopleTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add People"
        
        var filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "presentFilterView:")
        filterButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = filterButton
        
        self.peopleTableView = UITableView(frame: CGRectZero)
        self.peopleTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        self.peopleTableView.estimatedRowHeight = 80
        self.peopleTableView.frame = self.view.frame
        self.peopleTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.peopleTableView.registerClass(PersonFollowTableViewCell.self, forCellReuseIdentifier: "PersonFollowTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PersonFollowTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonFollowTableViewCell") as PersonFollowTableViewCell
        
        return cell
    }
    

}
