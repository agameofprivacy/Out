//
//  ChallengesTabCollectionViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/7/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import Realm

let reuseIdentifier = "Cell"

class ChallengesTabCollectionViewController: UICollectionViewController {

    
    @IBOutlet weak var challengesCardNumPageControl: UIPageControl!

    var currentChallengesObjects:[PFObject] = []
    var currentChallenges:[Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.loadCurrentChallenges()
        challengesCardNumPageControl.numberOfPages = self.currentChallenges.count
        challengesCardNumPageControl.currentPage = 0
    }

//    override func viewDidAppear(animated: Bool) {
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return currentChallenges.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCard", forIndexPath: indexPath) as ChallengeCardCollectionViewCell
        
        // Configure the cell
        cell.cardLabel.text = self.currentChallenges[indexPath.item].title
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.3).CGColor

        challengesCardNumPageControl.currentPage = indexPath.item

        return cell
    }

    @IBAction func addChallengeBarButtonItemTapped(sender: UIBarButtonItem) {
        println("Add Challenge")
    }
    
    func loadCurrentChallenges() {
        let predicate = NSPredicate(format:"isCurrent = true AND alias = 'agameofprivacy'")
        var query = PFQuery(className:"UserChallengeData", predicate:predicate)
        // Do any additional setup after loading the view.
        currentChallengesObjects = query.findObjects() as [PFObject]
        for object in currentChallengesObjects {
            var challenge = Challenge(title: object["title"] as String)
            self.currentChallenges += [challenge]
            println(self.currentChallenges[0].title)
        }
    }

}