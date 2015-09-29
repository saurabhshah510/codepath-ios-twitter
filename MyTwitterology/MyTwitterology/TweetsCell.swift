//
//  TweetsCell.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet{
            self.profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
            self.nameLabel.text = tweet.user!.name
            self.createdAtLabel.text = tweet.createdAtString
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

}
