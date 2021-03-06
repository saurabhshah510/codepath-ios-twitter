//
//  User.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
var _currentUser: User?
let currentUserKey = "twCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screen_name: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    var userAccount: UserAccount?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screen_name = dictionary["screen_name"] as? String
        let normal = dictionary["profile_image_url"]  as! String
        let original = normal.stringByReplacingOccurrencesOfString("_normal", withString: "")
        profileImageUrl = NSURL(string: original)
        tagline = dictionary["description"] as? String
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User?{
        get{
            if _currentUser == nil{
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil{
                    let dictionary = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }        
            }
            return _currentUser
        }set(user){
            _currentUser = user
            if _currentUser != nil{
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
