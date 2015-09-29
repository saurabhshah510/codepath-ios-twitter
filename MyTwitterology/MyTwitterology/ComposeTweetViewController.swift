//
//  ComposeTweetViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 9/28/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    
    @IBOutlet weak var tweetTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        
        tweetTextField.layer.borderColor = borderColor.CGColor
        tweetTextField.layer.borderWidth = 1.0
        tweetTextField.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onClickTweet(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        let tweetText = self.tweetTextField.text as String?
        if(tweetText != nil &&  tweetText != ""){
            TwitterClient.sharedInstance.postTweet(tweetText!)
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
