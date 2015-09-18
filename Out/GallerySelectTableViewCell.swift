//
//  GallerySelectTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/17/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class GallerySelectTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, CollectStepData {

    var galleryCollectionView:UICollectionView!
    var galleryPageControl:UIPageControl!
    let layout = GallerySelectCollectionViewFlowLayout()
    var itemType:String!
    var itemTitles:[String]!
    var itemImages:[String]!
    var itemBlurbs:[String]!

    var userDataDictionary:[String:String] = ["":""]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clearColor()

        self.galleryCollectionView = UICollectionView(frame: CGRectMake(frame.origin.x, frame.origin.y, UIScreen.mainScreen().bounds.width - 55, UIScreen.mainScreen().bounds.height - 331), collectionViewLayout:layout)
        
        self.galleryCollectionView.registerClass(GallerySelectCollectionViewCell.self, forCellWithReuseIdentifier: "GallerySelectCollectionViewCell")

        self.galleryCollectionView.backgroundColor = UIColor.clearColor()
        self.galleryCollectionView.userInteractionEnabled = true
        self.galleryCollectionView.pagingEnabled = true
        self.galleryCollectionView.alwaysBounceHorizontal = true
        self.galleryCollectionView.directionalLockEnabled = true
        self.galleryCollectionView.tag = 12345 as Int
        self.galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.galleryCollectionView.showsHorizontalScrollIndicator = false
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self

        layout.itemSize = CGSize(width: self.galleryCollectionView.frame.width, height: self.galleryCollectionView.frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        contentView.addSubview(self.galleryCollectionView)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:GallerySelectCollectionViewCell = self.galleryCollectionView.dequeueReusableCellWithReuseIdentifier("GallerySelectCollectionViewCell", forIndexPath: indexPath) as! GallerySelectCollectionViewCell
        cell.titleLabel.text = itemTitles[indexPath.item]
        cell.imageImageView.image = UIImage(named: itemImages[indexPath.item])
        cell.blurbLabel.text = itemBlurbs[indexPath.item]
        self.frame.size = self.galleryCollectionView.contentSize
        userDataDictionary.updateValue("\(indexPath.item)", forKey: "challengeTrack")
        return cell
    }
    
    func collectData() -> [String : String] {
        var galleryItems = self.galleryCollectionView.visibleCells()
        let currentItem = galleryItems[0] as! GallerySelectCollectionViewCell
        let indexPath:NSIndexPath = self.galleryCollectionView.indexPathForCell(currentItem)!
        let galleryNumber:String = "\(indexPath.item + 1)"
        let challengeTrackDictionary:[String:String] = [itemType:galleryNumber]
        return challengeTrackDictionary
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitles.count
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size = self.galleryCollectionView.contentSize
    }
    
}
