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
    let nextStepButton:UIButton!
    
    let cardInset:CGFloat = 20
    
//    let titleLabel:UILabel!
//    let reasonLabel:UILabel!
//    let introLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel = UILabel(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset, self.bounds.size.width - cardInset * 2, 30))
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(titleLabel)
        
        self.titleSeparator = UIView(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30, self.bounds.size.width - cardInset * 2, 2))
        self.titleSeparator.backgroundColor = UIColor.blackColor()
        contentView.addSubview(titleSeparator)
        
        self.subtitleLabel = UILabel(frame:CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2, self.bounds.size.width - cardInset * 2, 30))
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.subtitleLabel.preferredMaxLayoutWidth = self.bounds.width - cardInset
        contentView.addSubview(subtitleLabel)
        
        self.canvasTableView = UITableView(frame: CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2 + 30 + 8, self.bounds.width - cardInset * 2, self.bounds.height - 164), style: UITableViewStyle.Plain)
        self.canvasTableView.backgroundColor = UIColor(red:0.995, green:0.995, blue:0.995, alpha:1)
        self.canvasTableView.showsVerticalScrollIndicator = true
        self.canvasTableView.registerClass(MediaAvailabilityTableViewCell.self, forCellReuseIdentifier: "MediaAvailabilityTableViewCell")
        self.canvasTableView.separatorStyle = .None
        self.canvasTableView.dataSource = self
        self.canvasTableView.delegate = self
        self.canvasTableView.rowHeight = 80
        contentView.addSubview(canvasTableView)
        
        self.nextStepButton = UIButton(frame: CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2 + 30 + 8 + (self.bounds.height - 164) + 20, self.bounds.width - cardInset * 2, 40))
        self.nextStepButton.setTitle("Next Step", forState: UIControlState.Normal)
        self.nextStepButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.nextStepButton.userInteractionEnabled = true
        self.nextStepButton.showsTouchWhenHighlighted = true
        contentView.addSubview(nextStepButton)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var  cell:MediaAvailabilityTableViewCell = tableView.dequeueReusableCellWithIdentifier("MediaAvailabilityTableViewCell") as MediaAvailabilityTableViewCell
        cell.mediaTitle.text = "Hello"
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
