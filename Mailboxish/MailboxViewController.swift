//
//  MailboxViewController.swift
//  Mailboxish
//
//  Created by Michelle Venetucci Harvey on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var rescheduleView: UIView!
    @IBOutlet weak var imageFeed: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var singleMessageView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    let greenColor = UIColor(red: 116/255, green: 215/255, blue: 104/255, alpha: 1)
    let redColor = UIColor(red: 233/255, green: 85/255, blue: 59/255, alpha: 1)
    let yellowColor = UIColor(red: 249/255, green: 209/255, blue: 69/255, alpha: 1)
    let tanColor = UIColor(red: 215/255, green: 165/255, blue: 120/255, alpha: 1)
    let grayColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = imageFeed.frame.size
        rescheduleView.alpha = 0
        
        var edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: "didPanFromEdge:")
        edgePan.edges = .Left
        scrollView.addGestureRecognizer(edgePan)
        
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
        var newMessagePoint = singleMessageView.frame.origin
        newMessagePoint.x = newMessagePoint.x + translation.x
        
        if (sender.state == .Began || sender.state == .Changed) {
            
            if newMessagePoint.x < -260 {
                scrollView.backgroundColor = tanColor
                leftIconImageView.frame.origin.x = newMessagePoint.x - 25 - 17
                rightIconImageView.frame.origin.x = newMessagePoint.x + 337
                rightIconImageView.image = UIImage(named: "list_icon")
            } else if newMessagePoint.x < -60 {
                scrollView.backgroundColor = yellowColor
                leftIconImageView.frame.origin.x = newMessagePoint.x - 25 - 17
                rightIconImageView.frame.origin.x = newMessagePoint.x + 337
                rightIconImageView.image = UIImage(named: "later_icon")
            } else if newMessagePoint.x < 0 {
                leftIconImageView.frame.origin.x = 17
                scrollView.backgroundColor = grayColor
            } else if newMessagePoint.x < 60 {
                rightIconImageView.frame.origin.x = 278
                scrollView.backgroundColor = grayColor
            } else if newMessagePoint.x < 260 {
                scrollView.backgroundColor = greenColor
                leftIconImageView.frame.origin.x = newMessagePoint.x - 25 - 17
                rightIconImageView.frame.origin.x = newMessagePoint.x + 337
                leftIconImageView.image = UIImage(named: "archive_icon")
            } else {
                scrollView.backgroundColor = redColor
                leftIconImageView.frame.origin.x = newMessagePoint.x - 25 - 17
                rightIconImageView.frame.origin.x = newMessagePoint.x + 337
                leftIconImageView.image = UIImage(named: "delete_icon")
            }
            
            singleMessageView.frame.origin = newMessagePoint
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            var targetX = CGFloat(0.0)
            
            if newMessagePoint.x <= -60 && newMessagePoint.x > -260 {
                targetX = singleMessageView.frame.size.width * -1
            }
            
            
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                    self.singleMessageView.frame.origin.x = targetX
                }, completion: { (completed: Bool) -> Void in
                    if newMessagePoint.x <= -60 && newMessagePoint.x > -260 {
                        
                            self.rescheduleView.alpha = 1.0
                        }
                    } )
            }
        sender.setTranslation(CGPointZero, inView: view)
    }
    
    @IBAction func rescheduleTapGesture(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rescheduleView.alpha = 0.0
        }) { (completed) -> Void in
            self.removeSingleMessageView()
        }
    }
    
    func removeSingleMessageView() {
        imageFeed.frame.origin.y -= singleMessageView.frame.size.height
    }
    
    func didPanFromEdge(gesture: UIScreenEdgePanGestureRecognizer) {
        var translation = gesture.translationInView(view)
        
        if gesture.state == .Began || gesture.state == .Changed {
                scrollView.frame.origin.x = translation.x
        } else if (gesture.state == UIGestureRecognizerState.Ended) {
        }
    }
    
    
}
