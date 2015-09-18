//
//  DashboardViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import Parse

// Controller for Dashboard view
class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PresentNewView{
    
    var scrollView:TPKeyboardAvoidingScrollView!
    
    
    // Profile and progress container view
    var profileProgressView:UIView!
    
    var profileView:UIView!
    var avatarImageView:UIImageView!
    var myProfileLabel:UILabel!
    var currentUserLabel:UILabel!
    
    var profileProgressSeparator:UIView!
    
    var recordView:UIView!
    var recordsLabel:UILabel!
    var recordSubLabel:UILabel!
    var myProgressPieChart:PNPieChart!
    
    
    // Announcement view
    var announcementsView:UIView!
    var announcementsLabel:UILabel!
    var announcementsHeaderSeparator:UIView!
    var announcementsPageControl:UIPageControl!
    var announcementsCollectionView:UICollectionView!
    var announcementsLayout = DashboardAnnouncementsCollectionViewFlowLayout()

    
    // Challenge on deck container view
    var challengeOnDeckView:UIView!
    var challengeOnDeckLabel:UILabel!
    var challengeOnDeckHeaderSeparator:UIView!

    var challengeOnDeckCard:UIView!
    var challengeOnDeckTagLabel:UILabel!
    var challengeOnDeckTitle:UILabel!
    var challengeOnDeckInstruction:UILabel!
    var challengeOnDeckChevronButton:UIButton!
    
    
    // Inspiration container view
    var inspirationView:UIView!
    var inspirationLabel:UILabel!
    var inspirationHeaderSeparator:UILabel!

    var inspirationCard:UIView!
    var inspirationContentLabel:UILabel!
    var inspirationAuthorAvatarImageView:UIImageView!
    var inspirationAuthorNameLabel:UILabel!
    var inspirationAuthorRoleLabel:UILabel!
    var inspirationReadMoreButton:UIButton!
    
    
    // User color dictionary
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
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
        "intermediateYellow":UIColor(red: 255/255, green: 206/255, blue: 0/255, alpha: 1),
        "intenseRed":UIColor(red: 223/255, green: 48/255, blue: 97/255, alpha: 1),
        "casualGreen":UIColor(red: 32/255, green: 220/255, blue: 129/255, alpha: 1)
    ]
    
    
    // Avatar image dictionary
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

    // UIFont initialization
    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dashboard UINavigationBar init
        self.navigationItem.title = "Me"
        self.navigationItem.rightBarButtonItem = nil

        // Dashboard container scroll view init
        self.scrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        self.view = self.scrollView
        
        // Contained views init and layout
        self.profileProgressView = UIView(frame: CGRectZero)
        self.profileProgressView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.profileProgressView)
        
        self.challengeOnDeckView = UIView(frame: CGRectZero)
        self.challengeOnDeckView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.challengeOnDeckView)
        
        self.announcementsView = UIView(frame: CGRectZero)
        self.announcementsView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.announcementsView)

        self.inspirationView = UIView(frame: CGRectZero)
        self.inspirationView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.inspirationView)
        
        let screenWidth = self.view.bounds.size.width
        let contentWidth = screenWidth - 24

        let containerViewsDictionary = ["profileProgressView":self.profileProgressView, "challengeOnDeckView":self.challengeOnDeckView, "announcementsView":self.announcementsView, "inspirationView":self.inspirationView]
        let containerMetricsDictionary = ["sideMargin": 12, "topMargin":30, "bottomMargin":30, "contentWidth": contentWidth]
        
        let horizontalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[profileProgressView(==contentWidth)]-sideMargin-|", options: NSLayoutFormatOptions(rawValue:0), metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        let verticalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[profileProgressView]->=30-[announcementsView]->=15-[challengeOnDeckView]->=20-[inspirationView]-bottomMargin-|", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        self.scrollView.addConstraints(horizontalContainerViewsConstraints)
        self.scrollView.addConstraints(verticalContainerViewsConstraints)
        

        // Profile and progress view containers init and layout
        self.profileView = UIView(frame: CGRectZero)
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProfileTapped")
        self.profileView.addGestureRecognizer(profileTapGestureRecognizer)
        self.profileProgressView.addSubview(self.profileView)
        
        self.profileProgressSeparator = UIView(frame: CGRectZero)
        self.profileProgressSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.profileProgressSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.profileProgressView.addSubview(self.profileProgressSeparator)
        
        self.recordView = UIView(frame: CGRectZero)
        self.recordView.translatesAutoresizingMaskIntoConstraints = false
        let progressTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProgressTapped")
        self.recordView.addGestureRecognizer(progressTapGestureRecognizer)
        self.profileProgressView.addSubview(self.recordView)
        
        let profileProgressSubcontainersViewsDictionary = ["profileView":self.profileView, "profileProgressSeparator":self.profileProgressSeparator, "recordView":self.recordView]
        let profileProgressSubcontainersMetricsDictionary = ["sideMargin":21]
        
        let horizontalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[profileView]-sideMargin-[profileProgressSeparator(1)]-sideMargin-[recordView]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        let verticalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[recordView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        let verticalProfileProgressSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[profileProgressSeparator]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        self.profileProgressView.addConstraints(horizontalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressSeparatorConstraints)
        
        
        // Profile view init and layout
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = self.avatarImageDictionary[(PFUser.currentUser()!)["avatar"] as! String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[(PFUser.currentUser()!)["color"] as! String]
        self.profileView.addSubview(self.avatarImageView)
        
        self.myProfileLabel = UILabel(frame: CGRectZero)
        self.myProfileLabel.text = "Profile"
        self.myProfileLabel.numberOfLines = 0
        self.myProfileLabel.textAlignment = NSTextAlignment.Left
        self.myProfileLabel.font = regularFont?.fontWithSize(20.0)
        if self.view.bounds.width == 320{
            self.myProfileLabel.font = regularFont?.fontWithSize(16.0)
        }
        self.myProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        self.profileView.addSubview(self.myProfileLabel)

        self.currentUserLabel = UILabel(frame: CGRectZero)
        self.currentUserLabel.translatesAutoresizingMaskIntoConstraints = false
        self.currentUserLabel.text = PFUser.currentUser()!.username
        self.currentUserLabel.font = regularFont?.fontWithSize(13.0)
        if self.view.bounds.width == 320{
            self.currentUserLabel.font = regularFont?.fontWithSize(11.0)
        }
        self.currentUserLabel.textAlignment = NSTextAlignment.Left
        self.profileView.addSubview(self.currentUserLabel)
        
        
        let profileViewViewsDictionary = ["avatarImageView":self.avatarImageView, "myProfileLabel":self.myProfileLabel, "currentUserLabel":self.currentUserLabel]
        let profileViewMetricsDictionary = ["inBetweenPadding":18]
        
        let horizontalprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(50)]-inBetweenPadding-[myProfileLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        let verticalLeftprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[avatarImageView(50)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        let verticalRightprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProfileLabel]-2-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        self.profileView.addConstraints(horizontalprofileViewConstraints)
        self.profileView.addConstraints(verticalLeftprofileViewConstraints)
        self.profileView.addConstraints(verticalRightprofileViewConstraints)
        
        
        // Record view init and layout
        self.recordsLabel = UILabel(frame: CGRectZero)
        self.recordsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.recordsLabel.text = "Progress"
        self.recordsLabel.textAlignment = NSTextAlignment.Left
        self.recordsLabel.font = regularFont?.fontWithSize(20.0)
        if self.view.bounds.width == 320{
            self.recordsLabel.font = regularFont?.fontWithSize(16.0)
        }
        self.recordsLabel.numberOfLines = 0
        self.recordView.addSubview(self.recordsLabel)
        
        self.recordSubLabel = UILabel(frame: CGRectZero)
        self.recordSubLabel.translatesAutoresizingMaskIntoConstraints = false
        self.recordSubLabel.text = "past challenges"
        self.recordSubLabel.font = regularFont?.fontWithSize(13.0)
        if self.view.bounds.width == 320{
            self.recordSubLabel.font = regularFont?.fontWithSize(11.0)
        }
        self.recordSubLabel.textAlignment = NSTextAlignment.Left
        self.recordView.addSubview(self.recordSubLabel)
        
        let items:NSArray = [PNPieChartDataItem(value: 0.33, color: self.colorDictionary["intermediateYellow"],description: ""), PNPieChartDataItem(value: 0.33, color: self.colorDictionary["intenseRed"],description: ""),PNPieChartDataItem(value: 0.34, color: self.colorDictionary["casualGreen"],description: "")]
        self.myProgressPieChart = PNPieChart(frame: CGRectMake(0, 0, 50, 50), items: items as [AnyObject])
        self.myProgressPieChart.strokeChart()
        self.recordView.addSubview(self.myProgressPieChart)

        let recordViewViewsDictionary = ["recordsLabel":self.recordsLabel, "myProgressPieChart":self.myProgressPieChart, "recordSubLabel":self.recordSubLabel]
        
        let myProgresssViewMetricsDictionary = ["inBetweenPadding":18]
        
        let horizontalrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProgressPieChart(50)]-inBetweenPadding-[recordsLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        let verticalLeftrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressPieChart(50)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        let verticalRightrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[recordsLabel]-2-[recordSubLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        self.recordView.addConstraints(horizontalrecordViewConstraint)
        self.recordView.addConstraints(verticalLeftrecordViewConstraint)
        self.recordView.addConstraints(verticalRightrecordViewConstraint)
        
        // Announcements label init and layout
        self.announcementsLabel = UILabel(frame: CGRectZero)
        self.announcementsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.announcementsLabel.text = "What's New"
        self.announcementsLabel.textAlignment = NSTextAlignment.Left
        self.announcementsLabel.font = titleFont?.fontWithSize(15.0)
        self.announcementsLabel.numberOfLines = 1
        self.announcementsView.addSubview(self.announcementsLabel)
        
        self.announcementsHeaderSeparator = UIView(frame: CGRectZero)
        self.announcementsHeaderSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.announcementsHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.announcementsView.addSubview(self.announcementsHeaderSeparator)
        
        self.announcementsPageControl = UIPageControl(frame: CGRectZero)
        self.announcementsPageControl.translatesAutoresizingMaskIntoConstraints = false
        self.announcementsPageControl.hidesForSinglePage = true
        self.announcementsPageControl.backgroundColor = UIColor.clearColor()
        self.announcementsPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        self.announcementsPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        self.announcementsPageControl.userInteractionEnabled = false
        self.announcementsPageControl.numberOfPages = 0
        self.announcementsView.addSubview(announcementsPageControl)
        
        // Announcements collection view init and layout
        self.announcementsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.announcementsLayout)
        self.announcementsLayout.itemSize = CGSizeMake(self.view.frame.size.width - 30, 54)
        self.announcementsLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.announcementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.announcementsCollectionView.showsHorizontalScrollIndicator = false
        self.announcementsCollectionView.pagingEnabled = true
        self.announcementsCollectionView.alwaysBounceHorizontal = true
        self.announcementsCollectionView.delegate = self
        self.announcementsCollectionView.dataSource = self
        self.announcementsCollectionView.backgroundColor = UIColor.clearColor()
        self.announcementsCollectionView.registerClass(DashboardAnnouncementsCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardAnnouncementsCollectionViewCell")
        self.announcementsView.addSubview(self.announcementsCollectionView)

        let announcementsViewsDictionary = ["announcementsLabel":self.announcementsLabel, "announcementsHeaderSeparator":self.announcementsHeaderSeparator, "announcementsPageControl":self.announcementsPageControl, "announcementsCollectionView":self.announcementsCollectionView]
        let announcementsMetricsDictionary = ["pageControlRightSideMargin":15]
        
        let horizontalannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[announcementsLabel]-[announcementsPageControl]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        let horizontalAnnouncementsCollectionViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[announcementsCollectionView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        let verticalLeftannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[announcementsLabel]-2-[announcementsHeaderSeparator(1)]-15-[announcementsCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        let verticalRightannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[announcementsPageControl(18)]-2-[announcementsHeaderSeparator(1)]-15-[announcementsCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        self.announcementsView.addConstraints(horizontalannouncementsConstraints)
        self.announcementsView.addConstraints(horizontalAnnouncementsCollectionViewConstraints)
        self.announcementsView.addConstraints(verticalLeftannouncementsConstraints)
        self.announcementsView.addConstraints(verticalRightannouncementsConstraints)        
        
        
        // Challenge on deck label init and layout
        self.challengeOnDeckLabel = UILabel(frame: CGRectZero)
        self.challengeOnDeckLabel.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckLabel.text = "Challenge Highlight"
        self.challengeOnDeckLabel.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckLabel.font = titleFont?.fontWithSize(15.0)
        self.challengeOnDeckLabel.numberOfLines = 1
        self.challengeOnDeckView.addSubview(self.challengeOnDeckLabel)
        
        self.challengeOnDeckHeaderSeparator = UIView(frame: CGRectZero)
        self.challengeOnDeckHeaderSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.challengeOnDeckView.addSubview(self.challengeOnDeckHeaderSeparator)
        
        self.challengeOnDeckCard = UIView(frame: CGRectZero)
        self.challengeOnDeckCard.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckView.addSubview(self.challengeOnDeckCard)
        
        let challengeOnDeckViewViewsDictionary = ["challengeOnDeckLabel":self.challengeOnDeckLabel, "challengeOnDeckHeaderSeparator":self.challengeOnDeckHeaderSeparator, "challengeOnDeckView":self.challengeOnDeckView, "challengeOnDeckCard":self.challengeOnDeckCard]
        let challengeOnDeckMetricsDictionary = ["pageControlRightSideMargin":15]
        
        let horizontalchallengeOnDeckConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        let horizontalChallengeOnDeckSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckHeaderSeparator]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        let horizontalChallengeOnDeckViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckCard]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        let verticalLeftchallengeOnDeckConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[challengeOnDeckLabel]-2-[challengeOnDeckHeaderSeparator(1)]-18-[challengeOnDeckCard]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        self.challengeOnDeckView.addConstraints(horizontalchallengeOnDeckConstraints)
        self.challengeOnDeckView.addConstraints(horizontalChallengeOnDeckSeparatorConstraints)
        self.challengeOnDeckView.addConstraints(horizontalChallengeOnDeckViewConstraints)
        self.challengeOnDeckView.addConstraints(verticalLeftchallengeOnDeckConstraints)

        // Challenge on deck init and layout
        self.challengeOnDeckTitle = UILabel(frame: CGRectZero)
        self.challengeOnDeckTitle.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckTitle.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckTitle.textColor = UIColor.blackColor()
        self.challengeOnDeckTitle.font = self.titleFont?.fontWithSize(15.0)
        self.challengeOnDeckTitle.text = "God's Love We Deliver is nearby"
        self.challengeOnDeckTitle.numberOfLines = 0
        self.challengeOnDeckTitle.preferredMaxLayoutWidth = self.view.bounds.width - 38
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckTitle)
        
        self.challengeOnDeckInstruction = UILabel(frame: CGRectZero)
        self.challengeOnDeckInstruction.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckInstruction.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckInstruction.textColor = UIColor.blackColor()
        self.challengeOnDeckInstruction.font = self.regularFont?.fontWithSize(14.0)
        self.challengeOnDeckInstruction.numberOfLines = 0
        self.challengeOnDeckInstruction.text = "Now would be a good time to schedule for your volunteer shift."
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckInstruction)
        
        self.challengeOnDeckChevronButton = UIButton(type: UIButtonType.System)
        self.challengeOnDeckChevronButton.translatesAutoresizingMaskIntoConstraints = false
        self.challengeOnDeckChevronButton.setImage(UIImage(named:"chevron-icon"), forState: UIControlState.Normal)
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckChevronButton)
        
        let challengeOnDeckCardViewsDictionary = ["challengeOnDeckTitle":self.challengeOnDeckTitle, "challengeOnDeckInstruction":self.challengeOnDeckInstruction, "challengeOnDeckChevronButton":self.challengeOnDeckChevronButton]
        let challengeOnDeckCardMetricsDictionary = ["shortVerticalMargin":10]
        
        
        let horizontalTitleChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckTitle]-[challengeOnDeckChevronButton(20)]-5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        let horizontalInstructionChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckInstruction]-[challengeOnDeckChevronButton(20)]-5-|", options: NSLayoutFormatOptions(rawValue:0), metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        let verticalChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[challengeOnDeckTitle]-3-[challengeOnDeckInstruction]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)
        
        let verticalRightChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[challengeOnDeckChevronButton(20)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        self.challengeOnDeckCard.addConstraints(horizontalTitleChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(verticalChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(horizontalInstructionChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(verticalRightChallengeOnDeckCardConstraints)
        
        // Inspiration label init and layout
        self.inspirationLabel = UILabel(frame: CGRectZero)
        self.inspirationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationLabel.text = "Inspiration"
        self.inspirationLabel.textAlignment = NSTextAlignment.Left
        self.inspirationLabel.font = titleFont?.fontWithSize(15.0)
        self.inspirationLabel.numberOfLines = 1
        self.inspirationView.addSubview(self.inspirationLabel)
        
        self.inspirationHeaderSeparator = UILabel(frame: CGRectZero)
        self.inspirationHeaderSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.inspirationView.addSubview(self.inspirationHeaderSeparator)
        
        self.inspirationCard = UIView(frame: CGRectZero)
        self.inspirationCard.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationView.addSubview(self.inspirationCard)
        
        let inspirationViewsDictionary = ["inspirationLabel":self.inspirationLabel, "inspirationHeaderSeparator":self.inspirationHeaderSeparator, "inspirationCard":self.inspirationCard]
        let inspirationMetricsDictionary = ["pageControlRightSideMargin":15]
        
        let horizontalinspirationConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        let horizontalInspirationSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationHeaderSeparator]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)

        let horizontalInspirationCardViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationCard]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        let verticalLeftinspirationConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[inspirationLabel]-2-[inspirationHeaderSeparator(1)]-15-[inspirationCard]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        self.inspirationView.addConstraints(horizontalInspirationCardViewConstraints)
        self.inspirationView.addConstraints(horizontalinspirationConstraints)
        self.inspirationView.addConstraints(horizontalInspirationSeparatorConstraints)
        self.inspirationView.addConstraints(verticalLeftinspirationConstraints)
        
        
        // Inspiration init and layout
        self.inspirationContentLabel = UILabel(frame: CGRectZero)
        self.inspirationContentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationContentLabel.textAlignment = NSTextAlignment.Left
        self.inspirationContentLabel.textColor = UIColor.blackColor()
        self.inspirationContentLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        self.inspirationContentLabel.numberOfLines = 0
        self.inspirationContentLabel.text = "If you want to change the future, start living as if you're already there."
        self.inspirationCard.addSubview(self.inspirationContentLabel)
        
        self.inspirationAuthorAvatarImageView = UIImageView(frame: CGRectZero)
        self.inspirationAuthorAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationAuthorAvatarImageView.image = UIImage(named: "lynn-photo")
        self.inspirationAuthorAvatarImageView.layer.cornerRadius = 30
        self.inspirationAuthorAvatarImageView.clipsToBounds = true
        self.inspirationAuthorAvatarImageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.inspirationAuthorAvatarImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.inspirationAuthorAvatarImageView.layer.shadowOpacity = 0.1
        self.inspirationAuthorAvatarImageView.layer.shadowRadius = 1
        self.inspirationAuthorAvatarImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        self.inspirationAuthorAvatarImageView.layer.borderWidth = 0.75
        self.inspirationCard.addSubview(self.inspirationAuthorAvatarImageView)
        
        self.inspirationAuthorNameLabel = UILabel(frame: CGRectZero)
        self.inspirationAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationAuthorNameLabel.textAlignment = NSTextAlignment.Left
        self.inspirationAuthorNameLabel.textColor = UIColor.blackColor()
        self.inspirationAuthorNameLabel.font = self.titleFont?.fontWithSize(14.0)
        self.inspirationAuthorNameLabel.text = "Lynn Conway"
        self.inspirationCard.addSubview(self.inspirationAuthorNameLabel)
        
        self.inspirationAuthorRoleLabel = UILabel(frame: CGRectZero)
        self.inspirationAuthorRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationAuthorRoleLabel.textAlignment = NSTextAlignment.Left
        self.inspirationAuthorRoleLabel.textColor = UIColor.blackColor()
        self.inspirationAuthorRoleLabel.font = self.regularFont?.fontWithSize(14.0)
        self.inspirationAuthorRoleLabel.preferredMaxLayoutWidth = self.view.bounds.width - 90
        self.inspirationAuthorRoleLabel.text = "Professor at University of Michigan"
        self.inspirationAuthorRoleLabel.numberOfLines = 0
        self.inspirationCard.addSubview(self.inspirationAuthorRoleLabel)
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "presentWebView:")
        self.inspirationReadMoreButton = UIButton(type: UIButtonType.System)
        self.inspirationReadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.inspirationReadMoreButton.tintColor = UIColor.blackColor()
        self.inspirationReadMoreButton.layer.borderColor = UIColor.blackColor().CGColor
        self.inspirationReadMoreButton.layer.borderWidth = 1
        self.inspirationReadMoreButton.layer.cornerRadius = 5
        self.inspirationReadMoreButton.setTitle("Read Lynn's Story", forState: UIControlState.Normal)
        self.inspirationReadMoreButton.titleLabel!.font = UIFont(name: "UIFontTextStyleHeadline", size: CGFloat(30.0))
        self.inspirationReadMoreButton.addGestureRecognizer(tapRecognizer)
        self.inspirationCard.addSubview(self.inspirationReadMoreButton)
        
        let inspirationCardViewsDictionary = ["inspirationContentLabel":self.inspirationContentLabel, "inspirationAuthorAvatarImageView":self.inspirationAuthorAvatarImageView, "inspirationAuthorNameLabel":self.inspirationAuthorNameLabel, "inspirationAuthorRoleLabel":self.inspirationAuthorRoleLabel, "inspirationReadMoreButton":self.inspirationReadMoreButton]
        
        let inspirationCardMetricsDictionary = ["shortVerticalMargin":8]
        
        let horizontalInspirationCardBylineConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationAuthorAvatarImageView(60)]-14-[inspirationContentLabel]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        let horizontalInspirationCardReadMoreButtonConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationReadMoreButton]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        let verticalLeftInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[inspirationAuthorAvatarImageView(60)]->=20-[inspirationReadMoreButton(40)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        let verticalLeftSecondInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[inspirationContentLabel]-12-[inspirationAuthorNameLabel]-0-[inspirationAuthorRoleLabel]", options: [NSLayoutFormatOptions.AlignAllLeft, NSLayoutFormatOptions.AlignAllRight], metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        let verticalLeftThirdInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[inspirationAuthorRoleLabel]->=24-[inspirationReadMoreButton(40)]", options: NSLayoutFormatOptions(rawValue:0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        self.inspirationCard.addConstraints(horizontalInspirationCardReadMoreButtonConstraints)
        self.inspirationCard.addConstraints(horizontalInspirationCardBylineConstraints)
        self.inspirationCard.addConstraints(verticalLeftInspirationCardConstraints)
        self.inspirationCard.addConstraints(verticalLeftSecondInspirationCardConstraints)
        self.inspirationCard.addConstraints(verticalLeftThirdInspirationCardConstraints)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Initiate logout process if Logout button tapped
    @IBAction func logoutBarButtonItemTapped(sender: UIBarButtonItem) {
//        var currentUser = PFUser.currentUser()
    }

    // Prepare for Logout segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoggedOut"){
            PFInstallation.currentInstallation().removeObjectForKey("currentUser")
            PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil)
            let vc:LoginViewController = segue.destinationViewController.childViewControllers[0] as! LoginViewController
            vc.showTutorial = false
            vc.scrollViewHidden = false
            PFUser.logOut()
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            print(appDelegate.layerClient.description)
//            appDelegate.layerClient.deauthenticateWithCompletion { (success, error) -> Void in
//                if (error == nil) {
//                    print("Successfully deauthenticated \(success)")
//                } else {
//                    print("Failed to deauthenticate: \(error)")
//                }
//            }
        }
    }
    
    // Segue to profile modal view
    func myProfileTapped(){
        self.performSegueWithIdentifier("showMyProfile", sender: self)
    }
    
    // Segue to progress modal view
    func myProgressTapped(){
        self.performSegueWithIdentifier("showMyProgress", sender: self)
    }
    
    // Announcements view collection view delegate method
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.announcementsPageControl.numberOfPages = 3
        return 3
    }
    
    // Update announcements view pagecontrol when scrolling on view ends
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage:CGFloat = self.announcementsCollectionView.contentOffset.x / self.announcementsCollectionView.frame.size.width
        self.announcementsPageControl.currentPage = Int(ceil(Float(currentPage)))

    }

    // Announcements view collection view delegate method
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardAnnouncementsCollectionViewCell", forIndexPath: indexPath) as! DashboardAnnouncementsCollectionViewCell
        if indexPath.item == 0{
            cell.avatarImageView.image = self.avatarImageDictionary["elephant"]!
            cell.avatarImageView.backgroundColor = self.colorDictionary["teal"]
            cell.aliasLabel.text = "eleph34"
            cell.roleLabel.text = "mentor"
            cell.alertCountLabel.text = "3"
            cell.alertTypeLabel.text = "new messages"
        }
        else if indexPath.item == 1{
            cell.avatarImageView.image = self.avatarImageDictionary["rabbit"]!
            cell.avatarImageView.backgroundColor = self.colorDictionary["pink"]
            cell.aliasLabel.text = "rabbit21"
            cell.roleLabel.text = "follower"
            cell.alertCountLabel.text = "2"
            cell.alertTypeLabel.text = "new following"

        }
        else if indexPath.item == 2{
            cell.avatarImageView.image = self.avatarImageDictionary["bird"]!
            cell.avatarImageView.backgroundColor = self.colorDictionary["lightBlue"]
            cell.aliasLabel.text = "birdie98"
            cell.roleLabel.text = "following"
            cell.alertCountLabel.text = "9"
            cell.alertTypeLabel.text = "new likes"
            
        }
        return cell
    }
    
    // Protocol implementation for PresentNewView
    func presentWebView(url: NSURL) {
        let webView = WebViewViewController()
        webView.url = NSURL(string: "http://ai.eecs.umich.edu/people/conway/conway.html#Reflections")
        let newViewController = UINavigationController(rootViewController: webView)
        newViewController.setToolbarHidden(false, animated: true)
        self.presentViewController(newViewController, animated: true, completion: nil)
    }


}
