//
//  MenuViewController.swift
//  MyTwitterology
//
//  Created by Saurabh Shah on 10/3/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuWidthConstraint: NSLayoutConstraint!
    var menuWidth:CGFloat = 150.0
    
    var profileViewController: UIViewController!
    var homeViewController: UIViewController!
    var menuViewOriginalCenter: CGPoint!
    
    //Setup the custom navigation
    private var activeViewController: UIViewController?{
        didSet{
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
    
    private  func removeInactiveViewController(inactiveViewController: UIViewController?){
        if let inActiveVC = inactiveViewController{
            inActiveVC.willMoveToParentViewController(nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParentViewController()
        }
        
    }
    
    private func updateActiveViewController(){
        if let activeVC = activeViewController{
            addChildViewController(activeVC)
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            activeVC.didMoveToParentViewController(self)
        }
    }

    //View cycle handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        activeViewController = homeViewController
        menuWidthConstraint.constant = 0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    //View event handlers
    @IBAction func onClickHome(sender: AnyObject) {
        activeViewController = homeViewController
    }
    
    @IBAction func onClickProfile(sender: AnyObject) {
        activeViewController = profileViewController
    }
    
    @IBAction func onContentPan(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocityInView(view)
        if velocity.x > 0{
            if sender.state == UIGestureRecognizerState.Ended{
                menuWidthConstraint.constant =  menuWidth
            }
        } else {
            if sender.state == UIGestureRecognizerState.Ended{
                menuWidthConstraint.constant =  0
            }
        }
    }
}
