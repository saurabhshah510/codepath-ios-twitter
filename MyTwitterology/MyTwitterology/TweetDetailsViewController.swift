//
//  TweetDetailsViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyText: UITextView!

    @IBOutlet weak var nameLabel: UILabel!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        
        replyText.layer.borderColor = borderColor.CGColor
        replyText.layer.borderWidth = 1.0
        replyText.layer.cornerRadius = 5.0
        
        self.profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
        self.nameLabel.text = tweet.user!.name
        self.createdAtLabel.text = tweet.createdAtDiff
        self.tweetLabel.text = tweet.text
        self.replyText.text = "@\(tweet.user!.screen_name!)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet)
    }

    @IBAction func onReply(sender: AnyObject) {
        TwitterClient.sharedInstance.reply(replyText.text!, tweet: tweet)
        self.replyText.userInteractionEnabled = false
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet)
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
