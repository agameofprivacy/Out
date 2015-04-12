//
//  ActivityExpandedTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 3/25/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class ActivityExpandedTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate {

    var parentVC:ActivityTabViewController!
    var activity:PFObject!
    var challenge:PFObject!
    var userChallengeData:PFObject!
    var user:PFUser!
    var challengeTrackNumber:Int!
    var comments:[PFObject] = []
    var selectedSegment:String!
    
    
    var activityHeader:UIView!
    var avatarImageView:UIImageView!
    var actionTextView:UITextView!
    var bottomSeparatorView:UIView!

    var segmentedControlView:UIView!
    var expandedViewSegmentedControl:UISegmentedControl!
    
    var detailsTableView:TPKeyboardAvoidingTableView!
    var commentsTableView:CommentsViewController!
    var moreTableView:TPKeyboardAvoidingTableView!
    
    let colorDictionary =
    [
        "orange":UIColor(red: 255/255, green: 97/255, blue: 27/255, alpha: 1),
        "brown":UIColor(red: 139/255, green: 87/255, blue: 42/255, alpha: 1),
        "teal":UIColor(red: 34/255, green: 200/255, blue: 165/255, alpha: 1),
        "purple":UIColor(red: 140/255, green: 76/255, blue: 233/255, alpha: 1),
        "pink":UIColor(red: 252/255, green: 52/255, blue: 106/255, alpha: 1),
        "lightBlue":UIColor(red: 30/255, green: 169/255, blue: 238/255, alpha: 1),
        "yellowGreen":UIColor(red: 211/255, green: 206/255, blue: 52/255, alpha: 1),
        "vibrantBlue":UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1),
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    ]
    
    let avatarImageDictionary =
    [
        "elephant":UIImage(named: "elephant-icon"),
        "snake":UIImage(named: "snake-icon"),
        "butterfly":UIImage(named: "butterfly-icon"),
        "snail":UIImage(named: "snail-icon"),
        "horse":UIImage(named: "horse-icon"),
        "bird":UIImage(named: "bird-icon"),
        "turtle":UIImage(named: "turtle-icon"),
        "sheep":UIImage(named: "sheep-icon"),
        "bear":UIImage(named: "bear-icon"),
        "littleBird":UIImage(named: "littleBird-icon"),
        "dog":UIImage(named: "dog-icon"),
        "rabbit":UIImage(named: "rabbit-icon"),
        "caterpillar":UIImage(named: "caterpillar-icon"),
        "crab":UIImage(named: "crab-icon"),
        "fish":UIImage(named: "fish-icon"),
        "cat":UIImage(named: "cat-icon")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "Activity"

        self.detailsTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.detailsTableView.rowHeight = UITableViewAutomaticDimension
//        self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.detailsTableView.backgroundColor = UIColor.clearColor()
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        self.detailsTableView.contentInset.top = 127
        self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.detailsTableView.registerClass(StepTitleTableViewCell.self, forCellReuseIdentifier: "StepTitleTableViewCell")
        self.detailsTableView.registerClass(StepBlurbTableViewCell.self, forCellReuseIdentifier: "StepBlurbTableViewCell")
        self.detailsTableView.registerClass(StepMediaTableViewCell.self, forCellReuseIdentifier: "StepMediaTableViewCell")
        self.detailsTableView.rowHeight = UITableViewAutomaticDimension
        self.detailsTableView.estimatedRowHeight = 64
        self.detailsTableView.hidden = true
        self.view.addSubview(self.detailsTableView)
        
        self.commentsTableView = CommentsViewController(tableViewStyle: UITableViewStyle.Plain)
        self.commentsTableView.activity = self.activity
        self.commentsTableView.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 49.5)
        self.commentsTableView.tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        self.commentsTableView.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.commentsTableView.tableView.contentInset.bottom = 191
        self.commentsTableView.view.hidden = true
        self.view.addSubview(self.commentsTableView.view)

        
        self.moreTableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.moreTableView.backgroundColor = UIColor.clearColor()
        self.moreTableView.contentInset.top = 191
        self.moreTableView.contentInset.bottom = 49.5
        self.moreTableView.delegate = self
        self.moreTableView.dataSource = self
        self.moreTableView.hidden = true

        self.view.addSubview(self.moreTableView)
        
        self.activityHeader = UIView(frame: CGRectZero)
        self.activityHeader.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.activityHeader.backgroundColor = UIColor(white: 1, alpha: 1)
        self.view.addSubview(self.activityHeader)

        self.segmentedControlView = UIView(frame: CGRectZero)
        self.segmentedControlView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.segmentedControlView.backgroundColor = UIColor(white: 1, alpha: 1)
        self.view.addSubview(self.segmentedControlView)
        
        var baseViewDictionary = ["activityHeader":self.activityHeader, "segmentedControlView":self.segmentedControlView]
        var baseMetricsDictionary = ["topMargin":64]
        
        var baseHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[activityHeader]|", options: NSLayoutFormatOptions(0), metrics: baseMetricsDictionary, views: baseViewDictionary)
        var baseVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topMargin-[activityHeader]-0-[segmentedControlView]", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: baseMetricsDictionary, views: baseViewDictionary)
        
        self.view.addConstraints(baseHorizontalConstraints)
        self.view.addConstraints(baseVerticalConstraints)

        self.bottomSeparatorView = UIView(frame: CGRectZero)
        self.bottomSeparatorView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomSeparatorView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        self.activityHeader.addSubview(self.bottomSeparatorView)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.backgroundColor = UIColor.whiteColor()
        self.avatarImageView.image = UIImage(named: "avatarImagePlaceholder")
        self.avatarImageView.opaque = true
        self.activityHeader.addSubview(self.avatarImageView)
        
        self.actionTextView = UITextView(frame: CGRectZero)
        self.actionTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.actionTextView.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        self.actionTextView.backgroundColor = UIColor.clearColor()
        self.actionTextView.editable = false
        self.actionTextView.scrollEnabled = false
        self.actionTextView.selectable = false
        self.actionTextView.textAlignment = NSTextAlignment.Justified
        var textViewTappedGestureRecognizer = UITapGestureRecognizer(target: self, action: "textViewTapped:")
        self.actionTextView.addGestureRecognizer(textViewTappedGestureRecognizer)
        self.activityHeader.addSubview(actionTextView)
        
        var narrativeActionString = (self.challenge["narrativeAction"] as! String)
        var narrativeTitleString:String
        var challengeTitleString = (self.challenge["title"] as! String)
        var prepositionBeforeChallengeString = " in "
        var actionString:String

        if !(self.challenge["narrativeTitles"] as! [String]).isEmpty{
            narrativeTitleString = (self.challenge["narrativeTitles"] as! [String])[self.challengeTrackNumber]
            actionString = self.user.username + " " + narrativeActionString + " " + narrativeTitleString + prepositionBeforeChallengeString + challengeTitleString + "."
        }
        else{
            narrativeTitleString = ""
            actionString = self.user.username + " " + (self.challenge["action"] as! String) + "."
        }

        var actionTextViewAttributedString = NSMutableAttributedString(string: actionString)
        var textViewParagraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        textViewParagraphStyle.lineSpacing = 2

        actionTextViewAttributedString.addAttribute(NSParagraphStyleAttributeName, value: textViewParagraphStyle, range: (actionString as NSString).rangeOfString(actionString))
        actionTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: 15)!, range: (actionString as NSString).rangeOfString(actionString))
        actionTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: (actionString as NSString).rangeOfString(self.user.username))
        actionTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: (actionString as NSString).rangeOfString(narrativeTitleString))
        actionTextViewAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: (actionString as NSString).rangeOfString(challengeTitleString))

        self.avatarImageView.image = self.avatarImageDictionary[user["avatar"] as! String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[user["color"] as! String]
        self.actionTextView.attributedText = actionTextViewAttributedString

        var activityExpandedCellViewsDictionary =
        [
            "avatarImageView":self.avatarImageView,
            "actionTextView":self.actionTextView,
            "bottomSeparatorView":self.bottomSeparatorView
        ]
        
        var activityExpandedCellMetricsDictionary = ["largeVerticalPadding":12]
        
        var horizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[avatarImageView(50)]-12.5-[actionTextView]-7.5-|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var secondHorizontalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparatorView]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var verticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-16.5-[avatarImageView(50)]->=12-[bottomSeparatorView(1)]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        var secondVerticalShadeViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-14.5-[actionTextView]->=12-[bottomSeparatorView(1)]|", options: NSLayoutFormatOptions(0), metrics: activityExpandedCellViewsDictionary, views: activityExpandedCellViewsDictionary)
        
        self.activityHeader.addConstraints(horizontalShadeViewConstraints)
        self.activityHeader.addConstraints(secondHorizontalShadeViewConstraints)
        self.activityHeader.addConstraints(verticalShadeViewConstraints)
        self.activityHeader.addConstraints(secondVerticalShadeViewConstraints)
        
        self.expandedViewSegmentedControl = UISegmentedControl(items: ["About","Comments","More"])
        self.expandedViewSegmentedControl.frame = CGRectZero
        self.expandedViewSegmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.expandedViewSegmentedControl.tintColor = UIColor.blackColor()

        
        self.expandedViewSegmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        segmentedControlView.addSubview(self.expandedViewSegmentedControl)
        
        var bottomSeparator = UIView(frame: CGRectZero)
        bottomSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomSeparator.backgroundColor = UIColor(white: 0.85, alpha: 1)
        segmentedControlView.addSubview(bottomSeparator)
        
        var viewsDictionary = ["expandedViewSegmentedControl":self.expandedViewSegmentedControl, "bottomSeparator":bottomSeparator]
        var metricsDictionary = ["sideMargin":7.5, "verticalMargin":8]
        
        var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[expandedViewSegmentedControl]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var bottomSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[expandedViewSegmentedControl(28)]-8-[bottomSeparator(1)]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        segmentedControlView.addConstraints(horizontalConstraints)
        segmentedControlView.addConstraints(bottomSeparatorConstraints)
        segmentedControlView.addConstraints(verticalConstraints)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), forBarMetrics: UIBarMetrics.Default)
        
        switch self.selectedSegment{
        case "Details":
            self.expandedViewSegmentedControl.selectedSegmentIndex = 0
//            self.detailsTableView.hidden = true
//            self.commentsTableView.view.hidden = true
//            self.moreTableView.hidden = true
        case "Comments":
            self.expandedViewSegmentedControl.selectedSegmentIndex = 1
//            self.detailsTableView.hidden = true
            self.commentsTableView.view.hidden = false
//            self.moreTableView.hidden = true
        default:
            self.expandedViewSegmentedControl.selectedSegmentIndex = 2
//            self.detailsTableView.hidden = true
//            self.commentsTableView.view.hidden = true
//            self.moreTableView.hidden = true
        }

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        var comboActivityHeaderSegmentedControlViewHeight = 64 + self.activityHeader.frame.height + self.segmentedControlView.frame.height
        self.detailsTableView.contentInset.top = comboActivityHeaderSegmentedControlViewHeight
        self.moreTableView.contentInset.top = comboActivityHeaderSegmentedControlViewHeight
        self.detailsTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        self.moreTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)

//        self.commentsTableView.tableView.contentInset.bottom = comboActivityHeaderSegmentedControlViewHeight + 64
        switch self.selectedSegment{
        case "Details":
            self.expandedViewSegmentedControl.selectedSegmentIndex = 0
            self.detailsTableView.hidden = false
            self.commentsTableView.view.hidden = true
            self.moreTableView.hidden = true
        case "Comments":
            self.expandedViewSegmentedControl.selectedSegmentIndex = 1
            self.detailsTableView.hidden = true
            self.commentsTableView.view.hidden = false
            self.moreTableView.hidden = true
        default:
            self.expandedViewSegmentedControl.selectedSegmentIndex = 2
            self.detailsTableView.hidden = true
            self.commentsTableView.view.hidden = true
            self.moreTableView.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if tableView == self.detailsTableView{
            return (self.challenge["stepTitle"] as! [String]).count
        }
        else{
            return 1
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if tableView == self.detailsTableView{
//            var stepTitleHeaderView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 40))
//            stepTitleHeaderView.backgroundColor = UIColor(white: 0.95, alpha: 1)
//            var stepTitleLabel = UILabel(frame: CGRectZero)
//            stepTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//            var stepTitleText = (self.challenge["stepTitle"] as! [String])[section] as String
//            stepTitleLabel.text = "Step \(section + 1): \(stepTitleText)"
////            stepTitleLabel.textAlignment = NSTextAlignment.Center
//            stepTitleHeaderView.addSubview(stepTitleLabel)
//            
//            var viewsDictionary = ["stepTitleLabel":stepTitleLabel]
//            var metricsDictionary = ["verticalMargin":6]
//            
//            var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-verticalMargin-[stepTitleLabel]-verticalMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//            
//            var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-7.5-[stepTitleLabel]-7.5-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
//            
////            var horizontalCenterConstraint = NSLayoutConstraint(item: stepTitleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: stepTitleHeaderView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
//            
//            stepTitleHeaderView.addConstraints(verticalConstraints)
//            stepTitleHeaderView.addConstraints(horizontalConstraints)
////            stepTitleHeaderView.addConstraint(horizontalCenterConstraint)
//            
//            return stepTitleHeaderView
//        }
//        var stepTitleHeaderView = UIView(frame: CGRectZero)
//        stepTitleHeaderView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        
//        
//        return stepTitleHeaderView
//    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        if tableView == self.detailsTableView{
            return 3
        }
        else{
            return 3
        }
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == self.detailsTableView{
            return UITableViewAutomaticDimension
        }
        else{
            return 64
        }
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.detailsTableView{
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("StepTitleTableViewCell") as! StepTitleTableViewCell
                var stepTitleText = (self.challenge["stepTitle"] as! [String])[indexPath.section] as String
                cell.stepTitleLabel.text = "Step \(indexPath.section + 1): \(stepTitleText)"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("StepBlurbTableViewCell") as! StepBlurbTableViewCell
                var stepBlurbText = (self.challenge["stepSummary"] as! [String])[indexPath.section] as String
                cell.stepBlurbLabel.text = stepBlurbText
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("StepMediaTableViewCell") as! StepMediaTableViewCell
                return cell
            }
        }else{
        // Configure the cell...
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "defaultCell")
            switch indexPath.row{
            case 0:
                cell.textLabel?.text = "Completed By"
                cell.detailTextLabel?.text = "See who else completed this challenge"
            case 1:
                cell.textLabel?.text = "Challenge Reviews"
                cell.detailTextLabel?.text = "View others' feedback on this challenge"
            default:
                cell.textLabel?.text = "Report Activity"
                cell.detailTextLabel?.text = "Report this activtiy for possible violation"
            }
            cell.backgroundColor = UIColor.whiteColor()
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
    }

    func valueChanged(segment:UISegmentedControl){
        switch segment.selectedSegmentIndex{
        case 0:
            self.selectedSegment = "About"
            self.commentsTableView.textView.resignFirstResponder()
            self.detailsTableView.hidden = false
            self.commentsTableView.view.hidden = true
            self.moreTableView.hidden = true
        case 1:
            self.selectedSegment = "Comments"
            self.detailsTableView.hidden = true
            self.commentsTableView.view.hidden = false
            self.moreTableView.hidden = true
        default:
            self.selectedSegment = "More"
            self.commentsTableView.textView.resignFirstResponder()
            self.detailsTableView.hidden = true
            self.commentsTableView.view.hidden = true
            self.moreTableView.hidden = false
        }
    }
    

    func textViewTapped(recognizer:UITapGestureRecognizer){
        var textView:UITextView = recognizer.view as! UITextView
        // Location of the tap in text-container coordinates
        
        var layoutManager:NSLayoutManager = textView.layoutManager
        var location:CGPoint = recognizer.locationInView(textView)
        location.x -= textView.textContainerInset.left;
        location.y -= textView.textContainerInset.top;
        
        // Find the character that's been tapped on
        
        var characterIndex:Int
        characterIndex = layoutManager.characterIndexForPoint(location, inTextContainer: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        var userAliasCharacterRange = count(self.user.username)
        var activityNarrativeTitleRangeStart = -1
        var activityNarrativeTitleRangeEnd = -1
        var activityChallengeTitleRangeStart = -1
        var activityChallengeTitleRangeEnd = -1

        if self.challengeTrackNumber != 0{
            activityNarrativeTitleRangeStart = userAliasCharacterRange + 2 + count(self.challenge["narrativeAction"] as! String)
            activityNarrativeTitleRangeEnd = activityNarrativeTitleRangeStart + count((self.challenge["narrativeTitles"] as! [String])[self.challengeTrackNumber])
            activityChallengeTitleRangeStart = activityNarrativeTitleRangeEnd + count(" in ")
            activityChallengeTitleRangeEnd = activityChallengeTitleRangeStart + count(self.challenge["title"] as! String)
        }
        
        if (characterIndex < count(self.user.username)) {
            
            // Handle as required...
            println("username tapped")
            
        }
        else if self.challengeTrackNumber != 0{
            if (characterIndex >= activityNarrativeTitleRangeStart && characterIndex <= activityNarrativeTitleRangeEnd) {
                
                // Handle as required...
                println("narrative title tapped")
            }
            else if (characterIndex >= activityChallengeTitleRangeStart && characterIndex <= activityChallengeTitleRangeEnd) {
                
                // Handle as required...
                println("challenge title tapped")
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.moreTableView{
            switch indexPath.row{
                case 0: self.performSegueWithIdentifier("showAlsoCompletedBy", sender: self)
                case 1: self.performSegueWithIdentifier("showChallengeFeedback", sender: self)
                default: self.performSegueWithIdentifier("showReportActivity", sender: self)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAlsoCompletedBy"{
            var destinationVC = segue.destinationViewController as! AlsoCompletedByViewController
            destinationVC.challenge = self.challenge
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // Update UINavigationBar title with page title once the page is loaded
        //        self.navigationItem.title = self.webView.stringByEvaluatingJavaScriptFromString("document.title")
//        self.activityContentWebView.hidden = false
    }
    // Store new comment if Post button tapped




}
