//
//  ProfileViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 10/3/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileInfo(User.currentUser!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchProfileInfo(user: User){
        TwitterClient.sharedInstance.profileInfoWithParams(nil, user: user) { (error) -> () in
            self.profileImageView.setImageWithURL(user.profileImageUrl)
            self.nameLabel.text = user.name!
            self.screenNameLabel.text = "@\(user.screen_name!)"
            self.tweetsCountLabel.text = "\(user.userAccount!.statusesCount!)"
            self.followingCountLabel.text = "\(user.userAccount!.friendsCount!)"
            self.followersCountLabel.text = "\(user.userAccount!.followersCount!)"
            self.favoritesCountLabel.text = "\(user.userAccount!.favouritesCount!)"
        }
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
