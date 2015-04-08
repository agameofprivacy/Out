//
//  MyProgressViewController.swift
//  Out
//
//  Created by Eddie Chen on 11/10/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MyProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chartShade:UIView!
    var sortedByCategoryLabel:UILabel!
    var categoryParamLabel1:UILabel!
    var categoryParamVisualImageView1:UIImageView!
    var categoryParamLabel2:UILabel!
    var categoryParamVisualImageView2:UIImageView!
    var categoryParamLabel3:UILabel!
    var categoryParamVisualImageView3:UIImageView!
    var chartShadeEmptyLabel:UILabel!
    
    var segmentShade:UIView!
    var segmentShadeBottomSeparator:UIView!
    var challengesSwitch:UISegmentedControl!
    
    var toDoTableView:UITableView!
    var doneTableView:UITableView!

    var userChallengeData:[PFObject] = []
    var toDoChallenges:[PFObject] = []
    var doneChallenges:[PFObject] = []
    
    var alertController:UIAlertController!
    
    var myProgressPieChart:PNPieChart!
    var myProgressPieChartItems:NSArray!
    
    var currentSortCategory = ""
    
    var colorDictionary =
        [
            "Intense":UIColor(red: 223/255, green: 48/255, blue: 97/255, alpha: 1),
            "Intermediate":UIColor(red: 255/255, green: 206/255, blue: 0/255, alpha: 1),
            "Casual":UIColor(red: 32/255, green: 220/255, blue: 129/255, alpha: 1),
            "Home":UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1),
            "School":UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1),
            "Work":UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1),
            "Family":UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1),
            "Friends":UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1),
            "Strangers":UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        self.alertController = UIAlertController(title: "Select a Sort Category", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {(alertController:UIAlertAction!) in
//            println("Canceled")
        }
        
        var difficultyAction = UIAlertAction(title: "Difficulty", style: UIAlertActionStyle.Default) {(alertController:UIAlertAction!) in self.redrawChartToSort("difficulty")}
        
        var placeAction = UIAlertAction(title: "Place", style: UIAlertActionStyle.Default) {(alertController:UIAlertAction!) in self.redrawChartToSort("place")}
        
        var peopleAction = UIAlertAction(title: "People", style: UIAlertActionStyle.Default) {(alertController:UIAlertAction!) in self.redrawChartToSort("people")}

        
        alertController.addAction(cancelAction)
        alertController.addAction(difficultyAction)
        alertController.addAction(placeAction)
        alertController.addAction(peopleAction)
        
        self.toDoTableView = UITableView(frame: CGRectMake(0, 298, self.view.frame.width, self.view.frame.height - 298))
        self.toDoTableView.delegate = self
        self.toDoTableView.dataSource = self
        self.toDoTableView.registerClass(ChallengeRecordTableViewCell.self, forCellReuseIdentifier: "ChallengeRecordTableViewCell")
        self.toDoTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.toDoTableView.rowHeight = UITableViewAutomaticDimension
        self.toDoTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.toDoTableView.estimatedRowHeight = 64
        self.view.addSubview(self.toDoTableView)
        
        self.doneTableView = UITableView(frame: CGRectMake(0, 298, self.view.frame.width, self.view.frame.height - 298))
        self.doneTableView.delegate = self
        self.doneTableView.dataSource = self
        self.doneTableView.registerClass(ChallengeRecordTableViewCell.self, forCellReuseIdentifier: "ChallengeRecordTableViewCell")
        self.doneTableView.hidden = true
        self.doneTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.doneTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.doneTableView.estimatedRowHeight = 64
        self.doneTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.doneTableView)
        
        self.segmentShade = UIView(frame: CGRectMake(0, 254, self.view.frame.width, 45))
        self.segmentShade.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.segmentShade)
        
        self.challengesSwitch = UISegmentedControl(items: ["Remaining","Completed"])
        self.challengesSwitch.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengesSwitch.tintColor = UIColor.blackColor()
        self.challengesSwitch.selectedSegmentIndex = 0
        self.challengesSwitch.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.segmentShade.addSubview(self.challengesSwitch)
        
        self.segmentShadeBottomSeparator = UIView(frame: CGRectZero)
        self.segmentShadeBottomSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentShadeBottomSeparator.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        self.segmentShade.addSubview(self.segmentShadeBottomSeparator)
        
        var viewsDictionary = ["challengesSwitch":self.challengesSwitch, "segmentShadeBottomSeparator":self.segmentShadeBottomSeparator]
        var metricsDictionary = ["margin":7.5]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[challengesSwitch]-margin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var separatorBottomHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[segmentShadeBottomSeparator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=8-[challengesSwitch(28)]->=8-[segmentShadeBottomSeparator(1)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        self.segmentShade.addConstraints(horizontalConstraints)
        self.segmentShade.addConstraints(separatorBottomHorizontalConstraints)
        self.segmentShade.addConstraints(verticalConstraints)
        
        self.chartShade = UIView(frame: CGRectMake(0, 64, self.view.frame.width, 190))
        self.chartShade.layer.shadowColor = UIColor.blackColor().CGColor
        self.chartShade.layer.shadowOpacity = 0.15
        self.chartShade.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.chartShade.layer.shadowRadius = 1
        self.chartShade.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(self.chartShade)
    
        self.chartShadeEmptyLabel = UILabel(frame: CGRectMake(0, 0, self.chartShade.frame.width, self.chartShade.frame.height))
        self.chartShadeEmptyLabel.textAlignment = NSTextAlignment.Center
        self.chartShadeEmptyLabel.text = "No Challenges"
        self.chartShadeEmptyLabel.hidden = true
        self.chartShade.addSubview(self.chartShadeEmptyLabel)
        
        self.sortedByCategoryLabel = UILabel(frame:CGRectMake(0, 15, self.view.frame.width, 30))
        self.sortedByCategoryLabel.text = "Challenges sorted by " + self.currentSortCategory
        self.sortedByCategoryLabel.textAlignment = NSTextAlignment.Center
        self.sortedByCategoryLabel.font = UIFont(name: "HelveticaNeue", size: 15.0)
        self.sortedByCategoryLabel.hidden = true
        self.chartShade.addSubview(self.sortedByCategoryLabel)
        
        self.categoryParamVisualImageView1 = UIImageView(frame: CGRectMake(self.chartShade.frame.width/2 + 20, 78, 20, 20))
        self.categoryParamVisualImageView1.hidden = true
        self.categoryParamVisualImageView1.layer.masksToBounds = true
        self.categoryParamVisualImageView1.layer.cornerRadius = 6
        self.chartShade.addSubview(self.categoryParamVisualImageView1)

        self.categoryParamVisualImageView2 = UIImageView(frame: CGRectMake(self.chartShade.frame.width/2 + 20, 108, 20, 20))
        self.categoryParamVisualImageView2.hidden = true
        self.categoryParamVisualImageView2.layer.masksToBounds = true
        self.categoryParamVisualImageView2.layer.cornerRadius = 6
        self.chartShade.addSubview(self.categoryParamVisualImageView2)

        self.categoryParamVisualImageView3 = UIImageView(frame: CGRectMake(self.chartShade.frame.width/2 + 20, 138, 20, 20))
        self.categoryParamVisualImageView3.hidden = true
        self.categoryParamVisualImageView3.layer.masksToBounds = true
        self.categoryParamVisualImageView3.layer.cornerRadius = 6
        self.chartShade.addSubview(self.categoryParamVisualImageView3)

        
        self.categoryParamLabel1 = UILabel(frame: CGRectMake(self.chartShade.frame.width/2 + 20 + 30 , 78, chartShade.frame.width - 30, 20))
        self.categoryParamLabel1.hidden = true
        self.categoryParamLabel1.font = UIFont(name: "HelveticaNeue", size: 15.0)
        self.chartShade.addSubview(self.categoryParamLabel1)

        self.categoryParamLabel2 = UILabel(frame: CGRectMake(self.chartShade.frame.width/2 + 20 + 30 , 108, chartShade.frame.width - 30, 20))
        self.categoryParamLabel2.hidden = true
        self.categoryParamLabel2.font = UIFont(name: "HelveticaNeue", size: 15.0)
        self.chartShade.addSubview(self.categoryParamLabel2)

        self.categoryParamLabel3 = UILabel(frame: CGRectMake(self.chartShade.frame.width/2 + 20 + 30 , 138, chartShade.frame.width - 30, 20))
        self.categoryParamLabel3.hidden = true
        self.categoryParamLabel3.font = UIFont(name: "HelveticaNeue", size: 15.0)
        self.chartShade.addSubview(self.categoryParamLabel3)

        
//        var chartViewsDictionary = ["myProgressPieChart":self.myProgressPieChart]
//        var chartMetricsDictionary = ["sideMargin": 7.5]
//        
//        var chartHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|->=sideMargin-[myProgressPieChart(100)]->=sideMargin-|", options: NSLayoutFormatOptions(0), metrics: chartMetricsDictionary, views: chartViewsDictionary)
//        var chartVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=15-[myProgressPieChart(100)]->=15-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: chartMetricsDictionary, views: chartViewsDictionary)
//        
//        self.chartShade.addConstraints(chartHorizontalConstraints)
//        self.chartShade.addConstraints(chartVerticalConstraints)
        
        // UINavigationBar init
        self.navigationItem.title = "Progress"
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton

        var sortButton = UIBarButtonItem(title: "Sort", style: UIBarButtonItemStyle.Plain, target: self, action: "sortButtonTapped")
        sortButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = sortButton
        loadChallenges()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.toDoTableView{
            return self.toDoChallenges.count
        }
        else{
            return self.doneChallenges.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ChallengeRecordTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChallengeRecordTableViewCell") as! ChallengeRecordTableViewCell
        
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if tableView == self.toDoTableView{
            var challenge = self.toDoChallenges[indexPath.row] as PFObject
            var challengeTitleText = challenge["title"] as! String
            if self.currentSortCategory == "difficulty"{
            var challengeDifficulty = challenge["difficulty"] as! String
            cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary[challengeDifficulty]
            }
            else if self.currentSortCategory == "place"{
                if contains(challenge["tags"] as! [String], "Home"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Home"]
                }
                else if contains(challenge["tags"] as! [String], "School"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["School"]
                }
                else if contains(challenge["tags"] as! [String], "Work"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Work"]
                }
            }
            else if self.currentSortCategory == "people"{
                if contains(challenge["tags"] as! [String], "Family"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Family"]
                }
                else if contains(challenge["tags"] as! [String], "Friends"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Friends"]
                }
                else if contains(challenge["tags"] as! [String], "Strangers"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Strangers"]
                }
            }
            cell.challengeTitleLabel.text = challengeTitleText
        }
        else{
            var challenge = self.doneChallenges[indexPath.row] as PFObject
            var challengeTitleText = challenge["title"] as! String
            if self.currentSortCategory == "difficulty"{
                var challengeDifficulty = challenge["difficulty"] as! String
                cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary[challengeDifficulty]
            }
            else if self.currentSortCategory == "place"{
                if contains(challenge["tags"] as! [String], "Home"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Home"]
                }
                else if contains(challenge["tags"] as! [String], "School"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["School"]
                }
                else if contains(challenge["tags"] as! [String], "Work"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Work"]
                }
            }
            else if self.currentSortCategory == "people"{
                if contains(challenge["tags"] as! [String], "Family"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Family"]
                }
                else if contains(challenge["tags"] as! [String], "Friends"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Friends"]
                }
                else if contains(challenge["tags"] as! [String], "Strangers"){
                    cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary["Strangers"]
                }
            }
            cell.challengeTitleLabel.text = challengeTitleText
        }
        return cell
    }

    func valueChanged(segment:UISegmentedControl){
        if segment.selectedSegmentIndex == 0{
            self.toDoTableView.hidden = false
            self.doneTableView.hidden = true
//            if self.followers.count == 0 && self.followingRequestedFrom.count == 0{
//                self.noFollowerView.hidden = false
//            }
//            else{
//                self.noFollowerView.hidden = true
//            }
        }
        else{
            self.doneTableView.hidden = false
            self.toDoTableView.hidden = true
//            if self.following.count == 0{
//                self.noFollowingView.hidden = false
//            }
//            else{
//                self.noFollowingView.hidden = true
//            }
            
        }
        self.redrawChartToSort(self.currentSortCategory)
    }

    
    // Dismiss modal profile view if Close button tapped
    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Present sort menu if Sort button tapped
    func sortButtonTapped(){
        self.presentViewController(self.alertController, animated: true, completion: nil)
    }
    
    func redrawChartToSort(sortCategory:String){
        switch sortCategory {
        case "difficulty":
            var casualChallengeCount = 0
            var intermediateChallengeCount = 0
            var intenseChallengeCount = 0
            var casualValue:CGFloat = 0
            var intermediateValue:CGFloat = 0
            var intenseValue:CGFloat = 0
            // if toDoTableView is shown
            if !self.toDoTableView.hidden{
                // Calculate toDoChallenges difficulty values
                for challenge in self.toDoChallenges{
                    if (challenge["difficulty"] as! String) == "Casual"{
                        casualChallengeCount++
                    }
                    else if (challenge["difficulty"] as! String) == "Intermediate"{
                        intermediateChallengeCount++
                    }
                    else if (challenge["difficulty"] as! String) == "Intense"{
                        intenseChallengeCount++
                    }
                }
                casualValue = CGFloat(casualChallengeCount)/CGFloat(self.toDoChallenges.count)
                intermediateValue = CGFloat(intermediateChallengeCount)/CGFloat(self.toDoChallenges.count)
                intenseValue = CGFloat(intenseChallengeCount)/CGFloat(self.toDoChallenges.count)
            }
            // if doneTableView is shown
            else{
                for challenge in self.doneChallenges{
                    if (challenge["difficulty"] as! String) == "Casual"{
                        casualChallengeCount++
                    }
                    else if (challenge["difficulty"] as! String) == "Intermediate"{
                        intermediateChallengeCount++
                    }
                    else if (challenge["difficulty"] as! String) == "Intense"{
                        intenseChallengeCount++
                    }
                }
                casualValue = CGFloat(casualChallengeCount)/CGFloat(self.doneChallenges.count)
                intermediateValue = CGFloat(intermediateChallengeCount)/CGFloat(self.doneChallenges.count)
                intenseValue = CGFloat(intenseChallengeCount)/CGFloat(self.doneChallenges.count)
            }
            self.myProgressPieChartItems =
                [
                    PNPieChartDataItem(value: casualValue, color: self.colorDictionary["Casual"],description: ""),
                    PNPieChartDataItem(value: intermediateValue, color: self.colorDictionary["Intermediate"],description: ""),
                    PNPieChartDataItem(value: intenseValue, color: self.colorDictionary["Intense"],description: "")
                ]
            if self.currentSortCategory != "" && self.myProgressPieChart != nil{
                self.myProgressPieChart.removeFromSuperview()
            }
            if (!self.toDoTableView.hidden && self.toDoChallenges.count > 0) || (!self.doneTableView.hidden && self.doneChallenges.count > 0){
                self.myProgressPieChart = PNPieChart(frame: CGRectMake(30, 67, 100, 100), items: self.myProgressPieChartItems as [AnyObject])
                self.chartShadeEmptyLabel.hidden = true
                self.categoryParamLabel1.hidden = false
                self.categoryParamLabel2.hidden = false
                self.categoryParamLabel3.hidden = false
                self.categoryParamVisualImageView1.hidden = false
                self.categoryParamVisualImageView2.hidden = false
                self.categoryParamVisualImageView3.hidden = false
                self.chartShade.addSubview(self.myProgressPieChart)
                self.myProgressPieChart.strokeChart()
            }
            else{
                self.chartShadeEmptyLabel.hidden = false
                self.categoryParamLabel1.hidden = true
                self.categoryParamLabel2.hidden = true
                self.categoryParamLabel3.hidden = true
                self.categoryParamVisualImageView1.hidden = true
                self.categoryParamVisualImageView2.hidden = true
                self.categoryParamVisualImageView3.hidden = true
            }
            self.currentSortCategory = sortCategory
        case "place":
            self.currentSortCategory = "place"
            var homeChallengeCount = 0
            var schoolChallengeCount = 0
            var workChallengeCount = 0
            var homeValue:CGFloat = 0
            var schoolValue:CGFloat = 0
            var workValue:CGFloat = 0

            // if toDoTableView is shown
            if !self.toDoTableView.hidden{
                // Calculate toDoChallenges difficulty values
                for challenge in self.toDoChallenges{
                    if contains(challenge["tags"] as! [String], "Home"){
                        homeChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "School"){
                        schoolChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Work"){
                        workChallengeCount++
                    }
                }
                homeValue = CGFloat(homeChallengeCount)/CGFloat(self.toDoChallenges.count)
                schoolValue = CGFloat(schoolChallengeCount)/CGFloat(self.toDoChallenges.count)
                workValue = CGFloat(workChallengeCount)/CGFloat(self.toDoChallenges.count)
            }
                // if doneTableView is shown
            else{
                for challenge in self.doneChallenges{
                    if contains(challenge["tags"] as! [String], "Home"){
                        homeChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "School"){
                        schoolChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Work"){
                        workChallengeCount++
                    }
                }
                homeValue = CGFloat(homeChallengeCount)/CGFloat(self.doneChallenges.count)
                schoolValue = CGFloat(schoolChallengeCount)/CGFloat(self.doneChallenges.count)
                workValue = CGFloat(workChallengeCount)/CGFloat(self.doneChallenges.count)
            }
            self.myProgressPieChartItems =
                [
                    PNPieChartDataItem(value: homeValue, color: self.colorDictionary["Home"],description: ""),
                    PNPieChartDataItem(value: schoolValue, color: self.colorDictionary["School"],description: ""),
                    PNPieChartDataItem(value: workValue, color: self.colorDictionary["Work"],description: "")
            ]
            if self.currentSortCategory != "" && self.myProgressPieChart != nil{
                self.myProgressPieChart.removeFromSuperview()
            }
            if (!self.toDoTableView.hidden && self.toDoChallenges.count > 0) || (!self.doneTableView.hidden && self.doneChallenges.count > 0){
                self.myProgressPieChart = PNPieChart(frame: CGRectMake(30, 67, 100, 100), items: self.myProgressPieChartItems as [AnyObject])
                self.chartShadeEmptyLabel.hidden = true
                self.categoryParamLabel1.hidden = false
                self.categoryParamLabel2.hidden = false
                self.categoryParamLabel3.hidden = false
                self.categoryParamVisualImageView1.hidden = false
                self.categoryParamVisualImageView2.hidden = false
                self.categoryParamVisualImageView3.hidden = false
                self.chartShade.addSubview(self.myProgressPieChart)
                self.myProgressPieChart.strokeChart()
            }
            else{
                self.chartShadeEmptyLabel.hidden = false
                self.categoryParamLabel1.hidden = true
                self.categoryParamLabel2.hidden = true
                self.categoryParamLabel3.hidden = true
                self.categoryParamVisualImageView1.hidden = true
                self.categoryParamVisualImageView2.hidden = true
                self.categoryParamVisualImageView3.hidden = true
            }
            self.currentSortCategory = sortCategory

        case "people":
            self.currentSortCategory = "people"
            var familyChallengeCount = 0
            var friendsChallengeCount = 0
            var strangersChallengeCount = 0
            var familyValue:CGFloat = 0
            var friendsValue:CGFloat = 0
            var strangersValue:CGFloat = 0
            
            // if toDoTableView is shown
            if !self.toDoTableView.hidden{
                // Calculate toDoChallenges difficulty values
                for challenge in self.toDoChallenges{
                    if contains(challenge["tags"] as! [String], "Family"){
                        familyChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Friends"){
                        friendsChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Strangers"){
                        strangersChallengeCount++
                    }
                }
                familyValue = CGFloat(familyChallengeCount)/CGFloat(self.toDoChallenges.count)
                friendsValue = CGFloat(friendsChallengeCount)/CGFloat(self.toDoChallenges.count)
                strangersValue = CGFloat(strangersChallengeCount)/CGFloat(self.toDoChallenges.count)
            }
                // if doneTableView is shown
            else{
                for challenge in self.doneChallenges{
                    if contains(challenge["tags"] as! [String], "Family"){
                        familyChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Friends"){
                        friendsChallengeCount++
                    }
                    else if contains(challenge["tags"] as! [String], "Strangers"){
                        strangersChallengeCount++
                    }
                }
                familyValue = CGFloat(familyChallengeCount)/CGFloat(self.doneChallenges.count)
                friendsValue = CGFloat(friendsChallengeCount)/CGFloat(self.doneChallenges.count)
                strangersValue = CGFloat(strangersChallengeCount)/CGFloat(self.doneChallenges.count)
            }
            self.myProgressPieChartItems =
                [
                    PNPieChartDataItem(value: familyValue, color: self.colorDictionary["Family"],description: ""),
                    PNPieChartDataItem(value: friendsValue, color: self.colorDictionary["Friends"],description: ""),
                    PNPieChartDataItem(value: strangersValue, color: self.colorDictionary["Strangers"],description: "")
            ]
            if self.currentSortCategory != "" && self.myProgressPieChart != nil{
                self.myProgressPieChart.removeFromSuperview()
            }
            if (!self.toDoTableView.hidden && self.toDoChallenges.count > 0) || (!self.doneTableView.hidden && self.doneChallenges.count > 0){
                self.myProgressPieChart = PNPieChart(frame: CGRectMake(30, 67, 100, 100), items: self.myProgressPieChartItems as [AnyObject])
                self.chartShadeEmptyLabel.hidden = true
                self.categoryParamLabel1.hidden = false
                self.categoryParamLabel2.hidden = false
                self.categoryParamLabel3.hidden = false
                self.categoryParamVisualImageView1.hidden = false
                self.categoryParamVisualImageView2.hidden = false
                self.categoryParamVisualImageView3.hidden = false
                self.chartShade.addSubview(self.myProgressPieChart)
                self.myProgressPieChart.strokeChart()
            }
            else{
                self.chartShadeEmptyLabel.hidden = false
                self.categoryParamLabel1.hidden = true
                self.categoryParamLabel2.hidden = true
                self.categoryParamLabel3.hidden = true
                self.categoryParamVisualImageView1.hidden = true
                self.categoryParamVisualImageView2.hidden = true
                self.categoryParamVisualImageView3.hidden = true
            }
            self.currentSortCategory = sortCategory
        default:
            break
        }
        self.toDoTableView.reloadData()
        self.doneTableView.reloadData()
        var sortedSwitchTitleLabel:String
        if toDoTableView.hidden {
            sortedSwitchTitleLabel = "Completed "
        }
        else{
            sortedSwitchTitleLabel = "Remaining "
        }
        self.sortedByCategoryLabel.text = sortedSwitchTitleLabel + "challenges sorted by " + self.currentSortCategory
        self.sortedByCategoryLabel.hidden = false
        
        var param1LabelText:String
        var param2LabelText:String
        var param3LabelText:String

        
        if self.currentSortCategory == "difficulty"{
            self.categoryParamLabel1.text = "Casual"
            self.categoryParamLabel2.text = "Intermediate"
            self.categoryParamLabel3.text = "Intense"
            self.categoryParamVisualImageView1.backgroundColor = self.colorDictionary["Casual"]
            self.categoryParamVisualImageView2.backgroundColor = self.colorDictionary["Intermediate"]
            self.categoryParamVisualImageView3.backgroundColor = self.colorDictionary["Intense"]
        }
        else if self.currentSortCategory == "place"{
            self.categoryParamLabel1.text = "Home"
            self.categoryParamLabel2.text = "School"
            self.categoryParamLabel3.text = "Work"
            self.categoryParamVisualImageView1.backgroundColor = self.colorDictionary["Home"]
            self.categoryParamVisualImageView2.backgroundColor = self.colorDictionary["School"]
            self.categoryParamVisualImageView3.backgroundColor = self.colorDictionary["Work"]
        }
        else if self.currentSortCategory == "people"{
            self.categoryParamLabel1.text = "Family"
            self.categoryParamLabel2.text = "Friends"
            self.categoryParamLabel3.text = "Strangers"
            self.categoryParamVisualImageView1.backgroundColor = self.colorDictionary["Family"]
            self.categoryParamVisualImageView2.backgroundColor = self.colorDictionary["Friends"]
            self.categoryParamVisualImageView3.backgroundColor = self.colorDictionary["Strangers"]
        }
    }
    
    func loadChallenges(){

        var queryUserData = PFQuery(className: "UserChallengeData")
        queryUserData.whereKey("username", equalTo: PFUser.currentUser())
        queryUserData.whereKey("isCurrent", equalTo: false)
        queryUserData.includeKey("challenge")
        queryUserData.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.doneChallenges.removeAll(keepCapacity: false)
                for challengeData in objects{
                    self.doneChallenges.append(challengeData["challenge"] as! PFObject)
                }
                self.doneTableView.reloadData()
                
                var queryToDoChallenges = PFQuery(className: "Challenge")
                var doneChallengesObjectIdArray:[String] = []
                for challenge in self.doneChallenges{
                    doneChallengesObjectIdArray.append(challenge.objectId)
                }
                queryToDoChallenges.whereKey("objectId", notContainedIn: doneChallengesObjectIdArray)
                queryToDoChallenges.findObjectsInBackgroundWithBlock{
                    (challenges: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        self.toDoChallenges.removeAll(keepCapacity: false)
                        self.toDoChallenges = challenges as! [PFObject]
                        self.toDoTableView.reloadData()
                        self.redrawChartToSort("difficulty")
                    }
                }
                
            }
        }
        
    }

}
