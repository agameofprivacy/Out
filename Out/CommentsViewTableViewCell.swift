//
//  CommentsViewTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 3/27/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class CommentsViewTableViewCell: UITableViewCell {

    var slkView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
//        contentView.addSubview(slkView)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
