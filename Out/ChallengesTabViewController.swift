//
//  ChallengesTabViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengesTabViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate{
    
    var currentChallengesCardsCollectionView: UICollectionView!
    var cardNumberPageControl: UIPageControl!
    let layout = ChallengeCardsCollectionViewFlowLayout()
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengesObjects:[AnyObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentChallengesCardsCollectionView = UICollectionView(frame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        
        currentChallengesCardsCollectionView.collectionViewLayout = layout
        currentChallengesCardsCollectionView.delegate = self
        currentChallengesCardsCollectionView.dataSource = self
        currentChallengesCardsCollectionView.pagingEnabled = true
        layout.itemSize = CGSizeMake(self.view.frame.size.width - 24.0, self.view.frame.size.height - 167)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        currentChallengesCardsCollectionView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
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
        loadCurrentChallenges()
        
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
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor

        var challengeModel = self.currentChallengesObjects[indexPath.item]["challenge"] as PFObject
        var currentChallengeData = self.currentChallengesObjects[indexPath.item] as PFObject
        cell.currentChallengeModel = challengeModel
        cell.currentChallengeData = currentChallengeData
        cell.titleLabel.text = self.currentChallengesObjects[indexPath.item]["title"] as String?
        cell.nextStepButton.addTarget(self, action: "nextStepButtonTapped:", forControlEvents: .TouchUpInside)
        var reason = challengeModel["reason"] as [String]
        var subtitleString = reason[0] + ": " + reason[1]
        cell.subtitleLabel.text = subtitleString
        

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
        var indexPath:NSIndexPath = self.currentChallengesCardsCollectionView.indexPathForCell(cells[0] as ChallengesTabCollectionViewCell)!
        var itemNumber = indexPath.item
        println(itemNumber)
        println(currentChallengesObjects[itemNumber]["title"] as String)
    }

    func returnCurrentChallengesObjects() -> [AnyObject]{
        return self.currentChallengesObjects
    }
    
}
