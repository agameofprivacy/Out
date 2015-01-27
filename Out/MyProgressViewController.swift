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
            "Casual":UIColor(red: 32/255, green: 220/255, blue: 129/255, alpha: 1)
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        self.alertController = UIAlertController(title: "Sort", message: "Select a sort category.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {(alertController:UIAlertAction!) in println("Canceled")}
        
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
        self.view.addSubview(self.toDoTableView)
        
        self.doneTableView = UITableView(frame: CGRectMake(0, 298, self.view.frame.width, self.view.frame.height - 298))
        self.doneTableView.delegate = self
        self.doneTableView.dataSource = self
        self.doneTableView.registerClass(ChallengeRecordTableViewCell.self, forCellReuseIdentifier: "ChallengeRecordTableViewCell")
        self.doneTableView.hidden = true
        self.doneTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.doneTableView)
        
        self.segmentShade = UIView(frame: CGRectMake(0, 254, self.view.frame.width, 45))
        self.segmentShade.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.segmentShade)
        
        self.challengesSwitch = UISegmentedControl(items: ["To Do","Done"])
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
        var cell:ChallengeRecordTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChallengeRecordTableViewCell") as ChallengeRecordTableViewCell
        
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if tableView == self.toDoTableView{
            var challenge = self.toDoChallenges[indexPath.row] as PFObject
            var challengeTitleText = challenge["title"] as String
            var challengeDifficulty = challenge["difficulty"] as String
            cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary[challengeDifficulty]
            cell.challengeTitleLabel.text = challengeTitleText
        }
        else{
            var challenge = self.doneChallenges[indexPath.row] as PFObject
            var challengeTitleText = challenge["title"] as String
            var challengeDifficulty = challenge["difficulty"] as String
            cell.challengeTypeIconImageView.backgroundColor = self.colorDictionary[challengeDifficulty]
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
        println("sorted")
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
                    if (challenge["difficulty"] as String) == "Casual"{
                        casualChallengeCount++
                    }
                    else if (challenge["difficulty"] as String) == "Intermediate"{
                        intermediateChallengeCount++
                    }
                    else if (challenge["difficulty"] as String) == "Intense"{
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
                    if (challenge["difficulty"] as String) == "Casual"{
                        casualChallengeCount++
                    }
                    else if (challenge["difficulty"] as String) == "Intermediate"{
                        intermediateChallengeCount++
                    }
                    else if (challenge["difficulty"] as String) == "Intense"{
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
            if self.currentSortCategory != ""{
                self.myProgressPieChart.removeFromSuperview()
            }
            println(casualValue)
            println(intermediateValue)
            println(intenseValue)
            self.myProgressPieChart = PNPieChart(frame: CGRectMake(30, 30, 130, 130), items: self.myProgressPieChartItems)
            self.chartShade.addSubview(self.myProgressPieChart)
            self.myProgressPieChart.strokeChart()
            self.currentSortCategory = sortCategory
        case "place":
            self.currentSortCategory = "place"
            println("modify items for place")
            println("redraw chart")
        case "people":
            self.currentSortCategory = "people"
            println("modify items for people")
            println("redraw chart")
        default:
            break
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
                    self.doneChallenges.append(challengeData["challenge"] as PFObject)
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
                        self.toDoChallenges = challenges as [PFObject]
                        self.toDoTableView.reloadData()
                        self.redrawChartToSort("difficulty")
                    }
                }
                
            }
        }
        
    }

}
