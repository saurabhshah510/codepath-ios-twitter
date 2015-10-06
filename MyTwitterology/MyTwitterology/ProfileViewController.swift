//
//  ProfileViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 10/3/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchProfileInfo(){
        TwitterClient.sharedInstance.profileInfoWithParams(nil, user: User.currentUser!) { (error) -> () in
            print(User.currentUser?.userAccount?.followersCount)
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
