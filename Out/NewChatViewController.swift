//
//  NewChatViewController.swift
//  Out
//
//  Created by Chun-Wei Chen on 6/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController {

    var conversation: LYRConversation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Request"
        
        var confirmButton = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Done, target: self, action: "confirmButtonTapped")
        self.navigationItem.rightBarButtonItem = confirmButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confirmButtonTapped(){
        println("Confirm Button Tapped")
        // Send a Message
        // See "Quick Start - Send a Message" for more details
        // https://developer.layer.com/docs/quick-start/ios#send-a-message
        
        // If no conversations exist, create a new conversation object with a single participant
        if conversation == nil {
            var error: NSError?
            conversation = (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.newConversationWithParticipants(NSSet(array: [LQSParticipantUserID, LQSParticipant2UserID]) as Set<NSObject>, options: nil, error:&error)
            if conversation == nil {
                println("New Conversation creation failed: \(error!.localizedDescription)")
            }
        }
        var messageText = "test"
        // Creates a message part with text/plain MIME Type
        let messagePart = LYRMessagePart(text: messageText)
        
        // Creates and returns a new message object with the given conversation and array of message parts
        let pushMessage = "\((UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.authenticatedUserID), says, \(messageText)"
        let message = (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.newMessageWithParts([messagePart], options: [LYRMessageOptionsPushNotificationAlertKey: pushMessage], error: nil)
        
        // Sends the specified message
        var error: NSError?
        let success = conversation.sendMessage(message, error: &error)
        if success {
            // If the message was sent by the participant, show the sentAt time and mark the message as read
            println("Message queued to be sent: \(messageText)")
//            inputTextView.text = ""
        } else {
            println("Message send failed: \(error!.localizedDescription)")
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
