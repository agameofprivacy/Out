//
//  PeerChatTableViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/22/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class PeerChatTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource, LYRClientDelegate {

    var conversations:NSOrderedSet = NSOrderedSet(array: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var updateConversations = UIRefreshControl()
        self.refreshControl = updateConversations
        self.refreshControl?.addTarget(self, action: "tableViewRefreshed", forControlEvents: UIControlEvents.ValueChanged)
        
        self.navigationItem.title = "Conversations"

        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeChat")
        self.navigationItem.leftBarButtonItem = closeButton
        
        var newChatButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newChat")
        self.navigationItem.rightBarButtonItem = newChatButton
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadConversations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.conversations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Plain")
        cell.textLabel?.text = "Conversation"
        cell.detailTextLabel?.text = "\((self.conversations.objectAtIndex(indexPath.row) as! LYRConversation).participants)"
        return cell
    }
    
    func tableViewRefreshed(){
        self.refreshControl?.beginRefreshing()
        self.loadConversations()
    }
    
    func loadConversations(){
        let query = LYRQuery(`queryableClass`: LYRConversation.self)
        query.resultType = LYRQueryResultType.Objects
        var error:NSError?
        self.conversations = ((UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.executeQuery(query, error: &error))
        if let error = error {
            println("Query failed with error \(error.localizedDescription)")
        }
        else{
            println("Query contains \(conversations.count) conversations")
        }
        for conversation in self.conversations{
            println(conversation.description)
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func closeChat(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func newChat(){
        println("Start New Chat")
        self.performSegueWithIdentifier("showNewChatViewController", sender: self)
    }
    
    // MARK: - LYRClientDelegate
    
    func layerClient(client: LYRClient!, didReceiveAuthenticationChallengeWithNonce nonce: String!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didAuthenticateAsUserID userID: String!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFailOperationWithError error: NSError!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFailSynchronizationWithError error: NSError!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFinishContentTransfer contentTransferType: LYRContentTransferType, ofObject object: AnyObject!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didFinishSynchronizationWithChanges changes: [AnyObject]!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, didLoseConnectionWithError error: NSError!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, objectsDidChange changes: [AnyObject]!) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, willAttemptToConnect attemptNumber: UInt, afterDelay delayInterval: NSTimeInterval, maximumNumberOfAttempts attemptLimit: UInt) {
        println(__FUNCTION__)
    }
    
    func layerClient(client: LYRClient!, willBeginContentTransfer contentTransferType: LYRContentTransferType, ofObject object: AnyObject!, withProgress progress: LYRProgress!) {
        println(__FUNCTION__)
    }
    
    func layerClientDidConnect(client: LYRClient!) {
        println(__FUNCTION__)
    }
    
    func layerClientDidDeauthenticate(client: LYRClient!) {
        println(__FUNCTION__)
    }
    
    func layerClientDidDisconnect(client: LYRClient!) {
        println(__FUNCTION__)
    }

}
