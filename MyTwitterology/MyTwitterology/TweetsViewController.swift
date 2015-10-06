//
//  TweetsViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetsCellDelegate {
    var refreshControl: UIRefreshControl!
    var tweets: [Tweet]?
    @IBOutlet weak var tweetsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        tweetsTableView.insertSubview(refreshControl, atIndex: 0)
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        fetchTweets()
        // Do any additional setup after loading the view.
    }
    
    func fetchTweets(){
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets;
            self.tweetsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }        
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil{
            return tweets!.count
        }else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if self.tweets != nil{
            let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
            cell.tweet = self.tweets![indexPath.row]
            cell.delegate = self
            let tapGesureRecognizer = UITapGestureRecognizer(target: cell, action:"onTapProfileImage:")
            cell.profileImageView.addGestureRecognizer(tapGesureRecognizer)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tweetCell(tweetCell: TweetsCell, tweet: Tweet){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TweetDetailsVC") as! TweetDetailsViewController
        vc.tweet = tweet
        self.navigationController?.pushViewController(
            vc, animated: true)
    }
    
    func clickProfileImage(tweetCell: TweetsCell, tweet: Tweet){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        vc.user = tweet.user!
        self.navigationController?.pushViewController(
            vc, animated: false)
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectTweetSegue"{
            let tweetDetailsViewController = segue.destinationViewController as! TweetDetailsViewController
            var tweet: Tweet!
            let cell = sender as! TweetsCell
            let indexPath = tweetsTableView.indexPathForCell(cell)
            tweet = self.tweets![indexPath!.row]
            tweetDetailsViewController.tweet = tweet        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
