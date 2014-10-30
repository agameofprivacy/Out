//
//  WebViewViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/28/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    var webView:WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string:"http://www.hrc.org/")
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
        
    }
}
