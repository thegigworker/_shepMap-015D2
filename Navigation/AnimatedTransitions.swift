// A transition context object is constructed by the system and passed to the
// animator in its animateTransition: and transitionDuration: methods as well as
// to the interaction controller in its startInteractiveTransition: method. If
// there is an interaction controller its startInteractiveTransition: is called
// first and its up to the the interaction controller object to call the
// animateTransition: method if needed. If there is no interaction controller,
// then the system automatically invokes the animator's animateTransition:
// method.
//
// The system queries the view controller's transitioningDelegate or the
// navigation controller's delegate to determine if an animator or interaction
// controller should be used in a transition. The transitioningDelegate is a new
// propery on UIViewController and conforms to the
// UIViewControllerTransitioningDelegate protocol defined below. The navigation
// controller likewise has been augmented with a couple of new delegate methods.
//
// The UIViewControllerContextTransitioning protocol can be adopted by custom
// container controllers.  It is purposely general to cover more complex
// transitions than the system currently supports. For now, navigation push/pops
// and UIViewController present/dismiss transitions can be
// customized. Information about the transition is obtained by using the
// viewControllerForKey:, initialFrameForViewController:, and
// finalFrameForViewController: methods. The system provides two keys for
// identifying the from view controller and the to view controller for
// navigation push/pop and view controller present/dismiss transitions.
//
// All custom animations must invoke the context's completeTransition: method
// when the transition completes.  Furthermore the animation should take place
// within the containerView specified by the context. For interactive
// transitions the context's updateInteractiveTransition:,
// finishInteractiveTransition or cancelInteractiveTransition should be called
// as the interactive animation proceeds. The UIPercentDrivenInteractiveTransition
// class provides an implementation of the UIViewControllerInteractiveTransitioning
// protocol that can be used to interactively drive any UIView property animations
// that are created by an animator.


import UIKit

class inverseRotatingCube_AnimTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) { // inverseRotatingCUBE_AnimTransition
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toView = toViewController.view
        let fromView = fromViewController.view
        let direction: CGFloat = MainTabController.tabBarTransitionDirectionLeft ? -1 : 1
        let const: CGFloat = -0.005
        
        toView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
        fromView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
        
        //var viewFromTransform: CATransform3D = CATransform3DMakeRotation(+direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        //var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        // // THE TWO LINES ABOVE, INSTEAD OF THE TWO BELOW, TURN THIS ANIMATION INTO A ROTATING CUBE EFFECT, GOING OUTWARD
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(+direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
        toView?.layer.transform = viewToTransform
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
            fromView?.layer.transform = viewFromTransform
            toView?.layer.transform = CATransform3DIdentity
        }, completion: {
            finished in
            containerView.transform = CGAffineTransform.identity
            fromView?.layer.transform = CATransform3DIdentity
            toView?.layer.transform = CATransform3DIdentity
            fromView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            if (transitionContext.transitionWasCancelled) {
                toView?.removeFromSuperview()
            } else {
                fromView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
}

class upFromBottom_AnimTrnsition: NSObject, UIViewControllerAnimatedTransitioning {
    // NOTE: Line of code change below to make this rise from the bottom w bounce
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)  // this makes it drop down
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height) // this makes it rise from the bottom
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

class slideInBounce_AnimTransition: NSObject, UIViewControllerAnimatedTransitioning {
    // NOTE: Line of code change below to make this rise from the bottom w bounce
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        //static var transitionDirectionLeft: Bool = false
        if MainTabController.tableviewDirectionLeft == false {
            //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)  // this makes it drop down
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: -bounds.size.width, dy: 0)
        } else {
            //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height) // this makes it rise from the bottom
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: bounds.size.width, dy: 0)
        }
        //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)  // this makes it drop down
        //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height) // this makes it rise from the bottom
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
}

//class dropDownBounce_AnimTrnsition: NSObject, UIViewControllerAnimatedTransitioning {
//    // NOTE: Line of code change below to make this rise from the bottom w bounce
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
//        let containerView = transitionContext.containerView
//        let bounds = UIScreen.main.bounds
//        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)  // this makes it drop down
//        //toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height) // this makes it rise from the bottom
//        containerView.addSubview(toViewController.view)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
//            fromViewController.view.alpha = 0.5
//            toViewController.view.frame = finalFrameForVC
//        }, completion: {
//            finished in
//            transitionContext.completeTransition(true)
//            fromViewController.view.alpha = 1.0
//        })
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        print ("In dropDownBounceTransitionAnimation.transitionDuration")
//        return 1.5
//    }
//}
//
//class shrinkDown_AnimTransition: NSObject, UIViewControllerAnimatedTransitioning {
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
//        let containerView = transitionContext.containerView
//        toViewController.view.frame = finalFrameForVC
//        toViewController.view.alpha = 0.5
//        containerView.addSubview(toViewController.view)
//        containerView.sendSubview(toBack: toViewController.view)
//
//        let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)
//        snapshotView?.frame = fromViewController.view.frame
//        containerView.addSubview(snapshotView!)
//
//        fromViewController.view.removeFromSuperview()
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            snapshotView?.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
//            toViewController.view.alpha = 1.0
//        }, completion: {
//            finished in
//            snapshotView?.removeFromSuperview()
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        print ("In shrinkDownTransitionAnimation.transitionDuration")
//        return 1.0
//    }
//}
//
//
//class CrossFade_AnimTransition: NSObject, UIViewControllerAnimatedTransitioning {
//
//    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
//
//    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard
//            let toViewController = transitionContext.viewController(forKey: .to)
//            else {
//                return
//        }
//        transitionContext.containerView.addSubview(toViewController.view)
//        toViewController.view.alpha = 0
//
//        let duration = self.transitionDuration(using: transitionContext)
//        UIView.animate(withDuration: duration, animations: {
//            toViewController.view.alpha = 1
//        }, completion: { _ in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//}
//
//
//class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
//
//    var circle = UIView()
//    var startingPoint = CGPoint.zero {
//        didSet {
//            circle.center = startingPoint
//        }
//    }
//    var circleColor = UIColor.white
//    var duration = 0.3
//
//    enum CircularTransitionMode:Int {
//        case present, dismiss, pop
//    }
//
//    var transitionMode:CircularTransitionMode = .present
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//
//        if transitionMode == .present {
//            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
//                let viewCenter = presentedView.center
//                let viewSize = presentedView.frame.size
//
//                circle = UIView()
//                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
//                circle.layer.cornerRadius = circle.frame.size.height / 2
//                circle.center = startingPoint
//                circle.backgroundColor = circleColor
//                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                containerView.addSubview(circle)
//
//                presentedView.center = startingPoint
//                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                presentedView.alpha = 0
//                containerView.addSubview(presentedView)
//
//                UIView.animate(withDuration: duration, animations: {
//                    self.circle.transform = CGAffineTransform.identity
//                    presentedView.transform = CGAffineTransform.identity
//                    presentedView.alpha = 1
//                    presentedView.center = viewCenter
//
//                }, completion: { (success:Bool) in
//                    transitionContext.completeTransition(success)
//                })
//            }
//        }else{
//            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
//
//            if let returningView = transitionContext.view(forKey: transitionModeKey) {
//                let viewCenter = returningView.center
//                let viewSize = returningView.frame.size
//
//                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
//                circle.layer.cornerRadius = circle.frame.size.height / 2
//                circle.center = startingPoint
//
//                UIView.animate(withDuration: duration, animations: {
//                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.center = self.startingPoint
//                    returningView.alpha = 0
//
//                    if self.transitionMode == .pop {
//                        containerView.insertSubview(returningView, belowSubview: returningView)
//                        containerView.insertSubview(self.circle, belowSubview: returningView)
//                    }
//
//                }, completion: { (success:Bool) in
//                    returningView.center = viewCenter
//                    returningView.removeFromSuperview()
//                    self.circle.removeFromSuperview()
//                    transitionContext.completeTransition(success)
//                })
//            }
//        }
//    }
//
//    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
//        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
//        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
//
//        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
//        let size = CGSize(width: offestVector, height: offestVector)
//
//        return CGRect(origin: CGPoint.zero, size: size)
//    }
//}
//
//
//class SlideDownFromCorner_AnimTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
//
//    var presenting = true
//
//    // animate a change from one viewcontroller to another
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//
//        // get reference to our fromView, toView and the container view that we should perform the transition in
//        let container = transitionContext.containerView
//
//
//        //let fromView.alpha
//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
//        // set up from 2D transforms that we'll use in the animation
//        let π : CGFloat = 3.14159265359
//
//        let offScreenRight = CGAffineTransform(rotationAngle: -π/2)
//        let offScreenLeft = CGAffineTransform(rotationAngle: π/2)
//
//        // prepare the toView for the animation
//       toView.transform = self.presenting ? offScreenRight : offScreenLeft
//        //toView.transform = self.presenting ? offScreenLeft : offScreenRight
//
//        // set the anchor point so that rotations happen from the top-left corner
//        toView.layer.anchorPoint = CGPoint(x:0, y:0)
//        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
//
//        // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
//        toView.layer.position = CGPoint(x:0, y:0)
//        fromView.layer.position = CGPoint(x:0, y:0)
//
//        // add the both views to our view controller
//        container.addSubview(toView)
//        container.addSubview(fromView)
//
//        // get the duration of the animation
//        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
//        // but for now it's important to just follow this approach
//        let duration = self.transitionDuration(using: transitionContext)
//
//        // perform the animation!
//        // for this example, just slide both fromView and toView to the left at the same time
//        // meaning fromView is pushed off the screen and toView slides into view
//        // we also use the block animation usingSpringWithDamping for a little bounce
//        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
//            // slide fromView off either the left or right edge of the screen
//            // depending if we're presenting or dismissing this view
//            fromView.transform = self.presenting ? offScreenLeft : offScreenRight
//            //fromView.transform = self.presenting ? offScreenRight : offScreenLeft
//            toView.transform = CGAffineTransform.identity
//        }, completion: { finished in
//            // tell our transitionContext object that we've finished animating
//            transitionContext.completeTransition(true)
//        })
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 1.75
//    }
//
//    // MARK: UIViewControllerTransitioningDelegate protocol methods
//
//    // return the animataor when presenting a viewcontroller
//    // remmeber that an animator (or animation controller) is any object that adheres to the UIViewControllerAnimatedTransitioning protocol
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        // these methods are the perfect place to set our `presenting` flag to either true or false - voila!
//        self.presenting = true
//        return self
//    }
//
//    // return the animator used when dismissing from a viewcontroller
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        self.presenting = false
//        return self
//    }
//
//}
