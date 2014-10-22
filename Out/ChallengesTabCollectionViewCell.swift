//
//  ChallengesTabCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class ChallengesTabCollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Mark: UI Elements Declarations
    
    let titleLabel:UILabel!
    let titleSeparator:UIView!
    let subtitleLabel:UILabel!
    let canvasTableView:UITableView!
    let nextStepButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let cardInset:CGFloat = 20
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengeModel:PFObject!
    var currentChallengeData:PFObject!
    var test:Int = 0
    var contentDictionary:[[String:String]]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.canvasTableView = UITableView(frame: CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2 + 30 + 8, self.bounds.width - cardInset * 2, self.bounds.height - 164), style: UITableViewStyle.Plain)
        self.canvasTableView = UITableView(frame: CGRectZero)
        self.canvasTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.canvasTableView.showsVerticalScrollIndicator = true
        self.canvasTableView.registerClass(MediaAvailabilityTableViewCell.self, forCellReuseIdentifier: "MediaAvailabilityTableViewCell")
        self.canvasTableView.registerClass(TextBlockTableViewCell.self, forCellReuseIdentifier: "TextBlockTableViewCell")
        self.canvasTableView.registerClass(GallerySelectTableViewCell.self, forCellReuseIdentifier: "GallerySelectTableViewCell")
        self.canvasTableView.registerClass(ChallengeOverviewTableViewCell.self, forCellReuseIdentifier: "ChallengeOverviewTableViewCell")
        self.canvasTableView.registerClass(GallerySelectTableViewCell.self, forCellReuseIdentifier: "GallerySelectTableViewCell")
        self.canvasTableView.separatorStyle = .None
        self.canvasTableView.dataSource = self
        self.canvasTableView.delegate = self
        self.canvasTableView.rowHeight = UITableViewAutomaticDimension
        self.canvasTableView.estimatedRowHeight = 200
        
        contentView.addSubview(canvasTableView)
        
        activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.center = canvasTableView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        canvasTableView.addSubview(activityIndicator)
        
        self.backgroundColor = UIColor.whiteColor()
        
//        self.titleLabel = UILabel(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset, self.bounds.size.width - cardInset * 2, 30))
        self.titleLabel = UILabel(frame:CGRectZero)
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(titleLabel)
        
//        self.titleSeparator = UIView(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30, self.bounds.size.width - cardInset * 2, 2))
        self.titleSeparator = UIView(frame:CGRectZero)
        self.titleSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleSeparator.backgroundColor = UIColor.blackColor()
        contentView.addSubview(titleSeparator)
        

//        self.subtitleLabel = UILabel(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2, self.bounds.size.width - cardInset * 2, 30))
        self.subtitleLabel = UILabel(frame:CGRectZero)
        self.subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.subtitleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(subtitleLabel)
        
//        self.nextStepButton.frame = CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2 + 30 + 8 + (self.bounds.height - 164) + 20, self.bounds.width - cardInset * 2, 40)
        self.nextStepButton.frame = CGRectZero
        self.nextStepButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextStepButton.setTitle("Next Step", forState: UIControlState.Normal)
        self.nextStepButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.nextStepButton.titleLabel!.font = UIFont(name: "UIFontTextStyleHeadline", size: CGFloat(30.0))
        self.nextStepButton.userInteractionEnabled = true
        self.nextStepButton.layer.borderWidth = 1
        self.nextStepButton.layer.borderColor = UIColor.blackColor().CGColor
        self.nextStepButton.layer.cornerRadius = 6
        contentView.addSubview(nextStepButton)
        
        var viewsDictionary = ["canvasTableView":canvasTableView, "titleLabel":titleLabel, "titleSeparator":titleSeparator, "subtitleLabel":subtitleLabel, "nextStepButton":nextStepButton]
        var metricsDictionary = ["cardInset":cardInset, "contentWidth":(self.bounds.size.width - cardInset * 2.0), "bottomCardInset": cardInset - 4]
        
        var horizontalTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleSeparator(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalSubtitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[subtitleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalCanvasConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[canvasTableView(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalButtonConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[nextStepButton(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-cardInset-[titleLabel(==24)]-[titleSeparator(==2)]-[subtitleLabel]-<=14-[canvasTableView]-<=4-[nextStepButton(>=40)]-bottomCardInset-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        self.addConstraints(horizontalTitleConstraints)
        self.addConstraints(horizontalSeparatorConstraints)
        self.addConstraints(horizontalSubtitleConstraints)
        self.addConstraints(horizontalCanvasConstraints)
        self.addConstraints(horizontalButtonConstraints)
        self.addConstraints(verticalConstraints)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as [[String]]
        var currentStepCount = currentChallengeData["currentStepCount"] as Int
        var currentCellTypes:[String] = currentCellTypeArray[currentStepCount]
        var currentCellType = currentCellTypes[indexPath.row]
        
        var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
        
        if currentCellType == "gallerySelect"{
            
            self.canvasTableView.alwaysBounceVertical = false
            
            var cell:GallerySelectTableViewCell = tableView.dequeueReusableCellWithIdentifier("GallerySelectTableViewCell") as GallerySelectTableViewCell
            
            var itemTitles:[String] = ["","","","",""]
            var itemImages:[String] = ["","","","",""]
            var itemBlurbs:[String] = ["","","","",""]
            var indexCount = 0
            for (key, value) in contentDictionary[currentStepCount]{
                var keyPairArray:[String] = key.componentsSeparatedByString("--")
                if(keyPairArray.count == 2){
                    var indexToInsert = keyPairArray[1].toInt()! - 1
                    if key.hasPrefix("item"){
                        itemTitles[indexToInsert] = value
                    }
                    else if key.hasPrefix("image"){
                        itemImages[indexToInsert] = value
                    }
                    else if key.hasPrefix("blurb"){
                        itemBlurbs[indexToInsert] = value
                    }
                }
            }
            itemTitles = itemTitles.filter{$0 != ""}
            itemImages = itemImages.filter{$0 != ""}
            itemBlurbs = itemBlurbs.filter{$0 != ""}
            
            cell.itemTitles = itemTitles
            cell.itemImages = itemImages
            cell.itemBlurbs = itemBlurbs
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
//            var itemWidth = UIScreen.mainScreen().bounds.width - 64.0
//            var cellWidth = itemWidth * CGFloat(itemTitles.count)
//            var itemHeight = UIScreen.mainScreen().bounds.height - 331.0
//            cell.frame.size = CGSize(width: cellWidth, height: itemHeight)
//            cell.galleryCollectionView.bounds.size = cell.frame.size
            return cell
        }
            
        else if currentCellType == "mediaAvailability"{
            var cell:MediaAvailabilityTableViewCell = tableView.dequeueReusableCellWithIdentifier("MediaAvailabilityTableViewCell") as MediaAvailabilityTableViewCell
            cell.mediaTitle.text = contentDictionary[currentStepCount]["mediaTitle2"]
            cell.mediaTimes.text = contentDictionary[currentStepCount]["mediaTimes2"]
            cell.mediaVenue.text = contentDictionary[currentStepCount]["mediaVenue2"]
            cell.mediaPreview.image = UIImage(named: contentDictionary[currentStepCount]["mediaPreview2"]!)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
            
        else if currentCellType == "textBlock"{
            var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
            cell.textBlock.text = "The Normal Heart depicts the rise of the HIV-AIDS crisis in New York City (among gay people) between 1981 and 1984, as seen through the eyes of writer/activist Ned Weeks, the founder of a prominent HIV advocacy group. Weeks prefers public confrontations to the calmer, more private strategies favored by his associates, friends, and closeted lover Felix Turner (Bomer). Their differences of opinion lead to arguments that threaten to undermine their shared goals."
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
            
            
        else if currentCellType == "promptAndAnswer"{
            var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
            cell.textBlock.text = "The Normal Heart depicts the rise of the HIV-AIDS crisis in New York City (among gay people) between 1981 and 1984, as seen through the eyes of writer/activist Ned Weeks, the founder of a prominent HIV advocacy group. Weeks prefers public confrontations to the calmer, more private strategies favored by his associates, friends, and closeted lover Felix Turner (Bomer). Their differences of opinion lead to arguments that threaten to undermine their shared goals."
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if currentCellType == "challengeOverview"{
            var cell:ChallengeOverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChallengeOverviewTableViewCell") as ChallengeOverviewTableViewCell
            
            cell.challengeIntro.text = contentDictionary[currentStepCount]["challengeIntro"]
            
            var stepTitlesArray:[String] = self.currentChallengeModel["stepTitle"] as [String]
            var stepTitles = ""
            var stepCount = 1
            for stepTitle in stepTitlesArray{
                stepTitles += "Step \(stepCount): \(stepTitlesArray[stepCount - 1]) \n"
                ++stepCount
            }
            cell.stepTitles.text = stepTitles
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as [[String]]
        var currentStepCount = self.currentChallengeData["currentStepCount"] as Int
        if currentStepCount == 0{
            return 1
        }
        else{
            return currentCellTypeArray[currentStepCount].count
        }
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func loadCurrentChallenges(objectId:String){
        self.canvasTableView.hidden = true
        self.activityIndicator.startAnimating()
        var queryCurrentChallenge = PFQuery(className:"Challenge")
        queryCurrentChallenge.whereKey("objectId", equalTo:objectId)
        queryCurrentChallenge.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                self.currentChallengeModel = objects[0] as PFObject
                self.canvasTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.canvasTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
