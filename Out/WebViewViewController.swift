//
//  WebViewViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/28/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import WebKit

// ViewController for modal UIWebView
class WebViewViewController: UIViewController, UIWebViewDelegate {

    var webView:UIWebView!
    var toolBar:UIToolbar!
    var navBar:UINavigationBar!

    // URL to open in modal UIWebView
    var url:NSURL!
    
    override func loadView() {
        super.loadView()

        // Initialize UIWebView
        webView = UIWebView(frame: self.view.frame)
        webView.delegate = self
        webView.scalesPageToFit = true
        
        // Initialize closeButton
        var closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneWithView")
        closeButton.enabled = true
        closeButton.tintColor = UIColor.blackColor()
        
        // Place closeButton on UINavigationBar
        self.navigationItem.rightBarButtonItem = closeButton
        
        // Initialize Back button
        var backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        backButton.tintColor = UIColor.blackColor()
        
        // Initialize Reload button
        var reloadButton = UIBarButtonItem(title: "Reload", style: UIBarButtonItemStyle.Plain, target: self, action: "reload")
        reloadButton.tintColor = UIColor.blackColor()
        
        // Initialize flexible space
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        // Place back button, flexible space and reload button on UIToolBar
        self.toolbarItems = [backButton,flexibleSpace,reloadButton]
        
        // Set initial UINavigationBar title to "Loading..."
        self.navigationItem.title = "Loading..."
        
        self.view = webView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize NSURLRequest object with URL
        var req = NSURLRequest(URL:self.url)

        // Load NSURLRequest
        self.webView!.loadRequest(req)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // Update UINavigationBar title with page title once the page is loaded
        self.navigationItem.title = self.webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
    
    // Dismisses modal UIWebView
    func doneWithView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Load previous page
    func back(){
        self.webView.goBack()
    }
    
    // Reload current page
    func reload(){
        self.webView.reload()
    }
}
