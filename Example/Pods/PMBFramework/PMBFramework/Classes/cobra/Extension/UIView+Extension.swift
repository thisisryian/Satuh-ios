//
//  UIView+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
    
    public func setAsLine(height: Float = 1) {
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        backgroundColor = .lastGray
    }
    
    public var hasVisualEffect: Bool {
        if let visualEffect = viewWithTag(208283) {
            return visualEffect.alpha == 1
        }
        return false
    }
    
    public func addVisualEffect(style: UIBlurEffectStyle = .extraLight, frame: CGRect? = nil, animated: Bool, duration: TimeInterval = 0.5) {
        // make sure that you've already set
        // the view's constraint before called this function
        setNeedsLayout()
        layoutIfNeeded()
        if viewWithTag(208283) == nil {
            let blurEffect = UIBlurEffect(style: style)
            let visualEffect = UIVisualEffectView(effect: blurEffect)
            visualEffect.tag = 208283
            if let frame = frame {
                visualEffect.frame = frame
            } else {
                visualEffect.frame = bounds
            }
            visualEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(visualEffect)
        }
        let visualEffect = viewWithTag(208283)!
        if animated {
            visualEffect.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                visualEffect.alpha = 1
            })
        }
    }
    
    public func hideVisualEffect() {
        if let visualView = viewWithTag(208283) {
            visualView.removeFromSuperview()
        }
    }
    
    public func setupSubviews(_ views: [UIView]) {
        for item in views {
            addSubview(item)
        }
    }
    
    public func removeSubviews(_ views: [UIView]) {
        for item in views {
            item.removeFromSuperview()
        }
    }
    
    public func getSubviews<Element: UIView>() -> [Element] {
        return subviews as? [Element] ?? []
    }
    
    public func getSubview<Element>(_ index: Int) -> Element? {
        guard subviews.count > index else { return nil }
        return subviews[index] as? Element
    }
    
    public func clearAllConstraints(for view: UIView? = nil) {
        for subview in (view ?? self).subviews {
            if subview.subviews.count != 0 {
                clearAllConstraints(for: subview)
            }
        }
        (view ?? self).snp.removeConstraints()
    }
    
    public func setLayer(cornerRadius: CGFloat? = nil, borderWidth width: CGFloat? = nil, borderColor color: UIColor? = nil) {
        setNeedsLayout()
        layoutIfNeeded()
        if let radius = cornerRadius {
            let size = (frame.width == 0 ? frame.height : frame.width) / 2
            layer.cornerRadius = (radius == 0 ? size : radius)
        } else {
            layer.cornerRadius = 0
        }
        
        if let width = width {
            layer.borderWidth = width
        }
        if let color = color {
            layer.borderColor = color.cgColor
        }
        layer.masksToBounds = true
    }
    
    public func setShadow(size: CGFloat = 5, opacity: Float = 0.5, color: UIColor = .black) {
        // set shadow must be implement after set layer
        // set layer first and then set shadow
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = size
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 15, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 15, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
