//
//  DashboardViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var scrollView:TPKeyboardAvoidingScrollView!
    
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
    
    var announcementsView:UIView!
    var announcementsLabel:UILabel!
    var announcementsHeaderSeparator:UIView!
    var announcementsPageControl:UIPageControl!
    var announcementsCollectionView:UICollectionView!
    var announcementsLayout = DashboardAnnouncementsCollectionViewFlowLayout()

    var challengeOnDeckView:UIView!
    var challengeOnDeckLabel:UILabel!
    var challengeOnDeckHeaderSeparator:UIView!
    var challengeOnDeckCard:UIView!
    
    var challengeOnDeckTagLabel:UILabel!
    var challengeOnDeckTitle:UILabel!
    var challengeOnDeckInstruction:UILabel!
    var challengeOnDeckChevronButton:UIButton!
    
    var inspirationView:UIView!
    var inspirationLabel:UILabel!
    var inspirationHeaderSeparator:UILabel!

    var inspirationCard:UIView!
    var inspirationContentLabel:UILabel!
    var inspirationAuthorAvatarImageView:UIImageView!
    var inspirationAuthorNameLabel:UILabel!
    var inspirationAuthorRoleLabel:UILabel!
    var inspirationReadMoreButton:UIButton!
    
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

    let titleFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
    let regularFont = UIFont(name: "HelveticaNeue", size: 15.0)
    let valueFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dashboard"
        
        self.scrollView = TPKeyboardAvoidingScrollView(frame: self.view.frame)
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.showsVerticalScrollIndicator = false
//        self.scrollView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        self.scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        self.view = self.scrollView
        
        // container views initiation and layout
        
        self.profileProgressView = UIView(frame: CGRectZero)
        self.profileProgressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.profileProgressView)
        
        self.challengeOnDeckView = UIView(frame: CGRectZero)
        self.challengeOnDeckView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.challengeOnDeckView)
        
        self.announcementsView = UIView(frame: CGRectZero)
        self.announcementsView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.announcementsView)

        self.inspirationView = UIView(frame: CGRectZero)
        self.inspirationView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.inspirationView)
        var screenWidth = self.view.bounds.size.width
        var contentWidth = screenWidth - 24
        var containerViewsDictionary = ["profileProgressView":self.profileProgressView, "challengeOnDeckView":self.challengeOnDeckView, "announcementsView":self.announcementsView, "inspirationView":self.inspirationView]
        var containerMetricsDictionary = ["sideMargin": 12, "topMargin":30, "bottomMargin":30, "contentWidth": contentWidth]
        
        var horizontalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[profileProgressView(==contentWidth)]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        var verticalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[profileProgressView]->=30-[announcementsView]->=15-[challengeOnDeckView]->=20-[inspirationView]-bottomMargin-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        self.scrollView.addConstraints(horizontalContainerViewsConstraints)
        self.scrollView.addConstraints(verticalContainerViewsConstraints)
        

        // Profile Progress View Sub-containers Initiation and Layout

        self.profileView = UIView(frame: CGRectZero)
        self.profileView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProfileTapped")
        self.profileView.addGestureRecognizer(profileTapGestureRecognizer)
        self.profileProgressView.addSubview(self.profileView)
        
        self.profileProgressSeparator = UIView(frame: CGRectZero)
        self.profileProgressSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileProgressSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.profileProgressView.addSubview(self.profileProgressSeparator)
        
        self.recordView = UIView(frame: CGRectZero)
        self.recordView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var progressTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProgressTapped")
        self.recordView.addGestureRecognizer(progressTapGestureRecognizer)
        self.profileProgressView.addSubview(self.recordView)
        
        var profileProgressSubcontainersViewsDictionary = ["profileView":self.profileView, "profileProgressSeparator":self.profileProgressSeparator, "recordView":self.recordView]
        var profileProgressSubcontainersMetricsDictionary = ["sideMargin":21]
        
        var horizontalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[profileView]-sideMargin-[profileProgressSeparator(1)]-sideMargin-[recordView]->=0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        var verticalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[recordView]-0-|", options: NSLayoutFormatOptions(0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        var verticalProfileProgressSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[profileProgressSeparator]-0-|", options: NSLayoutFormatOptions(0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        self.profileProgressView.addConstraints(horizontalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressSeparatorConstraints)
        
        
        // Profile View Initiation and Layout
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.layer.cornerRadius = 25
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = self.avatarImageDictionary[PFUser.currentUser()["avatar"] as String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[PFUser.currentUser()["color"] as String]
        self.profileView.addSubview(self.avatarImageView)
        
        self.myProfileLabel = UILabel(frame: CGRectZero)
        self.myProfileLabel.text = "Profile"
        self.myProfileLabel.numberOfLines = 0
        self.myProfileLabel.textAlignment = NSTextAlignment.Left
        self.myProfileLabel.font = regularFont?.fontWithSize(20.0)
        if self.view.bounds.width == 320{
            self.myProfileLabel.font = regularFont?.fontWithSize(16.0)
        }
        self.myProfileLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileView.addSubview(self.myProfileLabel)

        self.currentUserLabel = UILabel(frame: CGRectZero)
        self.currentUserLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentUserLabel.text = PFUser.currentUser().username
        self.currentUserLabel.font = regularFont?.fontWithSize(13.0)
        if self.view.bounds.width == 320{
            self.currentUserLabel.font = regularFont?.fontWithSize(11.0)
        }
        self.currentUserLabel.textAlignment = NSTextAlignment.Left
        self.profileView.addSubview(self.currentUserLabel)
        
        var profileViewViewsDictionary = ["avatarImageView":self.avatarImageView, "myProfileLabel":self.myProfileLabel, "currentUserLabel":self.currentUserLabel]
        var profileViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(50)]-inBetweenPadding-[myProfileLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        var verticalLeftprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[avatarImageView(50)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        var verticalRightprofileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProfileLabel]-2-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: profileViewMetricsDictionary, views: profileViewViewsDictionary)
        
        self.profileView.addConstraints(horizontalprofileViewConstraints)
        self.profileView.addConstraints(verticalLeftprofileViewConstraints)
        self.profileView.addConstraints(verticalRightprofileViewConstraints)
        
        // recordView Initialization and Layout
        
        self.recordsLabel = UILabel(frame: CGRectZero)
        self.recordsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.recordsLabel.text = "Records"
        self.recordsLabel.textAlignment = NSTextAlignment.Left
        self.recordsLabel.font = regularFont?.fontWithSize(20.0)
        if self.view.bounds.width == 320{
            self.recordsLabel.font = regularFont?.fontWithSize(16.0)
        }
        self.recordsLabel.numberOfLines = 0
        self.recordView.addSubview(self.recordsLabel)
        
        self.recordSubLabel = UILabel(frame: CGRectZero)
        self.recordSubLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.recordSubLabel.text = "past challenges"
        self.recordSubLabel.font = regularFont?.fontWithSize(13.0)
        if self.view.bounds.width == 320{
            self.recordSubLabel.font = regularFont?.fontWithSize(11.0)
        }
        self.recordSubLabel.textAlignment = NSTextAlignment.Left
        self.recordView.addSubview(self.recordSubLabel)
        
        
        var items:NSArray = [PNPieChartDataItem(value: 0.3, color: self.colorDictionary["intermediateYellow"],description: ""), PNPieChartDataItem(value: 0.3, color: self.colorDictionary["intenseRed"],description: ""),PNPieChartDataItem(value: 0.4, color: self.colorDictionary["casualGreen"],description: "")]
        self.myProgressPieChart = PNPieChart(frame: CGRectMake(0, 0, 50, 50), items: items)
        self.myProgressPieChart.strokeChart()
        
        self.recordView.addSubview(self.myProgressPieChart)

        
        var recordViewViewsDictionary = ["recordsLabel":self.recordsLabel, "myProgressPieChart":self.myProgressPieChart, "recordSubLabel":self.recordSubLabel]
        
        var myProgresssViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProgressPieChart(50)]-inBetweenPadding-[recordsLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        var verticalLeftrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressPieChart(50)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        var verticalRightrecordViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[recordsLabel]-2-[recordSubLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: recordViewViewsDictionary)
        
        self.recordView.addConstraints(horizontalrecordViewConstraint)
        self.recordView.addConstraints(verticalLeftrecordViewConstraint)
        self.recordView.addConstraints(verticalRightrecordViewConstraint)
        
        // announcementsView initialization and layout
        
        self.announcementsLabel = UILabel(frame: CGRectZero)
        self.announcementsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.announcementsLabel.text = "What's New"
        self.announcementsLabel.textAlignment = NSTextAlignment.Left
        self.announcementsLabel.font = titleFont?.fontWithSize(15.0)
        self.announcementsLabel.numberOfLines = 1
        self.announcementsView.addSubview(self.announcementsLabel)
        
        self.announcementsHeaderSeparator = UIView(frame: CGRectZero)
        self.announcementsHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.announcementsHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.announcementsView.addSubview(self.announcementsHeaderSeparator)
        
        self.announcementsPageControl = UIPageControl(frame: CGRectZero)
        self.announcementsPageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.announcementsPageControl.hidesForSinglePage = true
        self.announcementsPageControl.backgroundColor = UIColor.clearColor()
        self.announcementsPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        self.announcementsPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        self.announcementsPageControl.userInteractionEnabled = false
        self.announcementsPageControl.numberOfPages = 0
        self.announcementsView.addSubview(announcementsPageControl)
        
        self.announcementsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.announcementsLayout)
        self.announcementsLayout.itemSize = CGSizeMake(self.view.frame.size.width - 30, 54)
        self.announcementsLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.announcementsCollectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.announcementsCollectionView.showsHorizontalScrollIndicator = false
        self.announcementsCollectionView.pagingEnabled = true
        self.announcementsCollectionView.alwaysBounceHorizontal = true
        self.announcementsCollectionView.delegate = self
        self.announcementsCollectionView.dataSource = self
        self.announcementsCollectionView.backgroundColor = UIColor.clearColor()
        self.announcementsCollectionView.registerClass(DashboardAnnouncementsCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardAnnouncementsCollectionViewCell")
        self.announcementsView.addSubview(self.announcementsCollectionView)

        var announcementsViewsDictionary = ["announcementsLabel":self.announcementsLabel, "announcementsHeaderSeparator":self.announcementsHeaderSeparator, "announcementsPageControl":self.announcementsPageControl, "announcementsCollectionView":self.announcementsCollectionView]
        var announcementsMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[announcementsLabel]-[announcementsPageControl]-0-|", options: NSLayoutFormatOptions(0), metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        var horizontalAnnouncementsCollectionViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[announcementsCollectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        var verticalLeftannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[announcementsLabel]-2-[announcementsHeaderSeparator(1)]-15-[announcementsCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        var verticalRightannouncementsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[announcementsPageControl(18)]-2-[announcementsHeaderSeparator(1)]-15-[announcementsCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: announcementsMetricsDictionary, views: announcementsViewsDictionary)
        
        self.announcementsView.addConstraints(horizontalannouncementsConstraints)
        self.announcementsView.addConstraints(horizontalAnnouncementsCollectionViewConstraints)
        self.announcementsView.addConstraints(verticalLeftannouncementsConstraints)
        self.announcementsView.addConstraints(verticalRightannouncementsConstraints)        
        
        // challengeOnDeckView initiation and layout
        
        self.challengeOnDeckLabel = UILabel(frame: CGRectZero)
        self.challengeOnDeckLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckLabel.text = "Challenge Highlight"
        self.challengeOnDeckLabel.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckLabel.font = titleFont?.fontWithSize(15.0)
        self.challengeOnDeckLabel.numberOfLines = 1
        self.challengeOnDeckView.addSubview(self.challengeOnDeckLabel)
        
        self.challengeOnDeckHeaderSeparator = UIView(frame: CGRectZero)
        self.challengeOnDeckHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.challengeOnDeckView.addSubview(self.challengeOnDeckHeaderSeparator)
        
        self.challengeOnDeckCard = UIView(frame: CGRectZero)
        self.challengeOnDeckCard.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckView.addSubview(self.challengeOnDeckCard)
        
        var challengeOnDeckViewViewsDictionary = ["challengeOnDeckLabel":self.challengeOnDeckLabel, "challengeOnDeckHeaderSeparator":self.challengeOnDeckHeaderSeparator, "challengeOnDeckView":self.challengeOnDeckView, "challengeOnDeckCard":self.challengeOnDeckCard]
        var challengeOnDeckMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalchallengeOnDeckConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        var horizontalChallengeOnDeckSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckHeaderSeparator]-0-|", options: NSLayoutFormatOptions(0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        var horizontalChallengeOnDeckViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckCard]-0-|", options: NSLayoutFormatOptions(0), metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        var verticalLeftchallengeOnDeckConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[challengeOnDeckLabel]-2-[challengeOnDeckHeaderSeparator(1)]-18-[challengeOnDeckCard]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: challengeOnDeckMetricsDictionary, views: challengeOnDeckViewViewsDictionary)
        
        self.challengeOnDeckView.addConstraints(horizontalchallengeOnDeckConstraints)
        self.challengeOnDeckView.addConstraints(horizontalChallengeOnDeckSeparatorConstraints)
        self.challengeOnDeckView.addConstraints(horizontalChallengeOnDeckViewConstraints)
        self.challengeOnDeckView.addConstraints(verticalLeftchallengeOnDeckConstraints)

        
//        self.challengeOnDeckTagLabel = UILabel(frame: CGRectZero)
//        self.challengeOnDeckTagLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.challengeOnDeckTagLabel.textAlignment = NSTextAlignment.Left
//        self.challengeOnDeckTagLabel.textColor = UIColor.whiteColor()
//        self.challengeOnDeckTagLabel.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
//        self.challengeOnDeckTagLabel.layer.cornerRadius = 5
//        self.challengeOnDeckTagLabel.clipsToBounds = true
//        self.challengeOnDeckTagLabel.font = self.regularFont?.fontWithSize(14.0)
//        self.challengeOnDeckTagLabel.text = "  Nearby  "
//        self.challengeOnDeckCard.addSubview(self.challengeOnDeckTagLabel)
        
        self.challengeOnDeckTitle = UILabel(frame: CGRectZero)
        self.challengeOnDeckTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckTitle.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckTitle.textColor = UIColor.blackColor()
        self.challengeOnDeckTitle.font = self.titleFont?.fontWithSize(15.0)
        self.challengeOnDeckTitle.text = "God's Love We Deliver is nearby"
        self.challengeOnDeckTitle.numberOfLines = 0
        self.challengeOnDeckTitle.preferredMaxLayoutWidth = self.view.bounds.width - 38
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckTitle)
        
        self.challengeOnDeckInstruction = UILabel(frame: CGRectZero)
        self.challengeOnDeckInstruction.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckInstruction.textAlignment = NSTextAlignment.Left
        self.challengeOnDeckInstruction.textColor = UIColor.blackColor()
        self.challengeOnDeckInstruction.font = self.regularFont?.fontWithSize(14.0)
        self.challengeOnDeckInstruction.numberOfLines = 0
        self.challengeOnDeckInstruction.text = "Now would be a good time to schedule for your volunteer shift."
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckInstruction)
        
        self.challengeOnDeckChevronButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.challengeOnDeckChevronButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.challengeOnDeckChevronButton.setImage(UIImage(named:"chevron-icon"), forState: UIControlState.Normal)
        self.challengeOnDeckCard.addSubview(self.challengeOnDeckChevronButton)
        
        // challengeOnDeckCard layout
        
        var challengeOnDeckCardViewsDictionary = ["challengeOnDeckTitle":self.challengeOnDeckTitle, "challengeOnDeckInstruction":self.challengeOnDeckInstruction, "challengeOnDeckChevronButton":self.challengeOnDeckChevronButton]
        var challengeOnDeckCardMetricsDictionary = ["shortVerticalMargin":10]
        
        
        var horizontalTitleChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckTitle]-[challengeOnDeckChevronButton(20)]-5-|", options: NSLayoutFormatOptions(0), metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        var horizontalInstructionChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[challengeOnDeckInstruction]-[challengeOnDeckChevronButton(20)]-5-|", options: NSLayoutFormatOptions(0), metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        var verticalChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[challengeOnDeckTitle]-3-[challengeOnDeckInstruction]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)
        
        var verticalRightChallengeOnDeckCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[challengeOnDeckChevronButton(20)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: challengeOnDeckCardMetricsDictionary, views: challengeOnDeckCardViewsDictionary)

        
        self.challengeOnDeckCard.addConstraints(horizontalTitleChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(verticalChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(horizontalInstructionChallengeOnDeckCardConstraints)
        self.challengeOnDeckCard.addConstraints(verticalRightChallengeOnDeckCardConstraints)
        
        // inspiration initiation and layout

        self.inspirationLabel = UILabel(frame: CGRectZero)
        self.inspirationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationLabel.text = "Inspiration"
        self.inspirationLabel.textAlignment = NSTextAlignment.Left
        self.inspirationLabel.font = titleFont?.fontWithSize(15.0)
        self.inspirationLabel.numberOfLines = 1
        self.inspirationView.addSubview(self.inspirationLabel)
        
        self.inspirationHeaderSeparator = UILabel(frame: CGRectZero)
        self.inspirationHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.inspirationView.addSubview(self.inspirationHeaderSeparator)
        
        self.inspirationCard = UIView(frame: CGRectZero)
        self.inspirationCard.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationView.addSubview(self.inspirationCard)
        
        var inspirationViewsDictionary = ["inspirationLabel":self.inspirationLabel, "inspirationHeaderSeparator":self.inspirationHeaderSeparator, "inspirationCard":self.inspirationCard]
        var inspirationMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalinspirationConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        var horizontalInspirationSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationHeaderSeparator]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)

        var horizontalInspirationCardViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationCard]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        var verticalLeftinspirationConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[inspirationLabel]-2-[inspirationHeaderSeparator(1)]-15-[inspirationCard]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: inspirationMetricsDictionary, views: inspirationViewsDictionary)
        
        
        self.inspirationView.addConstraints(horizontalInspirationCardViewConstraints)
        self.inspirationView.addConstraints(horizontalinspirationConstraints)
        self.inspirationView.addConstraints(horizontalInspirationSeparatorConstraints)
        self.inspirationView.addConstraints(verticalLeftinspirationConstraints)

        
        
//        var inspirationViewViewsDictionary = ["inspirationCard":self.inspirationCard]
//        var inspirationViewMetricsDictionary = ["zeroMargin":0]
//        
//        var horizontalInspirationViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-==zeroMargin-[inspirationCard]-==zeroMargin-|", options: NSLayoutFormatOptions(0), metrics: inspirationViewMetricsDictionary, views: inspirationViewViewsDictionary)
//        
//        var verticalInspirationViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-==zeroMargin-[inspirationCard]-==zeroMargin-|", options: NSLayoutFormatOptions(0), metrics: inspirationViewMetricsDictionary, views: inspirationViewViewsDictionary)
//        
//        self.inspirationView.addConstraints(horizontalInspirationViewConstraints)
//        self.inspirationView.addConstraints(verticalInspirationViewConstraints)
        
        
        self.inspirationContentLabel = UILabel(frame: CGRectZero)
        self.inspirationContentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationContentLabel.textAlignment = NSTextAlignment.Left
        self.inspirationContentLabel.textColor = UIColor.blackColor()
//        self.inspirationContentLabel.font = self.regularFont?.fontWithSize(14.0)
        self.inspirationContentLabel.font = UIFont(name: "HelveticaNeue-LightItalic", size: 15.0)
        self.inspirationContentLabel.numberOfLines = 0
        self.inspirationContentLabel.text = "If you want to change the future, start living as if you're already there."
        self.inspirationCard.addSubview(self.inspirationContentLabel)
        
        self.inspirationAuthorAvatarImageView = UIImageView(frame: CGRectZero)
        self.inspirationAuthorAvatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
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
        self.inspirationAuthorNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationAuthorNameLabel.textAlignment = NSTextAlignment.Left
        self.inspirationAuthorNameLabel.textColor = UIColor.blackColor()
        self.inspirationAuthorNameLabel.font = self.titleFont?.fontWithSize(14.0)
        self.inspirationAuthorNameLabel.text = "Lynn Conway"
        self.inspirationCard.addSubview(self.inspirationAuthorNameLabel)
        
        self.inspirationAuthorRoleLabel = UILabel(frame: CGRectZero)
        self.inspirationAuthorRoleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationAuthorRoleLabel.textAlignment = NSTextAlignment.Left
        self.inspirationAuthorRoleLabel.textColor = UIColor.blackColor()
        self.inspirationAuthorRoleLabel.font = self.regularFont?.fontWithSize(14.0)
        self.inspirationAuthorRoleLabel.preferredMaxLayoutWidth = self.view.bounds.width - 90
        self.inspirationAuthorRoleLabel.text = "Professor at University of Michigan"
        self.inspirationAuthorRoleLabel.numberOfLines = 0
        self.inspirationCard.addSubview(self.inspirationAuthorRoleLabel)
        
        self.inspirationReadMoreButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.inspirationReadMoreButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inspirationReadMoreButton.tintColor = UIColor.blackColor()
        self.inspirationReadMoreButton.layer.borderColor = UIColor.blackColor().CGColor
        self.inspirationReadMoreButton.layer.borderWidth = 1
        self.inspirationReadMoreButton.layer.cornerRadius = 5
        self.inspirationReadMoreButton.setTitle("Read Lynn's Story", forState: UIControlState.Normal)
        self.inspirationReadMoreButton.titleLabel!.font = UIFont(name: "UIFontTextStyleHeadline", size: CGFloat(30.0))
        self.inspirationCard.addSubview(self.inspirationReadMoreButton)

        
        var inspirationCardViewsDictionary = ["inspirationContentLabel":self.inspirationContentLabel, "inspirationAuthorAvatarImageView":self.inspirationAuthorAvatarImageView, "inspirationAuthorNameLabel":self.inspirationAuthorNameLabel, "inspirationAuthorRoleLabel":self.inspirationAuthorRoleLabel, "inspirationReadMoreButton":self.inspirationReadMoreButton]
        
        var inspirationCardMetricsDictionary = ["shortVerticalMargin":8]
        
//        var horizontalInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationContentLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        var horizontalInspirationCardBylineConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationAuthorAvatarImageView(60)]-14-[inspirationContentLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        var horizontalInspirationCardReadMoreButtonConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inspirationReadMoreButton]-0-|", options: NSLayoutFormatOptions(0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        var verticalLeftInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[inspirationAuthorAvatarImageView(60)]->=20-[inspirationReadMoreButton(40)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        var verticalLeftSecondInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[inspirationContentLabel]-12-[inspirationAuthorNameLabel]-0-[inspirationAuthorRoleLabel]", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        var verticalLeftThirdInspirationCardConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[inspirationAuthorRoleLabel]->=24-[inspirationReadMoreButton(40)]", options: NSLayoutFormatOptions(0), metrics: inspirationCardMetricsDictionary, views: inspirationCardViewsDictionary)
        
        self.inspirationCard.addConstraints(horizontalInspirationCardReadMoreButtonConstraints)
//        self.inspirationCard.addConstraints(horizontalInspirationCardConstraints)
        self.inspirationCard.addConstraints(horizontalInspirationCardBylineConstraints)
        self.inspirationCard.addConstraints(verticalLeftInspirationCardConstraints)
        self.inspirationCard.addConstraints(verticalLeftSecondInspirationCardConstraints)
        self.inspirationCard.addConstraints(verticalLeftThirdInspirationCardConstraints)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutBarButtonItemTapped(sender: UIBarButtonItem) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        self.performSegueWithIdentifier("LoggedOut", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoggedOut"){
            var vc:LoginViewController = segue.destinationViewController.childViewControllers[0] as LoginViewController
            vc.showTutorial = false
            vc.scrollViewHidden = false
        }
    }
    
    func myProfileTapped(){
        self.performSegueWithIdentifier("showMyProfile", sender: self)
    }
    
    func myProgressTapped(){
        self.performSegueWithIdentifier("showMyProgress", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.announcementsPageControl.numberOfPages = 3
        return 3
    }
    
    func scrollViewDidEndDecelerating(scrollView: UICollectionView) {
        var currentPage:CGFloat = self.announcementsCollectionView.contentOffset.x / self.announcementsCollectionView.frame.size.width
        self.announcementsPageControl.currentPage = Int(ceil(Float(currentPage)))
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardAnnouncementsCollectionViewCell", forIndexPath: indexPath) as DashboardAnnouncementsCollectionViewCell
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

}
