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
    var profileViewController: UIViewController!
    var homeViewController: UIViewController!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
