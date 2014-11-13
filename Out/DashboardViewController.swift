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
    
    var myProfileView:UIView!
    var avatarImageView:UIImageView!
    var myProfileLabel:UILabel!
    var currentUserLabel:UILabel!
    
    var profileProgressSeparator:UIView!
    
    var myProgressView:UIView!
    var myProgressLabel:UILabel!
    var myProgressPieChart:PNPieChart!
    
    var currentChallengesView:UIView!
    var currentChallengesLabel:UILabel!
    var currentChallengesHeaderSeparator:UIView!
    var currentChallengesPageControl:UIPageControl!
    var currentChallengesCollectionView:UICollectionView!
    var currentChallengesLayout = DashboardCurrentChallengesCollectionViewFlowLayout()
    
    var whatsNewView:UIView!
    var whatsNewLabel:UILabel!
    var whatsNewHeaderSeparator:UIView!
    var whatsNewPageControl:UIPageControl!
    var whatsNewCollectionView:UICollectionView!
    var whatsNewLayout = DashboardWhatsNewCollectionViewFlowLayout()
    
    var triviaView:UIView!
    var triviaLabel:UILabel!
    var triviaHeaderSeparator:UILabel!
    var triviaPageControl:UIPageControl!
    var triviaCollectionView:UICollectionView!
    var triviaLayout = DashboardTriviaCollectionViewFlowLayout()

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
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        self.view = self.scrollView
        
        // container views initiation and layout
        
        self.profileProgressView = UIView(frame: CGRectZero)
        self.profileProgressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.profileProgressView)
        
        self.currentChallengesView = UIView(frame: CGRectZero)
        self.currentChallengesView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.currentChallengesView)
        
        self.whatsNewView = UIView(frame: CGRectZero)
        self.whatsNewView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.whatsNewView)

        self.triviaView = UIView(frame: CGRectZero)
        self.triviaView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scrollView.addSubview(self.triviaView)
        
        var containerViewsDictionary = ["profileProgressView":self.profileProgressView, "currentChallengesView":self.currentChallengesView, "whatsNewView":self.whatsNewView, "triviaView":self.triviaView]
        var containerMetricsDictionary = ["sideMargin": 12, "topMargin":30, "bottomMargin":30]
        
        var horizontalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[profileProgressView]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        var verticalContainerViewsConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[profileProgressView]->=35-[whatsNewView]->=20-[currentChallengesView]->=20-[triviaView]-bottomMargin-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: containerMetricsDictionary, views: containerViewsDictionary)
        
        self.scrollView.addConstraints(horizontalContainerViewsConstraints)
        self.scrollView.addConstraints(verticalContainerViewsConstraints)
        

        // Profile Progress View Sub-containers Initiation and Layout

        self.myProfileView = UIView(frame: CGRectZero)
        self.myProfileView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProfileTapped")
        self.myProfileView.addGestureRecognizer(profileTapGestureRecognizer)
        self.profileProgressView.addSubview(self.myProfileView)
        
        self.profileProgressSeparator = UIView(frame: CGRectZero)
        self.profileProgressSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.profileProgressSeparator.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.profileProgressView.addSubview(self.profileProgressSeparator)
        
        self.myProgressView = UIView(frame: CGRectZero)
        self.myProgressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var progressTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myProgressTapped")
        self.myProgressView.addGestureRecognizer(progressTapGestureRecognizer)
        self.profileProgressView.addSubview(self.myProgressView)
        
        var profileProgressSubcontainersViewsDictionary = ["myProfileView":self.myProfileView, "profileProgressSeparator":self.profileProgressSeparator, "myProgressView":self.myProgressView]
        var profileProgressSubcontainersMetricsDictionary = ["sideMargin":21]
        
        var horizontalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProfileView]->=sideMargin-[profileProgressSeparator(1)]->=sideMargin-[myProgressView]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        var verticalProfileProgressConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressView]-0-|", options: NSLayoutFormatOptions(0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        var verticalProfileProgressSeparatorConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[profileProgressSeparator]-0-|", options: NSLayoutFormatOptions(0), metrics: profileProgressSubcontainersMetricsDictionary, views: profileProgressSubcontainersViewsDictionary)
        
        self.profileProgressView.addConstraints(horizontalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressConstraints)
        self.profileProgressView.addConstraints(verticalProfileProgressSeparatorConstraints)
        
        
        // Profile View Initiation and Layout
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.avatarImageView.layer.cornerRadius = 35
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = self.avatarImageDictionary[PFUser.currentUser()["avatar"] as String]!
        self.avatarImageView.backgroundColor = self.colorDictionary[PFUser.currentUser()["color"] as String]
        self.myProfileView.addSubview(self.avatarImageView)
        
        self.myProfileLabel = UILabel(frame: CGRectZero)
        self.myProfileLabel.text = "My\nProfile"
        self.myProfileLabel.numberOfLines = 0
        self.myProfileLabel.textAlignment = NSTextAlignment.Left
        self.myProfileLabel.font = regularFont?.fontWithSize(20.0)
        self.myProfileLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.myProfileView.addSubview(self.myProfileLabel)

        self.currentUserLabel = UILabel(frame: CGRectZero)
        self.currentUserLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentUserLabel.text = PFUser.currentUser().username
        self.currentUserLabel.font = regularFont?.fontWithSize(13.0)
        self.currentUserLabel.textAlignment = NSTextAlignment.Left
        self.myProfileView.addSubview(self.currentUserLabel)
        
        var myProfileViewViewsDictionary = ["avatarImageView":self.avatarImageView, "myProfileLabel":self.myProfileLabel, "currentUserLabel":self.currentUserLabel]
        var myProfileViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[avatarImageView(70)]-inBetweenPadding-[myProfileLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        var verticalLeftMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[avatarImageView(70)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        var verticalRightMyProfileViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProfileLabel]-2-[currentUserLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProfileViewMetricsDictionary, views: myProfileViewViewsDictionary)
        
        self.myProfileView.addConstraints(horizontalMyProfileViewConstraints)
        self.myProfileView.addConstraints(verticalLeftMyProfileViewConstraints)
        self.myProfileView.addConstraints(verticalRightMyProfileViewConstraints)
        
        // myProgressView Initialization and Layout
        
        self.myProgressLabel = UILabel(frame: CGRectZero)
        self.myProgressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.myProgressLabel.text = "My\nRecords"
        self.myProgressLabel.textAlignment = NSTextAlignment.Left
        self.myProgressLabel.font = regularFont?.fontWithSize(20.0)
        self.myProgressLabel.numberOfLines = 0
        self.myProgressView.addSubview(self.myProgressLabel)
        
        var items:NSArray = [PNPieChartDataItem(value: 0.3, color: self.colorDictionary["intermediateYellow"],description: ""), PNPieChartDataItem(value: 0.3, color: self.colorDictionary["intenseRed"],description: ""),PNPieChartDataItem(value: 0.4, color: self.colorDictionary["casualGreen"],description: "")]
        self.myProgressPieChart = PNPieChart(frame: CGRectMake(0, 0, 70, 70), items: items)
        self.myProgressPieChart.strokeChart()
        self.myProgressView.addSubview(self.myProgressPieChart)

        
        var myProgressViewViewsDictionary = ["myProgressLabel":self.myProgressLabel, "myProgressPieChart":self.myProgressPieChart]
        var myProgresssViewMetricsDictionary = ["inBetweenPadding":18]
        
        var horizontalMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[myProgressPieChart(70)]-inBetweenPadding-[myProgressLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        var verticalLeftMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[myProgressPieChart(70)]-0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        var verticalRightMyProgressViewConstraint:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[myProgressLabel]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: myProgresssViewMetricsDictionary, views: myProgressViewViewsDictionary)
        
        self.myProgressView.addConstraints(horizontalMyProgressViewConstraint)
        self.myProgressView.addConstraints(verticalLeftMyProgressViewConstraint)
        self.myProgressView.addConstraints(verticalRightMyProgressViewConstraint)
        
        // currentChallengesView initiation and layout
        
        self.currentChallengesLabel = UILabel(frame: CGRectZero)
        self.currentChallengesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentChallengesLabel.text = "Challenges on Deck"
        self.currentChallengesLabel.textAlignment = NSTextAlignment.Left
        self.currentChallengesLabel.font = regularFont?.fontWithSize(16.0)
        self.currentChallengesLabel.numberOfLines = 1
        self.currentChallengesView.addSubview(self.currentChallengesLabel)
        
        self.currentChallengesHeaderSeparator = UIView(frame: CGRectZero)
        self.currentChallengesHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentChallengesHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.currentChallengesView.addSubview(self.currentChallengesHeaderSeparator)
        
        self.currentChallengesPageControl = UIPageControl(frame: CGRectZero)
        self.currentChallengesPageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentChallengesPageControl.hidesForSinglePage = true
        self.currentChallengesPageControl.backgroundColor = UIColor.clearColor()
        self.currentChallengesPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        self.currentChallengesPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        self.currentChallengesPageControl.userInteractionEnabled = false
        self.currentChallengesPageControl.numberOfPages = 0
        self.currentChallengesView.addSubview(self.currentChallengesPageControl)
        
        
        self.currentChallengesCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.currentChallengesLayout)
        self.currentChallengesLayout.itemSize = CGSizeMake(self.view.frame.size.width - 40.0, 140)
        self.currentChallengesLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.currentChallengesCollectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.currentChallengesCollectionView.backgroundColor = UIColor.clearColor()
        self.currentChallengesCollectionView.dataSource = self
        self.currentChallengesCollectionView.delegate = self
        self.currentChallengesCollectionView.pagingEnabled = true
        self.currentChallengesCollectionView.alwaysBounceHorizontal = true
        self.currentChallengesCollectionView.showsHorizontalScrollIndicator = false
        self.currentChallengesCollectionView.registerClass(DashboardCurrentChallengesCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardCurrentChallengesCollectionViewCell")
        self.currentChallengesView.addSubview(self.currentChallengesCollectionView)
        
        var currentChallengesViewViewsDictionary = ["currentChallengesLabel":self.currentChallengesLabel, "currentChallengesHeaderSeparator":self.currentChallengesHeaderSeparator, "currentChallengesPageControl":self.currentChallengesPageControl, "currentChallengesCollectionView":self.currentChallengesCollectionView]
        var currentChallengesMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalCurrentChallengesConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[currentChallengesLabel]-[currentChallengesPageControl]-0-|", options: NSLayoutFormatOptions(0), metrics: currentChallengesMetricsDictionary, views: currentChallengesViewViewsDictionary)
        
        var verticalLeftCurrentChallengesConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[currentChallengesLabel]-2-[currentChallengesHeaderSeparator(1)]-10-[currentChallengesCollectionView(150)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: currentChallengesMetricsDictionary, views: currentChallengesViewViewsDictionary)
        
        var verticalRightCurrentChallengesConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[currentChallengesPageControl(18)]-2-[currentChallengesHeaderSeparator(1)]-10-[currentChallengesCollectionView(150)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: currentChallengesMetricsDictionary, views: currentChallengesViewViewsDictionary)
        
        self.currentChallengesView.addConstraints(horizontalCurrentChallengesConstraints)
        self.currentChallengesView.addConstraints(verticalLeftCurrentChallengesConstraints)
        self.currentChallengesView.addConstraints(verticalRightCurrentChallengesConstraints)
        
        // whatsNewView initialization and layout
        
        self.whatsNewLabel = UILabel(frame: CGRectZero)
        self.whatsNewLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.whatsNewLabel.text = "What's New"
        self.whatsNewLabel.textAlignment = NSTextAlignment.Left
        self.whatsNewLabel.font = regularFont?.fontWithSize(16.0)
        self.whatsNewLabel.numberOfLines = 1
        self.whatsNewView.addSubview(self.whatsNewLabel)
        
        self.whatsNewHeaderSeparator = UIView(frame: CGRectZero)
        self.whatsNewHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.whatsNewHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.whatsNewView.addSubview(self.whatsNewHeaderSeparator)
        
        self.whatsNewPageControl = UIPageControl(frame: CGRectZero)
        self.whatsNewPageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.whatsNewPageControl.hidesForSinglePage = true
        self.whatsNewPageControl.backgroundColor = UIColor.clearColor()
        self.whatsNewPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        self.whatsNewPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        self.whatsNewPageControl.userInteractionEnabled = false
        self.whatsNewPageControl.numberOfPages = 0
        self.whatsNewView.addSubview(whatsNewPageControl)
        
        self.whatsNewCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.whatsNewLayout)
        self.whatsNewLayout.itemSize = CGSizeMake(self.view.frame.size.width - 40.0, 54)
        self.whatsNewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.whatsNewCollectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.whatsNewCollectionView.showsHorizontalScrollIndicator = false
        self.whatsNewCollectionView.pagingEnabled = true
        self.whatsNewCollectionView.alwaysBounceHorizontal = true
        self.whatsNewCollectionView.delegate = self
        self.whatsNewCollectionView.dataSource = self
        self.whatsNewCollectionView.backgroundColor = UIColor.clearColor()
        self.whatsNewCollectionView.registerClass(DashboardWhatsNewCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardWhatsNewCollectionViewCell")
        self.whatsNewView.addSubview(self.whatsNewCollectionView)

        var whatsNewViewsDictionary = ["whatsNewLabel":self.whatsNewLabel, "whatsNewHeaderSeparator":self.whatsNewHeaderSeparator, "whatsNewPageControl":self.whatsNewPageControl, "whatsNewCollectionView":self.whatsNewCollectionView]
        var whatsNewMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalWhatsNewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[whatsNewLabel]-[whatsNewPageControl]-0-|", options: NSLayoutFormatOptions(0), metrics: whatsNewMetricsDictionary, views: whatsNewViewsDictionary)
        
        var verticalLeftWhatsNewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[whatsNewLabel]-2-[whatsNewHeaderSeparator(1)]-15-[whatsNewCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: whatsNewMetricsDictionary, views: whatsNewViewsDictionary)
        
        var verticalRightWhatsNewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[whatsNewPageControl(18)]-2-[whatsNewHeaderSeparator(1)]-15-[whatsNewCollectionView(60)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: whatsNewMetricsDictionary, views: whatsNewViewsDictionary)
        
        self.whatsNewView.addConstraints(horizontalWhatsNewConstraints)
        self.whatsNewView.addConstraints(verticalLeftWhatsNewConstraints)
        self.whatsNewView.addConstraints(verticalRightWhatsNewConstraints)        
        
        
        // Trivia initiation and layout

        self.triviaLabel = UILabel(frame: CGRectZero)
        self.triviaLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.triviaLabel.text = "Trivia"
        self.triviaLabel.textAlignment = NSTextAlignment.Left
        self.triviaLabel.font = regularFont?.fontWithSize(16.0)
        self.triviaLabel.numberOfLines = 1
        self.triviaView.addSubview(self.triviaLabel)
        
        self.triviaHeaderSeparator = UILabel(frame: CGRectZero)
        self.triviaHeaderSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.triviaHeaderSeparator.backgroundColor = UIColor.blackColor()
        self.triviaView.addSubview(self.triviaHeaderSeparator)
        
        self.triviaPageControl = UIPageControl(frame: CGRectZero)
        self.triviaPageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.triviaPageControl.hidesForSinglePage = true
        self.triviaPageControl.backgroundColor = UIColor.clearColor()
        self.triviaPageControl.currentPageIndicatorTintColor = UIColor(red:0.2, green: 0.2, blue:0.2, alpha: 1)
        self.triviaPageControl.pageIndicatorTintColor = UIColor(red:0.7, green: 0.7, blue:0.7, alpha: 1)
        self.triviaPageControl.userInteractionEnabled = false
        self.triviaPageControl.numberOfPages = 0
        self.triviaView.addSubview(self.triviaPageControl)
        
        self.triviaCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: triviaLayout)
        self.triviaLayout.itemSize = CGSizeMake(self.view.frame.size.width - 40.0, 140)
        self.triviaLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.triviaCollectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.triviaCollectionView.showsHorizontalScrollIndicator = false
        self.triviaCollectionView.pagingEnabled = true
        self.triviaCollectionView.alwaysBounceHorizontal = true
        self.triviaCollectionView.delegate = self
        self.triviaCollectionView.dataSource = self
        self.triviaCollectionView.backgroundColor = UIColor.clearColor()
        self.triviaCollectionView.registerClass(DashboardTriviaCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardTriviaCollectionViewCell")
        self.triviaView.addSubview(self.triviaCollectionView)

        var triviaViewsDictionary = ["triviaLabel":self.triviaLabel, "triviaHeaderSeparator":self.triviaHeaderSeparator, "triviaPageControl":self.triviaPageControl, "triviaCollectionView":self.triviaCollectionView]
        var triviaMetricsDictionary = ["pageControlRightSideMargin":15]
        
        var horizontalTriviaConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[triviaLabel]-[triviaPageControl]-0-|", options: NSLayoutFormatOptions(0), metrics: triviaMetricsDictionary, views: triviaViewsDictionary)
        
        var verticalLeftTriviaConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[triviaLabel]-2-[triviaHeaderSeparator(1)]-10-[triviaCollectionView(150)]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: triviaMetricsDictionary, views: triviaViewsDictionary)
        
        var verticalRightTriviaConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=0-[triviaPageControl(18)]-2-[triviaHeaderSeparator(1)]-10-[triviaCollectionView(150)]->=0-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: triviaMetricsDictionary, views: triviaViewsDictionary)
        
        self.triviaView.addConstraints(horizontalTriviaConstraints)
        self.triviaView.addConstraints(verticalLeftTriviaConstraints)
        self.triviaView.addConstraints(verticalRightTriviaConstraints)

        
        
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
    
    func myProfileTapped(){
        self.performSegueWithIdentifier("showMyProfile", sender: self)
    }
    
    func myProgressTapped(){
        self.performSegueWithIdentifier("showMyProgress", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.currentChallengesCollectionView{
            self.currentChallengesPageControl.numberOfPages = 3
            return 3
        }
        else if collectionView == self.whatsNewCollectionView{
            self.whatsNewPageControl.numberOfPages = 3
            return 3
        }
        else{
            self.triviaPageControl.numberOfPages = 3
            return 3
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.currentChallengesCollectionView{
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCurrentChallengesCollectionViewCell", forIndexPath: indexPath) as DashboardCurrentChallengesCollectionViewCell
            cell.tagLabel.text = "  Intermediate  "
//            cell.tagLabel.backgroundColor = self.colorDictionary["casualGreen"]
            cell.challengeTitleLabel.text = "Volunteer at an LGBT non-profit"
            cell.currentStepTitleLabel.text = "Step 3: Attend Shift"
            cell.currentStepBlurbLabel.text = "Testing, testing, testing, 123"
            return cell

        }
        else if collectionView == self.whatsNewCollectionView{
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardWhatsNewCollectionViewCell", forIndexPath: indexPath) as DashboardWhatsNewCollectionViewCell
            cell.avatarImageView.image = self.avatarImageDictionary["rabbit"]!
            cell.avatarImageView.backgroundColor = self.colorDictionary["teal"]
            cell.aliasLabel.text = "ogdog7"
            cell.roleLabel.text = "mentor"
            cell.alertCountLabel.text = "3"
            cell.alertTypeLabel.text = "new messages"
            return cell
        }
        else{
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardTriviaCollectionViewCell", forIndexPath: indexPath) as DashboardTriviaCollectionViewCell
            cell.tagLabel.text = "  Intermediate  "
//            cell.tagLabel.backgroundColor = self.colorDictionary["casualGreen"]
            cell.challengeTitleLabel.text = "Volunteer at an LGBT non-profit"
            cell.currentStepTitleLabel.text = "Step 3: Attend Shift"
            cell.currentStepBlurbLabel.text = "Testing, testing, testing, 123"
            return cell
        }
    }

}
