//
//  User.swift
//  Out
//
//  Created by Eddie Chen on 10/9/14.
//  Copyright (c) 2014 Coming Out App. All rights reserved.
//

import Realm


class User: RLMObject {
    override class func primaryKey() -> String {
        return "alias"
    }
    dynamic var alias = ""
    dynamic var age = 0
    dynamic var genderIdentity = ""
    dynamic var sexualOrientation = ""
    dynamic var avatar = ""
    dynamic var color = ""
    dynamic var ethnicity = ""
    dynamic var city = ""
    dynamic var state = ""
}


class Mentor: RLMObject {
    override class func primaryKey() -> String {
        return "alias"
    }
    dynamic var alias = ""
    dynamic var avatar = ""
    dynamic var color = ""
    dynamic var city = ""
    dynamic var state = ""
}


class ChallengeModel: RLMObject {
    override class func primaryKey() -> String {
        return "titleAndVersion"
    }
    dynamic var tags = ""
    dynamic var titleAndVersion = ""
    dynamic var reason = [""]
    dynamic var blurb = ""
}


class ChallengeModelStep: RLMObject{
    override class func primaryKey() -> String {
        return "challengeTitleAndVersion"
    }
    dynamic var challengeTitleAndVersion = ""
    dynamic var stepNumber = 0
    dynamic var title = ""
    dynamic var intro = ""
    dynamic var moduleType = ""
    dynamic var module = ""
}



class UserChallengeDataContainer: RLMObject {
    override class func primaryKey() -> String {
        return "titleAndVersion"
    }
    dynamic var titleAndVersion = ""
    dynamic var completedDate = ""
    dynamic var isCurrent = true
    dynamic var alias = ""
}


class ChallengeStepData: RLMObject {
    override class func primaryKey() -> String {
        return "challengeTitleAndVersion"
    }
    dynamic var challengeTitleAndVersion = ""
    dynamic var stepNumber = 0
    dynamic var stepNarrative = ""
    dynamic var stepMedia = ""
    dynamic var completedDate = ""
}