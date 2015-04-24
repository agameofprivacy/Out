//
//  WebViewTableViewCell.swift
//  Out
//
//  Created by Eddie Chen on 3/27/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class WebViewTableViewCell: UITableViewCell, UIWebViewDelegate {

    var webView:UIWebView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.webView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 473))
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        self.webView.hidden = false
        self.webView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        self.webView.scrollView.scrollEnabled = false
        self.webView.scrollView.bounces = true
        contentView.addSubview(self.webView)
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.hidden = false
    }
    
}
