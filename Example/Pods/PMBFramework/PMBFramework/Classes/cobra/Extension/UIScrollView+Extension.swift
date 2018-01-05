//
//  UIScrollView+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/22/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import SnapKit

extension UIScrollView {
    
    public var content: UIView! {
        guard subviews.count != 0 else {
            addContentView(view: UIView())
            return subviews[0]
        }
        return subviews[0]
    }
    
    public func addContentView(view: UIView) {
        if subviews.count == 0 {
            addSubview(view)
            subviews[0].snp.makeConstraints({ (make) in
                make.edges.width.equalTo(self)
            })
        } else {
            debug(key: "this scrollview already have contentView", subviews)
        }
    }
    
    public func addScrollViewVisualEffect(style: UIBlurEffectStyle = .extraLight, frame: CGRect? = nil, animated: Bool, duration: TimeInterval = 0.5) {
        // make sure that you've already set
        // the view's constraint before called this function
        setNeedsLayout()
        layoutIfNeeded()
        if viewWithTag(208283) == nil {
            let blurEffect = UIBlurEffect(style: style)
            let visualEffect = UIVisualEffectView(effect: blurEffect)
            visualEffect.tag = 208283
            visualEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(visualEffect)
        }
        let visualEffect = viewWithTag(208283)!
        let size = (contentSize.height < self.frame.size.height) ? self.frame.size : contentSize
        visualEffect.frame = CGRect(origin: CGPoint.zero, size: size)
        if animated {
            visualEffect.alpha = 0
            UIView.animate(withDuration: duration) {
                visualEffect.alpha = 1
            }
        }
    }
    
    public func hideScrollViewVisualEffect(animated: Bool, duration: TimeInterval = 0.5) {
        if let visualView = viewWithTag(208283) {
            if animated {
                UIView.animate(withDuration: duration, animations: {
                    visualView.alpha = 0
                }, completion: { _ in
                    visualView.removeFromSuperview()
                })
            } else {
                visualView.removeFromSuperview()   
            }
        }
    }
    
    public var currentIndex: Int {
        return Int(contentOffset.x / frame.size.width)
    }
    
    public func isReachTopView(_ offset: CGFloat = 0) -> Bool {
        return self.contentOffset.y <= 0
    }
    
    public func isReachBottomView(_ offset: CGFloat = 0) -> Bool {
        setNeedsLayout()
        layoutIfNeeded()
        guard self.contentSize.height > frame.size.height else {
            return false
        }
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - frame.size.height + offset
        return (currentOffset >= maximumOffset) && (maximumOffset > 0) && (currentOffset > 0)
    }
    
    public func isReachBottomView(offset: CGFloat = 0, hasData: Bool, requesting: Bool) -> Bool {
        return isReachBottomView(offset) && hasData && !requesting
    }
    
}
