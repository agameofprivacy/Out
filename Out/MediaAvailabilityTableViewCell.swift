//
//  MediaAvailabilityTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 10/16/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class MediaAvailabilityTableViewCell: UITableViewCell {

    let mediaPreview:UIImageView!
    let mediaTitle:UILabel!
    let mediaTimes:UILabel!
    let mediaVenue:UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        mediaTitle = UILabel(frame: CGRectMake(80, 10, self.bounds.size.width - 80, 40))
        self.mediaTitle.numberOfLines = 0
        self.mediaTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.mediaTitle.preferredMaxLayoutWidth = self.bounds.width - 10
        contentView.addSubview(mediaTitle)
    }


}
