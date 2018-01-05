//
//  PageView.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/8/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit

public class BaseColor {
    
    public static var primary: UIColor = .clear
    public static var secondary: UIColor = .clear
    
    public init(primary: UIColor, secondary: UIColor) {
        BaseColor.primary = primary
        BaseColor.secondary = secondary
    }
    
}

public class PageView: UIView, View {
    
    public let segmentView = UISegmentedControl()
    public let scrollView = UIScrollView()
    public let body = UIView()
    public let line = UIView()
    
    public init() {
        super.init(frame: CGRect())
        backgroundColor = .background
        addSubview(body)
        
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    public func setup(style: PageStyleEn, title: [String]) {
        switch style {
        case .scroll:
            addSubview(scrollView)
            scrollView.snp.makeConstraints({ (make) in
                make.top.leading.trailing.equalTo(self)
                make.height.equalTo(Margin.s32)
            })
            
            body.snp.makeConstraints({ (make) in
                make.top.equalTo(scrollView.snp.bottom)
            })
        case .segment:
            for i in 0..<title.count {
                segmentView.insertSegment(withTitle: title[i], at: i, animated: false)
            }
            addSubview(segmentView)
            segmentView.snp.makeConstraints({ (make) in
                make.top.equalTo(self)
                make.leading.equalTo(self).offset(-Margin.s8)
                make.trailing.equalTo(self).offset(Margin.s8)
                make.height.equalTo(Margin.s32 * UI(1, 1.1))
            })
            
            body.snp.makeConstraints({ (make) in
                make.top.equalTo(segmentView.snp.bottom)
            })
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setupView() {
        segmentView.tintColor = .primary
    }
    
    func setupConstraint() {
        body.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
