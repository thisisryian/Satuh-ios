//
//  PageViewController.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/8/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit

open class PageViewController: BaseViewController, ViewController {
    lazy var _root = PageView()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    fileprivate var viewControllers: [UIViewController] = []
    private var titleSegment: [String] = []
    fileprivate var total: Int = 0
    
    private var activeColor: UIColor = .primary
    private var inactiveColor: UIColor = .lightGray
    fileprivate var prevIndex = 0
    
    public var segmentIndexChanged: ((Int)->Void) = { _ in }
    
    public var selectedIndex: Int {
        return _root.segmentView.selectedSegmentIndex
    }
    
    // PageViewController property
    public var scrollable: Bool = true
    public var isDoubleSide: Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view = _root
        
        setupController()
    }
    
    public func setupController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.isDoubleSided = isDoubleSide
        
        _root.segmentView.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        guard let scrollview = pageViewController.view.subviews.filter({ (view) -> Bool in
            return view is UIScrollView
        }).first as? UIScrollView else { return }
        scrollview.delegate = self
        scrollview.bounces = scrollable
    }
    
    public func scrolling(enable: Bool) {
        guard let scrollview = pageViewController.view.subviews.filter({ (view) -> Bool in
            return view is UIScrollView
        }).first as? UIScrollView else { return }
        scrollview.bounces = enable
    }
    
    public func get<T>() -> T? {
        return self.viewControllers.filter({ (vc) -> Bool in
            return vc is T
        }).first as? T
    }
    
    public func get<T>(index: Int) -> T? {
        guard index >= 0 else {
            debug(key: "PageController", "Index must be greater than or equal to 0")
            return nil
        }
        guard index < self.viewControllers.count else {
            debug(key: "PageController", "Index out of range")
            return nil
        }
        return self.viewControllers[index] as? T
    }
    
    
    public func setBackground(color: UIColor) {
        pageViewController.view.backgroundColor = color
    }
    
    public func disableSegment(_ index: [Int]) {
        for i in 0..<_root.segmentView.numberOfSegments {
            _root.segmentView.setEnabled(true, forSegmentAt: i)
        }
        
        for i in index {
            _root.segmentView.setEnabled(false, forSegmentAt: i)
        }
    }
    
    public func moveToPage(_ index: Int) {
        if index >= total {
            _root.segmentView.selectedSegmentIndex = total - 1
            return
        }
        if index < 0 {
            _root.segmentView.selectedSegmentIndex = 0
        }
        _root.segmentView.selectedSegmentIndex = index
        segmentPressed(_root.segmentView)
        segmentedValueChanged(_root.segmentView)
        pageViewController.setViewControllers(
            [self.viewControllers[index]],
            direction: (prevIndex < index ? .forward : .reverse),
            animated: true,
            completion: nil
        )
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        segmentIndexChanged(sender.selectedSegmentIndex)
    }
    
    public func initialize(activeColor: UIColor, inactiveColor: UIColor) {
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
    
    public func initialize(titles: [String], viewControllers: [UIViewController], style: PageStyleEn) {
        let style = style
        self.viewControllers = viewControllers
        self.titleSegment = titles
        self.total = viewControllers.count
        
        //        if viewControllers.count > 4 {
        //            style = .scroll
        //        }
        
        // configure pageViewController
        pageViewController.view.frame = _root.body.frame
        _root.body.addSubview(pageViewController.view)
        addChildViewController(pageViewController)
        pageViewController.didMove(toParentViewController: self)
        self.pageViewController.setViewControllers([self.viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        // configure pageView <-- _root
        _root.setup(style: style, title: titleSegment)
        switch style {
        case .scroll:
            let buttons: [UIButton] = _root.scrollView.content.getSubviews()
            for button in buttons {
                button.addTarget(self, action: #selector(tabPressed(_:)), for: .touchUpInside)
            }
        case .segment:
            _root.segmentView.selectedSegmentIndex = 0
            _root.segmentView.addTarget(self, action: #selector(segmentPressed(_:)), for: .valueChanged)
        }
    }
    
    @objc public func segmentPressed(_ sender: UISegmentedControl) { // for segmentedControll
        guard prevIndex != sender.selectedSegmentIndex else { return }
        pageViewController.setViewControllers(
            [self.viewControllers[sender.selectedSegmentIndex]],
            direction: (prevIndex < sender.selectedSegmentIndex ? .forward : .reverse),
            animated: true,
            completion: nil
        )
        prevIndex = sender.selectedSegmentIndex
    }
    
    @objc public func tabPressed(_ sender: UIButton) { // for scrollview
        
    }
    
}

extension PageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        if _root.segmentView.selectedSegmentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
        //            scrollView.contentOffset.x = CGFloat(scrollView.bounds.size.width)
        //        }
        //        else if _root.segmentView.selectedSegmentIndex == total - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
        //            scrollView.contentOffset.x = CGFloat(scrollView.bounds.size.width)
        //        }
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first else { return }
        guard let index = self.viewControllers.index(of: viewController) else { return }
        UIView.animate(withDuration: 0.3) {
            self._root.segmentView.selectedSegmentIndex = index
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // prev
        guard let index = viewControllers.index(of: viewController) else { return nil }
        guard index > 0 else { return nil }
        return viewControllers[index - 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // next
        guard let index = viewControllers.index(of: viewController) else { return nil }
        guard (index + 1) < viewControllers.count else { return nil }
        return viewControllers[index + 1]
    }
    
}

