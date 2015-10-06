//
//  LoginViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login(){
            (user: User?, error: NSError?) in
            if user != nil{
                self.performSegueWithIdentifier(
                    "loginToMenuSegue", sender: self)
                //perform segue
            }else{
                //handle error
            }
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
