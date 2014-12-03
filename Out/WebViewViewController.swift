//
//  WebViewViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/28/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, UIWebViewDelegate {

    
    var webView:UIWebView!
    var toolBar:UIToolbar!
    var navBar:UINavigationBar!
    var url:NSURL!
    var navigationBarItem:UINavigationItem!
    let bottomMargin = 50
    
    override func loadView() {
        super.loadView()

        webView = UIWebView(frame: self.view.frame)
        webView.delegate = self
        webView.scalesPageToFit = true
        var closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneWithView")
        closeButton.enabled = true
        closeButton.tintColor = UIColor.blackColor()
        
        self.navigationItem.rightBarButtonItem = closeButton
        
        var backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        backButton.tintColor = UIColor.blackColor()
        
        var reloadButton = UIBarButtonItem(title: "Reload", style: UIBarButtonItemStyle.Plain, target: self, action: "reload")
        reloadButton.tintColor = UIColor.blackColor()
        
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        self.toolbarItems = [backButton,flexibleSpace,reloadButton]
        self.navigationItem.title = "Loading..."
        self.view = webView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var req = NSURLRequest(URL:self.url)
        self.webView!.loadRequest(req)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.navigationItem.title = self.webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
    
    func doneWithView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func back(){
        self.webView.goBack()
    }
    
    func reload(){
        self.webView.reload()
    }
}
