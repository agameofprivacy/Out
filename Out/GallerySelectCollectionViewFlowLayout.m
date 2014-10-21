//
//  GallerySelectCollectionViewFlowLayout.m
//  Out
//
//  Created by Eddie Chen on 10/7/14.
//  Portions of this class was pulled from stackoverflow user Ji Fang
//  at this location:
//  http://stackoverflow.com/questions/13179703/uicollectionview-scrolling-in-both-directions
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

#import "GallerySelectCollectionViewFlowLayout.h"

@implementation GallerySelectCollectionViewFlowLayout



- (CGSize)collectionViewContentSize
{
    // Only support single section for now.
    // Only support Horizontal scroll
    NSUInteger count = [self.collectionView.dataSource collectionView:self.collectionView
                                               numberOfItemsInSection:0];
    CGSize canvasSize = self.collectionView.frame.size;
    CGSize contentSize = canvasSize;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        NSUInteger rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
        NSUInteger columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
        NSUInteger page = ceilf((CGFloat)count / (CGFloat)(rowCount * columnCount));
        contentSize.width = page * canvasSize.width;
        contentSize.height = canvasSize.height;
    }

//    NSLog(@"Content width is %f", contentSize.width);
//    NSLog(@"Content height is %f", contentSize.height);
    return contentSize;
}

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize canvasSize = self.collectionView.frame.size;
    
    //    NSUInteger rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
    NSUInteger rowCount = 1;
    NSUInteger columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
    
    CGFloat pageMarginX =(canvasSize.width - columnCount * self.itemSize.width - (columnCount > 1 ? (columnCount - 1) * self.minimumLineSpacing : 0)) / 2.0f;
    
    CGFloat pageMarginY = (canvasSize.height - rowCount * self.itemSize.height - (rowCount > 1 ? (rowCount - 1) * self.minimumInteritemSpacing : 0)) / 3.0f;
    
    NSUInteger page = indexPath.row / (rowCount * columnCount);
    
    NSUInteger remainder = indexPath.row - page * (rowCount * columnCount);
    NSUInteger row = remainder / columnCount;
    NSUInteger column = remainder - row * columnCount;
    
    CGRect cellFrame = CGRectZero;
    cellFrame.origin.x = pageMarginX + column * (self.itemSize.width + self.minimumLineSpacing);
    cellFrame.origin.y = pageMarginY + row * (self.itemSize.height + self.minimumInteritemSpacing);
    cellFrame.size.width = self.itemSize.width;
    cellFrame.size.height = self.itemSize.height;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        cellFrame.origin.x += page * canvasSize.width;
    }
    
//    NSLog(@"Cell Frame width is %f", cellFrame.size.width);
//    NSLog(@"Cell Frame height is %f", cellFrame.size.height);
//    NSLog(@"Cell Frame x origin is %f", cellFrame.origin.x);
//    NSLog(@"Cell Frame y origin is %f", cellFrame.origin.y);
    
    return cellFrame;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    attr.frame = [self frameForItemAtIndexPath:indexPath];
    return attr;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSUInteger count = [self.collectionView.dataSource collectionView:self.collectionView
                                               numberOfItemsInSection:0];
    
    NSMutableArray * attrs = [NSMutableArray array];
    
    for (NSUInteger idx = 0; idx < count; ++idx)
    {
        UICollectionViewLayoutAttributes * attr = nil;
        NSIndexPath * idxPath = [NSIndexPath indexPathForRow:idx inSection:0];
        CGRect itemFrame = [self frameForItemAtIndexPath:idxPath];
        if (CGRectIntersectsRect(itemFrame, rect))
        {
            attr = [self layoutAttributesForItemAtIndexPath:idxPath];
            [attrs addObject:attr];
        }
    }
    
    return attrs;
}


@end
