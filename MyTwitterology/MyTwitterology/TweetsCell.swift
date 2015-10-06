//
//  TweetsCell.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit


@objc protocol TweetsCellDelegate{
    optional func tweetCell(tweetCell: TweetsCell, tweet: Tweet)
    
    optional func clickProfileImage(tweetCell: TweetsCell, tweet: Tweet)
}

class TweetsCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    weak var delegate: TweetsCellDelegate?
    
    var tweet: Tweet! {
        didSet{
            self.profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
            self.nameLabel.text = tweet.user!.name
            self.createdAtLabel.text = tweet.createdAtDiff
            self.tweetLabel.text = tweet.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet)
    }
    
    @IBOutlet weak var onRetweet: UIButton!
    
    
    @IBAction func onReply(sender: AnyObject) {
        delegate?.tweetCell?(self, tweet: tweet)
    }
    
    func onTapProfileImage(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.clickProfileImage?(self, tweet: tweet)
    }
}
