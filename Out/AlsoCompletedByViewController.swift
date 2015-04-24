//
//  AlsoCompletedByViewController.swift
//  Out
//
//  Created by Eddie Chen on 4/1/15.
//  Copyright (c) 2015 Coming Out App. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class AlsoCompletedByViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:TPKeyboardAvoidingTableView!
    var completedByPeople:[PFUser] = []
    var challenge:PFObject!
    var user:PFUser!
    
    let colorDictionary =
    [
        "orange":UIColor(red: 255/255, green: 97/255, blue: 27/255, alpha: 1),
        "brown":UIColor(red: 139/255, green: 87/255, blue: 42/255, alpha: 1),
        "teal":UIColor(red: 34/255, green: 200/255, blue: 165/255, alpha: 1),
        "purple":UIColor(red: 140/255, green: 76/255, blue: 233/255, alpha: 1),
        "pink":UIColor(red: 252/255, green: 52/255, blue: 106/255, alpha: 1),
        "lightBlue":UIColor(red: 30/255, green: 169/255, blue: 238/255, alpha: 1),
        "yellowGreen":UIColor(red: 211/255, green: 206/255, blue: 52/255, alpha: 1),
        "vibrantBlue":UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1),
        "vibrantGreen":UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    ]
    
    let avatarImageDictionary =
    [
        "elephant":UIImage(named: "elephant-icon"),
        "snake":UIImage(named: "snake-icon"),
        "butterfly":UIImage(named: "butterfly-icon"),
        "snail":UIImage(named: "snail-icon"),
        "horse":UIImage(named: "horse-icon"),
        "bird":UIImage(named: "bird-icon"),
        "turtle":UIImage(named: "turtle-icon"),
        "sheep":UIImage(named: "sheep-icon"),
        "bear":UIImage(named: "bear-icon"),
        "littleBird":UIImage(named: "littleBird-icon"),
        "dog":UIImage(named: "dog-icon"),
        "rabbit":UIImage(named: "rabbit-icon"),
        "caterpillar":UIImage(named: "caterpillar-icon"),
        "crab":UIImage(named: "crab-icon"),
        "fish":UIImage(named: "fish-icon"),
        "cat":UIImage(named: "cat-icon")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Completed By"
        // Do any additional setup after loading the view.
        
        var sortButton = UIBarButtonItem(title: "Sort", style: UIBarButtonItemStyle.Plain, target: self, action: "sortPeople")
        sortButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = sortButton

        
        self.tableView = TPKeyboardAvoidingTableView(frame: self.view.frame, style: UITableViewStyle.Plain)
//        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.registerClass(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        self.view.addSubview(self.tableView)
        
        self.loadCompletedByPeople()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.completedByPeople.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonTableViewCell") as! PersonTableViewCell
        var user = self.completedByPeople[indexPath.row]
        cell.userAvatar.backgroundColor = self.colorDictionary[user["color"] as! String]
        cell.userAvatar.image = self.avatarImageDictionary[user["avatar"] as! String]!
        cell.userAlias.text = user.username
        var userOrientation = user["sexualOrientation"] as! String
        var userAge = user["age"] as! Int
        cell.userOrientationAge.text = "\(userOrientation) . \(userAge)"
        var userCity = user["city"] as! String
        var userState = user["state"] as! String
        cell.userLocation.text = "\(userCity), \(userState)"
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPersonDetail:")
        cell.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    
    func loadCompletedByPeople(){
        var userChallengeDataQuery = PFQuery(className: "UserChallengeData")
        userChallengeDataQuery.whereKey("challenge", equalTo: self.challenge)
        userChallengeDataQuery.includeKey("username")
        userChallengeDataQuery.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil{
                var newCompletedByPeople:[PFUser] = []
                for object in objects as! [PFObject]{
                    newCompletedByPeople.append(object["username"] as! PFUser)
                }
                if newCompletedByPeople != self.completedByPeople{
                    self.completedByPeople = newCompletedByPeople
                }
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }else{
                // Log details of the failure
                NSLog("Error: %@ %@", error!, error!.userInfo!)
            }
        }
    }
    
    func sortPeople(){
    
        println("sort people")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPersonDetail"{
            var newVC = segue.destinationViewController as! PersonDetailViewController
            newVC.user = self.user
        }
    }
    
    func showPersonDetail(sender:UITapGestureRecognizer){
        var currentIndexPath = self.tableView.indexPathForRowAtPoint(sender.locationInView(self.tableView)) as NSIndexPath!
        self.user = self.completedByPeople[currentIndexPath.row]
        self.performSegueWithIdentifier("showPersonDetail", sender: self)
    }

}
