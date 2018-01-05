//
//  Protocols.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/25/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Foundation

@objc public protocol PageController { // PageViewController
    func setupPage()
    @objc optional func setupObserver()
}

@objc public protocol ViewController { // UIViewController
    func setupController()
    @objc optional func setupObserver()
}

protocol View { // UIView
    func setupView()
    func setupConstraint()
}

protocol Cell { // UITableViewCell
    func setupCell()
    func setupConstraint()
}

protocol Item { // UICollectionViewCell
    func setupItem()
    func setupConstraint()
}
