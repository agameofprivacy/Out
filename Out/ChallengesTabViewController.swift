//
//  ChallengesTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

protocol CollectStepData {

    func collectData() -> [String:String]
    
}


class ChallengesTabViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, PresentNewView{
    
    var currentChallengesCardsCollectionView: UICollectionView!
    var cardNumberPageControl: UIPageControl!
    let layout = ChallengeCardsCollectionViewFlowLayout()
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengesObjects:[AnyObject] = []
    var stepFullUserDataDictionary:[String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        currentChallengesCardsCollectionView = UICollectionView(frame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        
        currentChallengesCardsCollectionView.collectionViewLayout = layout
        currentChallengesCardsCollectionView.delegate = self
        currentChallengesCardsCollectionView.dataSource = self
        currentChallengesCardsCollectionView.pagingEnabled = true
        currentChallengesCardsCollectionView.alwaysBounceHorizontal = true
        layout.itemSize = CGSizeMake(self.view.frame.size.width - 24.0, self.view.frame.size.height - 167)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        currentChallengesCardsCollectionView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        currentChallengesCardsCollectionView.showsHorizontalScrollIndicator = false
        currentChallengesCardsCollectionView.registerClass(ChallengesTabCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCard")
        
        cardNumberPageControl = UIPageControl(frame: CGRectMake(self.view.frame.origin.x + 40, self.view.bounds.size.height - 77.0, self.view.frame.size.width - 80.0, 18.0))
        cardNumberPageControl.hidesForSinglePage = true
        cardNumberPageControl.backgroundColor = UIColor.clearColor()
        cardNumberPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        cardNumberPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        cardNumberPageControl.userInteractionEnabled = false
        self.view.addSubview(currentChallengesCardsCollectionView)
        self.view.addSubview(cardNumberPageControl)
        
        activityIndicator = UIActivityIndicatorView(frame: self.currentChallengesCardsCollectionView.frame)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.view.addSubview(activityIndicator)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadCurrentChallenges()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return currentChallengesObjects.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCard", forIndexPath: indexPath) as ChallengesTabCollectionViewCell
        // Configure the cell
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor

        var challengeModel = self.currentChallengesObjects[indexPath.item]["challenge"] as PFObject
        var currentChallengeData = self.currentChallengesObjects[indexPath.item] as PFObject
        var currentCellContentArray:[[String]] = challengeModel["stepContent"] as [[String]]
        var contentDictionary:[[String:String]] = self.contentDictionary(currentCellContentArray)
        cell.currentChallengeModel = challengeModel
        cell.currentChallengeData = currentChallengeData
        cell.contentDictionary = contentDictionary
        cell.titleLabel.text = self.currentChallengesObjects[indexPath.item]["title"] as String?
        cell.nextStepButton.addTarget(self, action: "nextStepButtonTapped:", forControlEvents: .TouchUpInside)
        
        // Check for currentStepCount correctness.
        var currentStepCount = currentChallengeData["currentStepCount"] as Int
        if currentStepCount == 0{
            var reason = challengeModel["reason"] as [String]
            var subtitleString = reason[0] + ": " + reason[1]
            cell.subtitleLabel.text = subtitleString
            
            // galleryselect lockup bug here caused by reloadData
            cell.canvasTableView.reloadData()
        }
        else{
            var currentStepTitles:[String] = challengeModel["stepTitle"] as [String]
            var currentStepTitle:String = currentStepTitles[currentStepCount - 1]
            var subtitleString = "Step \(currentStepCount): \(currentStepTitle)"
            cell.subtitleLabel.text = subtitleString
            cell.canvasTableView.reloadData()
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var currentPage:CGFloat = self.currentChallengesCardsCollectionView.contentOffset.x / self.currentChallengesCardsCollectionView.frame.size.width
        self.cardNumberPageControl.currentPage = Int(ceil(Float(currentPage)))
    }
    
    func loadCurrentChallenges(){
        self.currentChallengesCardsCollectionView.hidden = true
        self.activityIndicator.startAnimating()
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
                self.currentChallengesCardsCollectionView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    @IBAction func addChallengeBarButtonItemTapped(sender: UIBarButtonItem) {

    }

    
    func nextStepButtonTapped(sender:UIButton!){
        var cells = self.currentChallengesCardsCollectionView.visibleCells()
        var currentCell = cells[0] as ChallengesTabCollectionViewCell
        
        for var section:Int = 0; section < currentCell.canvasTableView.numberOfSections(); section++ {
            for var row:Int = 0; row < currentCell.canvasTableView.numberOfRowsInSection(section); row++ {
                var cellPath:NSIndexPath = NSIndexPath(forRow: row, inSection: section)
                if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is GallerySelectTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as GallerySelectTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                    self.stepFullUserDataDictionary.removeValueForKey("")
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is PromptAndAnswerTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as PromptAndAnswerTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                    self.stepFullUserDataDictionary.removeValueForKey("")
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is PickerViewTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as PickerViewTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                    self.stepFullUserDataDictionary.removeValueForKey("")
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is TextFieldInputTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as TextFieldInputTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                    self.stepFullUserDataDictionary.removeValueForKey("")
                }
                else if currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) is BoolPickerTableViewCell{
                    var cell = currentCell.canvasTableView.cellForRowAtIndexPath(cellPath) as BoolPickerTableViewCell
                    self.stepFullUserDataDictionary += cell.collectData()
                    self.stepFullUserDataDictionary.removeValueForKey("")
                }
            }
        }
        var indexPath:NSIndexPath = self.currentChallengesCardsCollectionView.indexPathForCell(cells[0] as ChallengesTabCollectionViewCell)!
        var itemNumber = indexPath.item
        var currentChallengeObject:PFObject = currentChallengesObjects[itemNumber] as PFObject
        var currentStepCount = currentChallengeObject["currentStepCount"] as Int
        var currentChallengeModel = currentChallengeObject["challenge"] as PFObject
        if currentStepCount > 0{
            if stepFullUserDataDictionary["challengeTrack"] != nil{
                currentChallengeObject["challengeTrackNumber"] = stepFullUserDataDictionary["challengeTrack"]
            }
            var dictionary:[String] = []
            for (key, value) in stepFullUserDataDictionary{
                dictionary.append(key)
                dictionary.append(value)
            }
            dictionary.filter{$0 != ""}
            var stepContent:[[String]] = currentChallengeObject["stepContent"] as [[String]]
    //        stepContent[currentStepCount].removeAll(keepCapacity: false)
    //        stepContent[currentStepCount] = dictionary
            stepContent.append(dictionary)
            currentChallengeObject["stepContent"] = stepContent
        }
        if currentStepCount < currentChallengeModel["stepTitle"].count{
            currentChallengeObject["currentStepCount"] = ++currentStepCount
            currentChallengeObject.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
                if error == nil{
                    currentCell.canvasTableView.reloadData()
                    var currentStepTitles:[String] = currentChallengeModel["stepTitle"] as [String]
                    var currentStepTitle:String = currentStepTitles[currentStepCount - 1]
                    var subtitleString:String = "Step \(currentStepCount): \(currentStepTitle)"
                    self.stepFullUserDataDictionary.removeAll(keepCapacity:true)
                    currentCell.countofCellTypeDictionary.removeAll(keepCapacity: true)
                    currentCell.subtitleLabel.text = subtitleString
                }
            }
        }
        else{
            let date = NSDate()
//            let calendar = NSCalendar.currentCalendar()
//            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
//            let hour = components.hour
//            let minutes = components.minute
            currentChallengeObject["isCurrent"] = false
            currentChallengeObject["completedDate"] = date
            currentChallengeObject.saveInBackgroundWithBlock{(succeeded: Bool!, error: NSError!) -> Void in
                if error == nil{
                    self.loadCurrentChallenges()
                    // Challenge Completed, show message
                }
            }

        }
    }

    func returnCurrentChallengesObjects() -> [AnyObject]{
        return self.currentChallengesObjects
    }

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
    
    func presentWebView(url: NSURL) {
        var webView = WebViewViewController()
        webView.url = url
        var newViewController = UINavigationController(rootViewController: webView)
        newViewController?.setToolbarHidden(false, animated: true)
        self.presentViewController(newViewController!, animated: true, completion: nil)
    }
    
}


func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {     for (k, v) in right {         left.updateValue(v, forKey: k)     } }