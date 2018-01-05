//
//  UITableView+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 3/7/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func flexibleHeight() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 44
    }
    
    public func flexibleSectionHeader() {
        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = 44
    }
    
    public func flexibleSectionFooter() {
        sectionFooterHeight = UITableViewAutomaticDimension
        estimatedSectionFooterHeight = 44
    }
    
    public func scrollToTopView(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    public var isOnTopView: Bool {
        return (contentOffset.y == 0)
    }
    
    public func scrollToBottomView(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: animated)
    }
    
    public var isOnBottomView: Bool {
        return (contentOffset.y + frame.size.height) >= contentSize.height
    }
    
    public func addRefreshControll(withTitle title: String = "Pull to refresh", target: UIViewController, selector: Selector, backgroundColor: UIColor = .clear) -> UIRefreshControl {
        if let refresh = subviews.first as? UIRefreshControl {
            
            return refresh
        }
        let refresh = UIRefreshControl()
        refresh.backgroundColor = backgroundColor
        refresh.attributedTitle = NSAttributedString(string: title)
        refresh.addTarget(target, action: selector, for: .valueChanged)
        insertSubview(refresh, at: 0)
        return refresh
    }
    
    public func addLoadingView() {
        guard let view = viewWithTag(29144) else {
            let activity = UIActivityIndicatorView()
            activity.startAnimating()
//            activity.color = UIColor.white
            activity.tag = 29144
            tableFooterView = activity
            tableFooterView?.frame.size.height = Margin.s44
            return
        }
        view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            view.alpha = 1
            self.tableFooterView?.frame.size.height = Margin.s44
        }
    }
    
    public func endLoadingView() {
        guard let view = viewWithTag(29144) else { return }
        UIView.animate(withDuration: 0.3) { 
            view.alpha = 0
            self.tableFooterView?.frame.size.height = 0
        }
    }
    
}
