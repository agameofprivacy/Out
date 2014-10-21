//
//  GallerySelectTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/17/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class GallerySelectTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    var galleryCollectionView:UICollectionView!
    var galleryPageControl:UIPageControl!
    let layout = GallerySelectCollectionViewFlowLayout()
    var itemTitles:[String]!
    var itemImages:[String]!
    var itemBlurbs:[String]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = UIColor.clearColor()

        self.galleryCollectionView = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width - 64, UIScreen.mainScreen().bounds.height - 331), collectionViewLayout:layout)
        
        self.galleryCollectionView.registerClass(GallerySelectCollectionViewCell.self, forCellWithReuseIdentifier: "GallerySelectCollectionViewCell")

        self.galleryCollectionView.backgroundColor = UIColor.clearColor()
        self.galleryCollectionView.userInteractionEnabled = true
        self.galleryCollectionView.pagingEnabled = true
        self.galleryCollectionView.alwaysBounceHorizontal = true
        self.galleryCollectionView.directionalLockEnabled = true
        
        
        self.galleryCollectionView.showsHorizontalScrollIndicator = false
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self

        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width - 64, height: UIScreen.mainScreen().bounds.height - 331)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal

        contentView.addSubview(self.galleryCollectionView)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:GallerySelectCollectionViewCell = self.galleryCollectionView.dequeueReusableCellWithReuseIdentifier("GallerySelectCollectionViewCell", forIndexPath: indexPath) as GallerySelectCollectionViewCell
        cell.titleLabel.text = itemTitles[indexPath.item]
        cell.imageImageView.image = UIImage(named: itemImages[indexPath.item])
        cell.blurbLabel.text = itemBlurbs[indexPath.item]
        self.frame.size = self.galleryCollectionView.contentSize

        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitles.count
    }


}
