//
//  RevealAnimator.swift
//  NavigationControllerDelegate
//
//  Created by donggua on 2019/7/23.
//  Copyright © 2019年 wky. All rights reserved.
//

import UIKit
import Foundation

class RevealAnimator: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    let animationDuration = 2.0
    var operation: UINavigationController.Operation = .push
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        if operation == .push {
            let fromVC = transitionContext.viewController(forKey: .from) as! MianViewController
            let toVC = transitionContext.viewController(forKey: .to) as! DetailTableViewController
            
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
            animation.toValue = NSValue(caTransform3D:
                CATransform3DConcat(
                    CATransform3DMakeTranslation(0.0, -10.0, 0.0),
                    CATransform3DMakeScale(100.0, 100.0, 1.0)
                )
            )
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
//            let maskLayer: CAShapeLayer = LogoLayer.logoLayer()
//            maskLayer.position = fromVC.logoLayer.position
//            maskLayer.add(animation, forKey: nil)
//            toVC.view.layer.mask = maskLayer
            
            fromVC.logoLayer.add(animation, forKey: nil)
            
            let fadeIn = CABasicAnimation(keyPath: "opacity")
            fadeIn.fromValue = 0.0
            fadeIn.toValue = 1.0
            fadeIn.duration = animationDuration
            toVC.view.layer.add(fadeIn, forKey: nil)
        } else {
            
            let fromView = transitionContext.view(forKey: .from)!
            let toView = transitionContext.view(forKey: .to)!
            
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseIn,
               animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            },completion: {_ in
                 transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            )
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled)
            //reset logo
            let fromVC = context.viewController(forKey: .from) as! MianViewController
            fromVC.logoLayer.removeAllAnimations()
            
            let toVC = context.viewController(forKey: .to) as! DetailTableViewController
            toVC.view.layer.mask = nil
        }
        storedContext = nil
    }
}

