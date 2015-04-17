//
//  ChallengesTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

// Collect Step Data protocol
protocol CollectStepData {
    
    func collectData() -> [String:String]
    
}

// Controller for challenges tab view
class ChallengesTabViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, PresentNewView{
    
    var currentChallengesCardsCollectionView: UICollectionView!
    var cardNumberPageControl: UIPageControl!
    let layout = ChallengeCardsCollectionViewFlowLayout()
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengesObjects:[AnyObject] = []
    var stepFullUserDataDictionary:[String:String] = [:]
    var noChallengeView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var suggestButton = UIBarButtonItem(title: "Suggest", style: UIBarButtonItemStyle.Plain, target: self, action: "suggestChallenge")
//        suggestButton.enabled = false
//        suggestButton.tintColor = UIColor.blackColor()
//        self.navigationItem.leftBarButtonItem = suggestButton

        
        // Current challenges cards collection view init and layout
        currentChallengesCardsCollectionView = UICollectionView(frame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        currentChallengesCardsCollectionView.collectionViewLayout = layout
        currentChallengesCardsCollectionView.delegate = self
        currentChallengesCardsCollectionView.dataSource = self
        currentChallengesCardsCollectionView.pagingEnabled = true
        currentChallengesCardsCollectionView.alwaysBounceHorizontal = true
        layout.itemSize = CGSizeMake(self.view.frame.size.width - 15.0, self.view.frame.size.height - 160)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        currentChallengesCardsCollectionView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        currentChallengesCardsCollectionView.showsHorizontalScrollIndicator = false
        currentChallengesCardsCollectionView.registerClass(ChallengesTabCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCard")
        
        // Card number page control init and layout
        cardNumberPageControl = UIPageControl(frame: CGRectMake(self.view.frame.origin.x + 40, self.view.bounds.size.height - 74.0, self.view.frame.size.width - 80.0, 18.0))
        cardNumberPageControl.hidesForSinglePage = true
        cardNumberPageControl.backgroundColor = UIColor.clearColor()
        cardNumberPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        cardNumberPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        cardNumberPageControl.userInteractionEnabled = false
        self.view.addSubview(currentChallengesCardsCollectionView)
        self.view.addSubview(cardNumberPageControl)
        
        // Activity indicator init and layout
        activityIndicator = UIActivityIndicatorView(frame: self.currentChallengesCardsCollectionView.frame)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.view.addSubview(activityIndicator)

        // No challenge view init and layout
        self.noChallengeView = UIView(frame: self.currentChallengesCardsCollectionView.frame)
        self.noChallengeView.center = self.view.center
        var noChallengeViewTitle = UILabel(frame: CGRectMake(0, 2 * self.noChallengeView.frame.height / 5, self.noChallengeView.frame.width, 32))
        
        noChallengeViewTitle.text = "No Activity"
        noChallengeViewTitle.textAlignment = NSTextAlignment.Center
        noChallengeViewTitle.font = UIFont(name: "HelveticaNeue", size: 26.0)
        noChallengeViewTitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noChallengeView.addSubview(noChallengeViewTitle)
        var noChallengeViewSubtitle = UILabel(frame: CGRectMake(0, 2 * self.noChallengeView.frame.height / 5 + 31, self.noChallengeView.frame.width, 30))
        
        noChallengeViewSubtitle.text = "tap '+' to add an activity"
        noChallengeViewSubtitle.textAlignment = NSTextAlignment.Center
        noChallengeViewSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        noChallengeViewSubtitle.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.noChallengeView.addSubview(noChallengeViewSubtitle)
        
        self.noChallengeView.hidden = true
        self.view.addSubview(self.noChallengeView)
        
        loadCurrentChallenges()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentChallengesObjects.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCard", forIndexPath: indexPath) as! ChallengesTabCollectionViewCell

        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.25).CGColor

        // Load current challenge data
        var challengeModel = self.currentChallengesObjects[indexPath.item]["challenge"] as! PFObject
        var currentChallengeData = self.currentChallengesObjects[indexPath.item] as! PFObject
        var currentCellContentArray:[[String]] = challengeModel["stepContent"] as! [[String]]
        var contentDictionary:[[String:String]] = self.contentDictionary(currentCellContentArray)
        cell.currentChallengeModel = challengeModel
        cell.currentChallengeData = currentChallengeData
        cell.contentDictionary = contentDictionary
        cell.titleLabel.text = self.currentChallengesObjects[indexPath.item]["title"] as! String?
        cell.nextStepButton.addTarget(self, action: "nextStepButtonTapped:", forControlEvents: .TouchUpInside)
        
        // Check currentStepCount to display correct text for challenge subtitle
        var currentStepCount = currentChallengeData["currentStepCount"] as! Int
        if currentStepCount == 0{
            var reason = challengeModel["reason"] as! [String]
            var subtitleString = reason[0] + ": " + reason[1]
            cell.subtitleLabel.text = subtitleString
            cell.canvasTableView.reloadData()
        }
        else{
            var currentStepTitles:[String] = challengeModel["stepTitle"] as! [String]
            var currentStepTitle:String = currentStepTitles[currentStepCount - 1]
            var subtitleString = "Step \(currentStepCount): \(currentStepTitle)"
            cell.subtitleLabel.text = subtitleString
            cell.canvasTableView.reloadData()
        }
        
        return cell
    }
    
    // Update card number page control when scrolling on collection view ends
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var currentPage:CGFloat = self.currentChallengesCardsCollectionView.contentOffset.x / self.currentChallengesCardsCollectionView.frame.size.width
        self.cardNumberPageControl.currentPage = Int(ceil(Float(currentPage)))
    }
    
    // Load and display current challenges from Parse
    func loadCurrentChallenges(){
        // Hide cards and display activity indicator
        self.currentChallengesCardsCollectionView.hidden = true
        self.activityIndicator.startAnimating()
        
        // Parse query for current user's current challenges
        var queryIsCurrentIsCurrentUser = PFQuery(className:"UserChallengeData")
        queryIsCurrentIsCurrentUser.whereKey("isCurrent", equalTo:true)
        queryIsCurrentIsCurrentUser.whereKey("username", equalTo: PFUser.currentUser())
        queryIsCurrentIsCurrentUser.includeKey("challenge")
        queryIsCurrentIsCurrentUser.orderByDescending("createdAt")
        queryIsCurrentIsCurrentUser.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.currentChallengesObjects = objects
                self.cardNumberPageControl.numberOfPages = self.currentChallengesObjects.count
                self.currentChallengesCardsCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
                if self.currentChallengesObjects.count == 0{
                    self.noChallengeView.hidden = false
                }
                else{
                    self.noChallengeView.hidden = true
                }
                self.currentChallengesCardsCollectionView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    // Prepare for add challenge segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addChallenge"{
            var modalVC = segue.destinationViewController as! UINavigationController
            var challengeGalleryVC = modalVC.childViewControllers[0] as! ChallengeGalleryViewController
            challengeGalleryVC.challengeTabVC = self
        }
    }

    // When next step button is tapped, collect current user input and load cells from next step
    func nextStepButtonTapped(sender:UIButton!){

        var cells = self.currentChallengesCardsCollectionView.visibleCells()
        var currentCell = cells[0] as! ChallengesTabCollectionViewCell

        // Loop through sections of current cell canvas
        for var section:Int = 0; section < currentCell.canvasTableView.numberOfSections(); section++ {
            // Loop through cells of current section
            for var row:Int = 0; row < currentCell.canvasTableView.numberOfRowsInSection(section); row++ {
                
                var cellPath:NSIndexPath = NSIndexPath(forRow: row, inSection: section)

                if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is GallerySelectTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as! GallerySelectTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is PromptAndAnswerTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as! PromptAndAnswerTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is PickerViewTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as! PickerViewTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is TextFieldInputTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as! TextFieldInputTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is BoolPickerTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as! BoolPickerTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                }
                // Clean up collected data
                self.stepFullUserDataDictionary.removeValueForKey("")
            }
        }
        
        var indexPath:NSIndexPath = self.currentChallengesCardsCollectionView.indexPathForCell(cells[0] as! ChallengesTabCollectionViewCell)!
        var itemNumber = indexPath.item
        var currentChallengeObject:PFObject = currentChallengesObjects[itemNumber] as! PFObject
        var currentStepCount = currentChallengeObject["currentStepCount"] as! Int
        var currentChallengeModel = currentChallengeObject["challenge"] as! PFObject
        
        if currentStepCount > 0{
            
            if stepFullUserDataDictionary["challengeTrack"] != nil{
                // Store collected step user data to PFObject
                currentChallengeObject["challengeTrackNumber"] = stepFullUserDataDictionary["challengeTrack"]
            }
            else{
                currentChallengeObject["challengeTrackNumber"] = "0"
            }
            
            var dictionary:[String] = []
            for (key, value) in stepFullUserDataDictionary{
                dictionary.append(key)
                dictionary.append(value)
            }

            // Filter out dictionary items with empty values
            dictionary.filter{$0 != ""}
            var stepContent:[[String]] = currentChallengeObject["stepContent"] as! [[String]]
            stepContent.append(dictionary)
            currentChallengeObject["stepContent"] = stepContent
        }
        // If there is more steps in current challenge, update current step count and step title information on card
        if currentStepCount < currentChallengeModel["stepTitle"].count{
            currentChallengeObject["currentStepCount"] = ++currentStepCount
            currentChallengeObject.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                if error == nil{
                    currentCell.canvasTableView.reloadData()
                    var currentStepTitles:[String] = currentChallengeModel["stepTitle"] as! [String]
                    var currentStepTitle:String = currentStepTitles[currentStepCount - 1]
                    var subtitleString:String = "Step \(currentStepCount): \(currentStepTitle)"
                    self.stepFullUserDataDictionary.removeAll(keepCapacity:true)
                    currentCell.countofCellTypeDictionary.removeAll(keepCapacity: true)
                    currentCell.subtitleLabel.text = subtitleString
                }
            }
        }
        // Else update challenge on Parse as completed and timestamp said completion, once step updated, reload current challenge cards and create new Activity on Parse
        else{
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
            let hour = components.hour
            let minutes = components.minute
            
            currentChallengeObject["isCurrent"] = false
            currentChallengeObject["completedDate"] = date
            currentChallengeObject.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                if error == nil{
                    self.loadCurrentChallenges()
                    // Challenge Completed, show message
                }
            }
            
            var newActivity = PFObject(className: "Activity", dictionary: ["challenge":currentChallengeModel, "userChallengeData":currentChallengeObject, "ownerUser":PFUser.currentUser()])
            newActivity.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError!) -> Void in
                if error == nil{
                    // Challenge Completed, show message
                }
            }
        }
    }

    // Return current challenges objects
    func returnCurrentChallengesObjects() -> [AnyObject]{
        return self.currentChallengesObjects
    }

    // Process array of arrays into dictionary format
    func contentDictionary(raw:[[String]]) -> [[String:String]]{
        var arrayCount = 0
        var contentDictionary:[[String:String]] = []
        for contentArrayOfAStep in raw{
            var indexCount = 0
            var stepDictionary:[String:String] = ["":""]
            while(indexCount < raw[arrayCount].count){
                var key = contentArrayOfAStep[indexCount]
                var value = contentArrayOfAStep[indexCount + 1]
                stepDictionary.updateValue(value, forKey: key)
                indexCount += 2
            }
            contentDictionary.append(stepDictionary)
            arrayCount += 1
        }
        return contentDictionary
    }
    
    // Protocol implementation for PresentNewView
    func presentWebView(url: NSURL) {
        var webView = WebViewViewController()
        webView.url = url
        var newViewController = UINavigationController(rootViewController: webView)
        newViewController.setToolbarHidden(false, animated: true)
        self.presentViewController(newViewController, animated: true, completion: nil)
    }
    func suggestChallenge(){
        println("suggest challenge")
    }
}

// Helper function for contentDictionary()
func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {     for (k, v) in right {         left.updateValue(v, forKey: k)     } }