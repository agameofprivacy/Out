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
        
        let confirmButton = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Done, target: self, action: "confirmButtonTapped")
        self.navigationItem.rightBarButtonItem = confirmButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confirmButtonTapped(){
        print("Confirm Button Tapped")
        // Send a Message
        // See "Quick Start - Send a Message" for more details
        // https://developer.layer.com/docs/quick-start/ios#send-a-message
        
        // If no conversations exist, create a new conversation object with a single participant
//        if conversation == nil {
//            var error: NSError?
//            do {
//                conversation = try (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.newConversationWithParticipants(NSSet(array: [LQSParticipantUserID, LQSParticipant2UserID]) as Set<NSObject>, options: nil)
//            } catch let error1 as NSError {
//                error = error1
//                conversation = nil
//            }
//            if conversation == nil {
//                print("New Conversation creation failed: \(error!.localizedDescription)")
//            }
//        }
        let messageText = "test"
        // Creates a message part with text/plain MIME Type
        let messagePart = LYRMessagePart(text: messageText)
        
        // Creates and returns a new message object with the given conversation and array of message parts
        let pushMessage = "\((UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.authenticatedUserID), says, \(messageText)"
        let message: LYRMessage!
        do {
            message = try (UIApplication.sharedApplication().delegate as! AppDelegate).layerClient.newMessageWithParts([messagePart], options: [LYRMessageOptionsPushNotificationAlertKey: pushMessage])
        } catch _ {
            message = nil
        }
        
        // Sends the specified message
        var error: NSError?
        let success: Bool
        do {
            try conversation.sendMessage(message)
            success = true
        } catch let error1 as NSError {
            error = error1
            success = false
        }
        if success {
            // If the message was sent by the participant, show the sentAt time and mark the message as read
            print("Message queued to be sent: \(messageText)")
//            inputTextView.text = ""
        } else {
            print("Message send failed: \(error!.localizedDescription)")
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
