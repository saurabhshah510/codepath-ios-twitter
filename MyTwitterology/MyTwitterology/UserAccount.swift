//
//  UserAccount.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 10/5/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    var followersCount: Int?
    var friendsCount: Int?
    var favouritesCount: Int?
    var statusesCount: Int?
    
    init(dictionary: NSDictionary){
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        favouritesCount = dictionary["favourites_count"] as?  Int
        statusesCount = dictionary["statuses_count"] as? Int
    }
}
