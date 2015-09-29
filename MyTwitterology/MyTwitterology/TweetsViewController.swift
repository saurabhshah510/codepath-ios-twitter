//
//  TweetsViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]?
    @IBOutlet weak var tweetsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets;
            self.tweetsTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil{
            return tweets!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if self.tweets != nil{
            var cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
            cell.tweet = self.tweets![indexPath.row]
            return cell
        }else{
            return UITableViewCell()
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
