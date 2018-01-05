//
//  WebView.swift
//  FlowerSGByte
//
//  Created by Roni Aja on 8/19/17.
//  Copyright © 2017 Roni Aja. All rights reserved.
//

import UIKit

public class WebView: UIWebView {

    public init() {
        super.init(frame: screenSize)
        
        self.scrollView.bounces = false
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.alwaysBounceHorizontal = true
        self.scalesPageToFit = true
        self.scrollView.isDirectionalLockEnabled = true
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
