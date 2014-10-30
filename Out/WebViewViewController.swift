//
//  WebViewViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/28/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {

    
    var webView:WKWebView!
    var toolBar:UIToolbar!
    var navBar:UINavigationBar!
    var url:NSURL!
    var navigationBarItem:UINavigationItem!
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        toolBar = UIToolbar()
        navBar = UINavigationBar()

        var closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneWithView")
        closeButton.enabled = false
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.title = "Loading..."
        webView.addSubview(toolBar)
        webView.addSubview(navBar)
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var req = NSURLRequest(URL:self.url)
        self.webView!.loadRequest(req)
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        self.navigationItem.title = self.webView.title
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func doneWithView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
