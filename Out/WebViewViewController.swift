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
    var url:NSURL!
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var req = NSURLRequest(URL:self.url)
        self.webView!.loadRequest(req)
        
    }
}
