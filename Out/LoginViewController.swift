//
//  LoginViewController.swift
//  Out
//
//  Created by Eddie Chen on 10/11/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aliasTextField.becomeFirstResponder()
        var currentUser = PFUser.currentUser()
        // Do any additional setup after loading the view.
        if currentUser != nil {
            // Do stuff with the user
        } else {
            // Show the signup or login screen
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(self.aliasTextField.text, password:self.passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("LoggedIn", sender: nil)
            } else {
                // The login failed. Check error to see why.
            }
        }
    }

}
