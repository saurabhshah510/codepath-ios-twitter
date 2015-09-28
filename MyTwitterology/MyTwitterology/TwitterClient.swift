//
//  TwitterClient.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

let twitterConsumerKey = "Wn0Wvf63QPstiwI0vvcnWc9Rn"
let twitterConsumerSecret = "XCYEKNF00crnJK4OcktjhZYh7TTbjP59jElRCF8ikMO5O8RSlT"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
