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
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func login(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        //Get request token and redirect to browser for authentication
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterology://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("error getting request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        //Get access token
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("\(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error getting user credentials")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets{
//                    print("text: \(tweet.text) ----- createdat: \(tweet.createdAt)")
                }
                
                }, failure: { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error getting home timeline")
            })
            
            }) { (error: NSError!) -> Void in
                print("Error getting the access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}
