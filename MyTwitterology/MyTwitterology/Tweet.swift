//
//  Tweet.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var id: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var createdAtDiff: String?
    
    init(dictionary: NSDictionary){
        user = User.init(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        id = dictionary["id_str"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        let seconds = NSInteger(createdAt!.timeIntervalSinceNow) * -1
        let days = seconds/86400
        let hours = (seconds - 86400 * days)/3600
        let minutes = (seconds - 86400*days - 3600 * hours)/60
        var diffString = ""
        if days != 0{
            diffString = diffString + "\(days)d "
        }
        if hours != 0{
            diffString = diffString + "\(hours)h "
        }
        if minutes != 0{
            diffString = diffString + "\(minutes)m "
        }
        if diffString == ""{
            diffString = "few seconds "
        }
        diffString += "ago"
        createdAtDiff = diffString
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }

}
