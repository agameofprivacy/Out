//
//  User.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import Realm

class Challenge: RLMObject {
    dynamic var alias = ""
    
}

class User: RLMObject {
    dynamic var alias = ""
    dynamic var age = 0
    dynamic var genderIdentity = ""
    dynamic var sexualOrientation = ""
    dynamic var avatar = ""
    dynamic var color = ""
    dynamic var ethnicity = ""
    dynamic var city = ""
    dynamic var state = ""
    dynamic var currentChallengesKeys = [""]
    dynamic var completedChallengesKeys = [""]
}
