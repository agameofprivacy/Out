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
    let nextStepButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
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
        self.canvasTableView.registerClass(TextBlockTableViewCell.self, forCellReuseIdentifier: "TextBlockTableViewCell")
        self.canvasTableView.registerClass(GallerySelectTableViewCell.self, forCellReuseIdentifier: "GallerySelectTableViewCell")
        self.canvasTableView.separatorStyle = .None
        self.canvasTableView.dataSource = self
        self.canvasTableView.delegate = self
        self.canvasTableView.rowHeight = UITableViewAutomaticDimension
        self.canvasTableView.estimatedRowHeight = 200
        contentView.addSubview(canvasTableView)
        
        self.nextStepButton.frame = CGRectMake(self.bounds.origin.x + cardInset, self.bounds.origin.y + cardInset + 30 + 2 + 30 + 8 + (self.bounds.height - 164) + 20, self.bounds.width - cardInset * 2, 40)
        self.nextStepButton.setTitle("Next Step", forState: UIControlState.Normal)
        self.nextStepButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.nextStepButton.titleLabel!.font = UIFont(name: "UIFontTextStyleHeadline", size: CGFloat(30.0))
        self.nextStepButton.userInteractionEnabled = true
        self.nextStepButton.layer.borderWidth = 1
        self.nextStepButton.layer.borderColor = UIColor.blackColor().CGColor
        self.nextStepButton.layer.cornerRadius = 6

        contentView.addSubview(nextStepButton)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.item % 2 == 0{
            var cell:MediaAvailabilityTableViewCell = tableView.dequeueReusableCellWithIdentifier("MediaAvailabilityTableViewCell") as MediaAvailabilityTableViewCell
            cell.mediaTitle.text = "The Normal Heart"
            cell.mediaTimes.text = "2:10pm 7:00pm 9:30pm 2:10pm 7:00pm 9:30pm"
            cell.mediaVenue.text = "HBO"
            cell.mediaPreview.image = UIImage(named: "ruffalonormalheart")
            return cell
        }
    
        var cell:TextBlockTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextBlockTableViewCell") as TextBlockTableViewCell
        cell.textBlock.text = "The Normal Heart depicts the rise of the HIV-AIDS crisis in New York City (among gay people) between 1981 and 1984, as seen through the eyes of writer/activist Ned Weeks, the founder of a prominent HIV advocacy group. Weeks prefers public confrontations to the calmer, more private strategies favored by his associates, friends, and closeted lover Felix Turner (Bomer). Their differences of opinion lead to arguments that threaten to undermine their shared goals."
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }

}
