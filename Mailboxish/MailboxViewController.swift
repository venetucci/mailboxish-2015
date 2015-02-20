//
//  MailboxViewController.swift
//  Mailboxish
//
//  Created by Michelle Venetucci Harvey on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var imageFeed: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var singleMessageView: UIView!
    
    var startingMessageCenter: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = imageFeed.frame.size
        // Do any additional setup after loading the view.
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

    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var location = sender.locationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            startingMessageCenter = singleMessageView.center
        } else if (sender.state == UIGestureRecognizerState.Changed){
            singleMessageView.center = CGPoint(x: startingMessageCenter.x + translation.x, y: singleMessageView.center.y)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
        }
    }
}
