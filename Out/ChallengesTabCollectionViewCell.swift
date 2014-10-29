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
    let canvasTableView:TPKeyboardAvoidingTableView!
    let nextStepButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let cardInset:CGFloat = 20
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengeModel:PFObject!
    var currentChallengeData:PFObject!
    var contentDictionary:[[String:String]]!
    var tempString = ""
    var countofCellTypeDictionary:[String:[Int]] = ["":[0]]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.canvasTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.canvasTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.canvasTableView.showsVerticalScrollIndicator = true
        self.canvasTableView.registerClass(MediaAvailabilityTableViewCell.self, forCellReuseIdentifier: "MediaAvailabilityTableViewCell")
        self.canvasTableView.registerClass(TextBlockTableViewCell.self, forCellReuseIdentifier: "TextBlockTableViewCell")
        self.canvasTableView.registerClass(GallerySelectTableViewCell.self, forCellReuseIdentifier: "GallerySelectTableViewCell")
        self.canvasTableView.registerClass(ChallengeOverviewTableViewCell.self, forCellReuseIdentifier: "ChallengeOverviewTableViewCell")
        self.canvasTableView.registerClass(GallerySelectTableViewCell.self, forCellReuseIdentifier: "GallerySelectTableViewCell")
        self.canvasTableView.registerClass(PromptAndAnswerTableViewCell.self, forCellReuseIdentifier: "PromptAndAnswerTableViewCell")
        self.canvasTableView.registerClass(PickerViewTableViewCell.self, forCellReuseIdentifier: "PickerViewTableViewCell")
        self.canvasTableView.registerClass(FieldsAndActivatorTableViewCell.self, forCellReuseIdentifier: "FieldsAndActivatorTableViewCell")
        self.canvasTableView.registerClass(LaunchWebViewTableViewCell.self, forCellReuseIdentifier: "LaunchWebViewTableViewCell")
        self.canvasTableView.registerClass(EventInfoTableViewCell.self, forCellReuseIdentifier: "EventInfoTableViewCell")
        self.canvasTableView.registerClass(CallTableViewCell.self, forCellReuseIdentifier: "CallTableViewCell")
        self.canvasTableView.registerClass(HeroImageTableViewCell.self, forCellReuseIdentifier: "HeroImageTableViewCell")
        self.canvasTableView.registerClass(BoolPickerTableViewCell.self, forCellReuseIdentifier: "BoolPickerTableViewCell")
        self.canvasTableView.registerClass(CautionTextTableViewCell.self, forCellReuseIdentifier: "CautionTextTableViewCell")
        self.canvasTableView.registerClass(TextFieldInputTableViewCell.self, forCellReuseIdentifier: "TextFieldInputTableViewCell")
        self.canvasTableView.separatorStyle = UITableViewCellSeparatorStyle.None
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
        
        self.titleLabel = UILabel(frame:CGRectZero)
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(titleLabel)
        
        self.titleSeparator = UIView(frame:CGRectZero)
        self.titleSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleSeparator.backgroundColor = UIColor.blackColor()
        contentView.addSubview(titleSeparator)
        

        self.subtitleLabel = UILabel(frame:CGRectZero)
        self.subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.subtitleLabel.font = UIFont.systemFontOfSize(15.0)
        self.subtitleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(subtitleLabel)
        
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
        var metricsDictionary = ["cardInset":cardInset, "contentWidth":(self.bounds.size.width - cardInset * 2.0), "bottomCardInset": cardInset - 6]
        
        var horizontalTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleSeparator(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalSubtitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[subtitleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalCanvasConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[canvasTableView(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var horizontalButtonConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[nextStepButton(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-cardInset-[titleLabel(==24)]-0-[titleSeparator(==2)]-4-[subtitleLabel]-<=14-[canvasTableView]-<=10-[nextStepButton(>=40)]-bottomCardInset-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
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
        var challengeTrackNumber = currentChallengeData["challengeTrackNumber"] as String
        var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
        
        if self.countofCellTypeDictionary[currentCellType] == nil{
            self.countofCellTypeDictionary.updateValue([indexPath.row], forKey: currentCellType)
        }
        else if !contains(self.countofCellTypeDictionary[currentCellType] as [Int]!, indexPath.row){
            self.countofCellTypeDictionary[currentCellType]?.append(indexPath.row)
        }
        
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
                    else if key.hasPrefix("type"){
                        cell.itemType = value
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
            
            return cell
        }
            
        else if currentCellType == "mediaAvailability"{
            var cell:MediaAvailabilityTableViewCell = tableView.dequeueReusableCellWithIdentifier("MediaAvailabilityTableViewCell") as MediaAvailabilityTableViewCell
            cell.mediaTitle.text = contentDictionary[currentStepCount]["mediaTitle\(challengeTrackNumber)"]
            cell.mediaTimes.text = contentDictionary[currentStepCount]["mediaTimes\(challengeTrackNumber)"]
            cell.mediaVenue.text = contentDictionary[currentStepCount]["mediaVenue\(challengeTrackNumber)"]
            cell.mediaPreview.image = UIImage(named: contentDictionary[currentStepCount]["mediaPreview\(challengeTrackNumber)"]!)
            return cell
        }
            
        else if currentCellType == "textBlock"{
            var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
            cell.textBlock.text = contentDictionary[currentStepCount]["blockText\(challengeTrackNumber)"]
            return cell
        }
            
            
        else if currentCellType == "promptAndAnswer"{
            
            var challengeTrackNumber = currentChallengeData["challengeTrackNumber"] as String
            
            var cell:PromptAndAnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("PromptAndAnswerTableViewCell") as PromptAndAnswerTableViewCell
            
            cell.prompt1.text = contentDictionary[currentStepCount]["prompt\(challengeTrackNumber)-1"]
            cell.prompt2.text = contentDictionary[currentStepCount]["prompt\(challengeTrackNumber)-2"]
            
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
            return cell
        }
        else if currentCellType == "valuePicker"{
            var cell:PickerViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("PickerViewTableViewCell") as PickerViewTableViewCell
            var rowNumbers:[Int] = self.countofCellTypeDictionary["valuePicker"]!
            var count:Int = find(rowNumbers, indexPath.row)!
            ++count
            var valuesString = contentDictionary[currentStepCount]["picker\(count)Values"]
            var arrayOfValuesStrings = valuesString?.componentsSeparatedByString("--")
            cell.values = arrayOfValuesStrings
            cell.key = contentDictionary[currentStepCount]["picker\(count)Key"]
            return cell
        }
        else if currentCellType == "fieldsAndActivator"{
            var cell:FieldsAndActivatorTableViewCell = tableView.dequeueReusableCellWithIdentifier("FieldsAndActivatorTableViewCell") as FieldsAndActivatorTableViewCell
            var rowNumbers:[Int] = self.countofCellTypeDictionary["fieldsAndActivator"]!
            var count:Int = find(rowNumbers, indexPath.row)!
            ++count
            cell.fieldTitle.text = contentDictionary[currentStepCount]["picker\(count)Title"]
            cell.fieldValuePlaceholder.text = contentDictionary[currentStepCount]["picker\(count)ValuePlaceholder"]
            var tapRecognizer = UITapGestureRecognizer(target: self, action: "showHidePickerView:")
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        }
        else if currentCellType == "launchWebView"{
            var cell:LaunchWebViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("LaunchWebViewTableViewCell") as LaunchWebViewTableViewCell
            cell.fieldTitle.text = "HRC"
            cell.fieldValue.text = "www.hrc.org"
            var tapRecognizer = UITapGestureRecognizer(target: self, action: "launchWebView:")
            return cell
        }
        else if currentCellType == "eventInfo"{
            var cell:EventInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("EventInfoTableViewCell") as EventInfoTableViewCell
            cell.eventTitle.text = contentDictionary[currentStepCount]["eventTitle\(challengeTrackNumber)"]
            cell.eventVenue.text = contentDictionary[currentStepCount]["eventVenue\(challengeTrackNumber)"]
            cell.eventTimes.text = contentDictionary[currentStepCount]["eventTimes\(challengeTrackNumber)"]
            return cell
        }
        else if currentCellType == "callNumber"{
            var cell:CallTableViewCell = tableView.dequeueReusableCellWithIdentifier("CallTableViewCell") as CallTableViewCell
            cell.titleLabel.text = contentDictionary[currentStepCount]["callTitle\(challengeTrackNumber)"]
            cell.numberLabel.text = contentDictionary[currentStepCount]["callNumber\(challengeTrackNumber)"]
            var tapRecognizer = UITapGestureRecognizer(target: self, action: "dialNumber:")
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        }
        else if currentCellType == "heroImage"{
            var cell:HeroImageTableViewCell = tableView.dequeueReusableCellWithIdentifier("HeroImageTableViewCell") as HeroImageTableViewCell
            var imageString = contentDictionary[currentStepCount]["heroImage\(challengeTrackNumber)"]
            cell.heroImage.image = UIImage(named: imageString!)
            return cell
        }
        else if currentCellType == "boolPicker"{
            var cell:BoolPickerTableViewCell = tableView.dequeueReusableCellWithIdentifier("BoolPickerTableViewCell") as BoolPickerTableViewCell
            cell.titleLabel.text = contentDictionary[currentStepCount]["boolTitle\(challengeTrackNumber)"]
            return cell
        }
        else if currentCellType == "cautionText"{
            var cell:CautionTextTableViewCell = tableView.dequeueReusableCellWithIdentifier("CautionTextTableViewCell") as CautionTextTableViewCell
            cell.cautionTextLabel.text = contentDictionary[currentStepCount]["cautionText\(challengeTrackNumber)"]
            return cell
        }
        else if currentCellType == "textField"{
            var cell:TextFieldInputTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextFieldInputTableViewCell") as TextFieldInputTableViewCell
            cell.textField.placeholder = "Placeholder"
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
    
    func showHidePickerView(sender:UITapGestureRecognizer!){
        var cell:FieldsAndActivatorTableViewCell = sender.view as FieldsAndActivatorTableViewCell
        var indexPath = self.canvasTableView.indexPathForCell(cell)!
        var nextIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
        var nextCellIsExpandedCell = self.canvasTableView.cellForRowAtIndexPath(nextIndexPath) is PickerViewTableViewCell
        var indexToUpdate:Int = find(self.countofCellTypeDictionary["fieldsAndActivator"] as [Int]!,indexPath.row)!
        if nextCellIsExpandedCell{
            self.canvasTableView.beginUpdates()
            self.canvasTableView.deleteRowsAtIndexPaths([nextIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as [[String]]
            var currentStepCount = self.currentChallengeData["currentStepCount"] as Int
            self.tempString = currentCellTypeArray[currentStepCount][nextIndexPath.row]
            currentCellTypeArray[currentStepCount].removeAtIndex(nextIndexPath.row)
            self.currentChallengeModel["stepCellsType"] = currentCellTypeArray
            var currentRowNumbersArray = self.countofCellTypeDictionary["fieldsAndActivator"] as [Int]!
            var tempIndex = 0
            for rowCount in self.countofCellTypeDictionary["fieldsAndActivator"] as [Int]!{
                if rowCount > currentRowNumbersArray[indexToUpdate]{
                    currentRowNumbersArray[tempIndex] = rowCount - 1
                }
                ++tempIndex
            }
            tempIndex = 0
            self.countofCellTypeDictionary["fieldsAndActivator"] = currentRowNumbersArray
            self.canvasTableView.endUpdates()
        }
        else{
            self.canvasTableView.beginUpdates()
            var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as [[String]]
            var currentStepCount = self.currentChallengeData["currentStepCount"] as Int
            var currentCellTypes = currentCellTypeArray[currentStepCount]
            currentCellTypes.insert(tempString, atIndex: nextIndexPath.row)
            currentCellTypeArray[currentStepCount] = currentCellTypes
            self.currentChallengeModel["stepCellsType"] = currentCellTypeArray
            self.canvasTableView.insertRowsAtIndexPaths([nextIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            var currentRowNumbersArray = self.countofCellTypeDictionary["fieldsAndActivator"] as [Int]!
            var tempIndex = 0
            for rowCount in self.countofCellTypeDictionary["fieldsAndActivator"] as [Int]!{
                if rowCount > currentRowNumbersArray[indexToUpdate]{
                    currentRowNumbersArray[tempIndex] = rowCount + 1
                }
                ++tempIndex
            }
            tempIndex = 0
            self.countofCellTypeDictionary["fieldsAndActivator"] = currentRowNumbersArray
            self.canvasTableView.endUpdates()
        }
    }
    
    func dialNumber(sender:UITapGestureRecognizer!){
        var cell:CallTableViewCell = sender.view as CallTableViewCell
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cell.numberLabel.text!)")!)
    }
    
    func launchWebView(sender:UITapGestureRecognizer!){
        var cell:LaunchWebViewTableViewCell = sender.view as LaunchWebViewTableViewCell
        
    }
}


