//
//  ChallengesTabCollectionViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/15/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import Parse
protocol PresentNewView{

    func presentWebView(url:NSURL)
}

// Challenges tab collection view cell view
class ChallengesTabCollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {

    
    var titleLabel:UILabel!
    var titleSeparator:UIView!
    var subtitleLabel:UILabel!
    var canvasTableView:TPKeyboardAvoidingTableView!
    var nextStepButton: UIButton = UIButton(type: UIButtonType.System)
    let cardInset:CGFloat = 20
    var activityIndicator: UIActivityIndicatorView!
    var currentChallengeModel:PFObject!
    var currentChallengeData:PFObject!
    var contentDictionary:[[String:String]]!
    var tempString = ""
    var countofCellTypeDictionary:[String:[Int]] = ["":[0]]
    var shownHiddenRows:[NSIndexPath] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        // Collection view cell (card) edge styling
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 1
        
        // canvas table view init
        self.canvasTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.canvasTableView.translatesAutoresizingMaskIntoConstraints = false
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
        self.canvasTableView.estimatedRowHeight = 90
        contentView.addSubview(canvasTableView)
        
        activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.center = canvasTableView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        canvasTableView.addSubview(activityIndicator)
        
        self.titleLabel = UILabel(frame:CGRectZero)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(titleLabel)
        
        self.titleSeparator = UIView(frame:CGRectZero)
        self.titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.titleSeparator.backgroundColor = UIColor.blackColor()
        contentView.addSubview(titleSeparator)
        
        self.subtitleLabel = UILabel(frame:CGRectZero)
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.subtitleLabel.font = UIFont.systemFontOfSize(15.0)
        self.subtitleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(subtitleLabel)
        
        self.nextStepButton.frame = CGRectZero
        self.nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextStepButton.setTitle("Next Step", forState: UIControlState.Normal)
        self.nextStepButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.nextStepButton.titleLabel!.font = UIFont(name: "UIFontTextStyleHeadline", size: CGFloat(30.0))
        self.nextStepButton.userInteractionEnabled = true
        self.nextStepButton.layer.borderWidth = 1
        self.nextStepButton.layer.borderColor = UIColor.blackColor().CGColor
        self.nextStepButton.layer.cornerRadius = 5
        contentView.addSubview(nextStepButton)
        
        // Card layout
        let viewsDictionary = ["canvasTableView":canvasTableView, "titleLabel":titleLabel, "titleSeparator":titleSeparator, "subtitleLabel":subtitleLabel, "nextStepButton":nextStepButton]
        let metricsDictionary = ["cardInset":cardInset, "contentWidth":(self.bounds.size.width - cardInset * 2.0), "bottomCardInset": cardInset - 6]
        
        let horizontalTitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[titleSeparator(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalSubtitleConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[subtitleLabel(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalCanvasConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[canvasTableView(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let horizontalButtonConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-cardInset-[nextStepButton(==contentWidth)]-cardInset-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metricsDictionary, views: viewsDictionary)
        let verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-cardInset-[titleLabel(==24)]-0-[titleSeparator(==2)]-4-[subtitleLabel]-<=14-[canvasTableView]-<=10-[nextStepButton(>=40)]-bottomCardInset-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllLeft], metrics: metricsDictionary, views: viewsDictionary)
        
        self.addConstraints(horizontalTitleConstraints)
        self.addConstraints(horizontalSeparatorConstraints)
        self.addConstraints(horizontalSubtitleConstraints)
        self.addConstraints(horizontalCanvasConstraints)
        self.addConstraints(horizontalButtonConstraints)
        self.addConstraints(verticalConstraints)
    }
    
    // Table view data source method for canvas table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as! [[String]]
        let currentStepCount = currentChallengeData["currentStepCount"] as! Int
        var currentCellTypes:[String] = currentCellTypeArray[currentStepCount]
        let currentCellType = currentCellTypes[indexPath.row]
        var challengeTrackNumber = currentChallengeData["challengeTrackNumber"] as! String
        if challengeTrackNumber == "0"{
            challengeTrackNumber = "\(Int(challengeTrackNumber)! + 1)"
        }
        let cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as! TextBlockTableViewCell
        
        if self.countofCellTypeDictionary[currentCellType] == nil{
            self.countofCellTypeDictionary.updateValue([indexPath.row], forKey: currentCellType)
        }
        else if !(self.countofCellTypeDictionary[currentCellType] as [Int]!).contains(indexPath.row){
            self.countofCellTypeDictionary[currentCellType]?.append(indexPath.row)
        }
        
        // If current cell type is selection gallery
        if currentCellType == "gallerySelect"{
            self.canvasTableView.alwaysBounceVertical = false
            let cell:GallerySelectTableViewCell = tableView.dequeueReusableCellWithIdentifier("GallerySelectTableViewCell") as! GallerySelectTableViewCell

            var itemTitles:[String] = ["","","","",""]
            var itemImages:[String] = ["","","","",""]
            var itemBlurbs:[String] = ["","","","",""]
//            let indexCount = 0
            
            for (key, value) in contentDictionary[currentStepCount]{
                var keyPairArray:[String] = key.componentsSeparatedByString("--")
                if(keyPairArray.count == 2){
                    let indexToInsert = Int(keyPairArray[1])! - 1
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
            cell.galleryCollectionView.reloadData()

            return cell
        }
            
        // If current cell type is media availability
        else if currentCellType == "mediaAvailability"{
          let cell:MediaAvailabilityTableViewCell = tableView.dequeueReusableCellWithIdentifier("MediaAvailabilityTableViewCell") as! MediaAvailabilityTableViewCell
            cell.mediaTitle.text = contentDictionary[currentStepCount]["mediaTitle\(challengeTrackNumber)"]
            cell.mediaTimes.text = contentDictionary[currentStepCount]["mediaTimes\(challengeTrackNumber)"]
            cell.mediaVenue.text = contentDictionary[currentStepCount]["mediaVenue\(challengeTrackNumber)"]
            cell.mediaPreview.image = UIImage(named: contentDictionary[currentStepCount]["mediaPreview\(challengeTrackNumber)"]!)
            return cell
        }
            
        // If current cell type is text block
        else if currentCellType == "textBlock"{
            let cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as! TextBlockTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["textBlock"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.textBlock.text = contentDictionary[currentStepCount]["block\(count)Text\(challengeTrackNumber)"]
            return cell
        }
            
        // If current cell type is prompt and answer
        else if currentCellType == "promptAndAnswer"{
            
            let challengeTrackNumber = currentChallengeData["challengeTrackNumber"] as! String
            
            let cell:PromptAndAnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("PromptAndAnswerTableViewCell") as! PromptAndAnswerTableViewCell
            
            cell.prompt1.text = contentDictionary[currentStepCount]["prompt1-\(challengeTrackNumber)"]
            cell.prompt2.text = contentDictionary[currentStepCount]["prompt2-\(challengeTrackNumber)"]
            
            return cell
        }
            
        // If current cell type is challenge overview
        else if currentCellType == "challengeOverview"{
            let cell:ChallengeOverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChallengeOverviewTableViewCell") as! ChallengeOverviewTableViewCell
            
            cell.challengeIntro.text = contentDictionary[currentStepCount]["challengeIntro"]
            
            var stepTitlesArray:[String] = self.currentChallengeModel["stepTitle"] as! [String]
            var stepTitles = ""
            var stepCount = 1
            for _ in stepTitlesArray{
                stepTitles += "Step \(stepCount): \(stepTitlesArray[stepCount - 1]) \n"
                ++stepCount
            }
            cell.stepTitles.text = stepTitles
            return cell
        }
            
        // If current cell type is value picker
        else if currentCellType == "valuePicker"{
            let cell:PickerViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("PickerViewTableViewCell") as! PickerViewTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["valuePicker"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            let valuesString = contentDictionary[currentStepCount]["picker\(count)Values\(challengeTrackNumber)"]
            let arrayOfValuesStrings = valuesString?.componentsSeparatedByString("--")
            cell.values = arrayOfValuesStrings
            cell.key = contentDictionary[currentStepCount]["picker\(count)Key"]
            cell.pickerView.selectRow(2, inComponent: 0, animated: true)
            return cell
        }
            
        // If current cell type is fields and activator
        else if currentCellType == "fieldsAndActivator"{
            let cell:FieldsAndActivatorTableViewCell = tableView.dequeueReusableCellWithIdentifier("FieldsAndActivatorTableViewCell") as! FieldsAndActivatorTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["fieldsAndActivator"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.fieldTitle.text = contentDictionary[currentStepCount]["activator\(count)Title"]
            cell.fieldValuePlaceholder.text = contentDictionary[currentStepCount]["activator\(count)ValuePlaceholder"]
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "showHidePickerView:")
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        }
            
        // If current cell type is launch web view
        else if currentCellType == "launchWebView"{
            let cell:LaunchWebViewTableViewCell = tableView.dequeueReusableCellWithIdentifier("LaunchWebViewTableViewCell") as! LaunchWebViewTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["launchWebView"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            let urlString = contentDictionary[currentStepCount]["launch\(count)URL\(challengeTrackNumber)"]
            cell.launchURL = NSURL(string: urlString!)
            cell.fieldTitle.text = contentDictionary[currentStepCount]["field\(count)Title\(challengeTrackNumber)"]
            cell.fieldValue.text = contentDictionary[currentStepCount]["field\(count)Value\(challengeTrackNumber)"]
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "launchWebView:")
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        }

        // If current cell type is event info
        else if currentCellType == "eventInfo"{
            let cell:EventInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("EventInfoTableViewCell") as! EventInfoTableViewCell
            cell.eventTitle.text = contentDictionary[currentStepCount]["eventTitle\(challengeTrackNumber)"]
            cell.eventTimes.text = contentDictionary[currentStepCount]["eventTimes\(challengeTrackNumber)"]
            cell.eventVenue.text = contentDictionary[currentStepCount]["eventVenue\(challengeTrackNumber)"]
            return cell
        }
            
        // If current cell type is call number
        else if currentCellType == "callNumber"{
            let cell:CallTableViewCell = tableView.dequeueReusableCellWithIdentifier("CallTableViewCell") as! CallTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["callNumber"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.titleLabel.text = contentDictionary[currentStepCount]["call\(count)Title\(challengeTrackNumber)"]
            cell.numberLabel.text = contentDictionary[currentStepCount]["call\(count)Number\(challengeTrackNumber)"]
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "dialNumber:")
            cell.addGestureRecognizer(tapRecognizer)
            return cell
        }
            
        // If current cell type is hero image
        else if currentCellType == "heroImage"{
            let cell:HeroImageTableViewCell = tableView.dequeueReusableCellWithIdentifier("HeroImageTableViewCell") as! HeroImageTableViewCell
            let imageString = contentDictionary[currentStepCount]["heroImage\(challengeTrackNumber)"]
            cell.heroImage.image = UIImage(named: imageString!)
            return cell
        }
            
        // If current cell type is bool picker
        else if currentCellType == "boolPicker"{
            let cell:BoolPickerTableViewCell = tableView.dequeueReusableCellWithIdentifier("BoolPickerTableViewCell") as! BoolPickerTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["boolPicker"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.titleLabel.text = contentDictionary[currentStepCount]["bool\(count)Title\(challengeTrackNumber)"]
            cell.key = contentDictionary[currentStepCount]["bool\(count)Title\(challengeTrackNumber)"]
            return cell
        }
            
        // If current cell type is caution text
        else if currentCellType == "cautionText"{
            let cell:CautionTextTableViewCell = tableView.dequeueReusableCellWithIdentifier("CautionTextTableViewCell") as! CautionTextTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["cautionText"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.cautionTextLabel.text = contentDictionary[currentStepCount]["caution\(count)Text\(challengeTrackNumber)"]

            return cell
        }
            
        // If current cell type is text field
        else if currentCellType == "textField"{
            let cell:TextFieldInputTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextFieldInputTableViewCell") as! TextFieldInputTableViewCell
            let rowNumbers:[Int] = self.countofCellTypeDictionary["textField"]!
            var count:Int = rowNumbers.indexOf(indexPath.row)!
            ++count
            cell.textField.placeholder = contentDictionary[currentStepCount]["formField\(count)Placeholder\(challengeTrackNumber)"]
            cell.key = contentDictionary[currentStepCount]["formField\(count)Placeholder\(challengeTrackNumber)"]
            return cell
        }
        
        return cell
    }
    
    // Table view data source method for canvas table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as! [[String]]
        let currentStepCount = self.currentChallengeData["currentStepCount"] as! Int
        if currentStepCount == 0{
            return 1
        }
        else{
            return currentCellTypeArray[currentStepCount].count
        }
    }
    
    
    // Table view data source for canvas table view's value picker rows
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentCellTypeArray:[[String]] = self.currentChallengeModel["stepCellsType"] as! [[String]]
        let currentStepCount = currentChallengeData["currentStepCount"] as! Int
        var currentCellTypes:[String] = currentCellTypeArray[currentStepCount]
        let currentCellType = currentCellTypes[indexPath.row]
        if currentCellType == "valuePicker" && !shownHiddenRows.contains(indexPath){
            return 1
        }
        else if currentCellType == "valuePicker" && shownHiddenRows.contains(indexPath){
            return UITableViewAutomaticDimension
        }
        else{
        return UITableViewAutomaticDimension
        }
    }
    
    // Load current challenges
    func loadCurrentChallenges(objectId:String){
        self.canvasTableView.hidden = true
        self.activityIndicator.startAnimating()
        let queryCurrentChallenge = PFQuery(className:"Challenge")
        queryCurrentChallenge.whereKey("objectId", equalTo:objectId)
        queryCurrentChallenge.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                // The find succeeded.
                self.currentChallengeModel = objects![0]
                self.canvasTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.canvasTableView.hidden = false
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
    }
    

    // Expand and collapse field rows of fieldsAndActivator
    func showHidePickerView(sender:UITapGestureRecognizer!){

        self.canvasTableView.beginUpdates()

        let cell:FieldsAndActivatorTableViewCell = sender.view as! FieldsAndActivatorTableViewCell
        let indexPath = self.canvasTableView.indexPathForCell(cell)!
        let nextIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
        let pickerCell:PickerViewTableViewCell = self.canvasTableView.cellForRowAtIndexPath(nextIndexPath) as! PickerViewTableViewCell
        
        if shownHiddenRows.contains(nextIndexPath){
            let indexToRemove = shownHiddenRows.indexOf(nextIndexPath)
            self.shownHiddenRows.removeAtIndex(indexToRemove!)
            pickerCell.pickerView.hidden = true
            cell.fieldValuePlaceholder.text = pickerCell.values[pickerCell.pickerView.selectedRowInComponent(0)]
        }
        else if !shownHiddenRows.contains(nextIndexPath){
            self.shownHiddenRows.append(nextIndexPath)
            pickerCell.pickerView.hidden = false
            cell.fieldValuePlaceholder.text = "tap to confirm"
        }

        self.canvasTableView.endUpdates()
    }
    
    
    // Dial number from cell using phone.app
    func dialNumber(sender:UITapGestureRecognizer!){
        let cell:CallTableViewCell = sender.view as! CallTableViewCell
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cell.numberLabel.text!)")!)
    }
    
    // Launch web view with URL from cell
    func launchWebView(sender:UITapGestureRecognizer!){
        let cell:LaunchWebViewTableViewCell = sender.view as! LaunchWebViewTableViewCell
        let collectionView = self.superview as! UICollectionView
        let baseClass = collectionView.delegate as! ChallengesTabViewController
//        let urlFromCell = cell.fieldValue.text
        let urlObject = cell.launchURL
        baseClass.presentWebView(urlObject!)
    }
    

}


