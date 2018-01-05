//
//  UICollectionView.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    @objc fileprivate func changePosition() {
        if self.cellForItem(at: IndexPath(item: tag, section: 0)) == nil {
            return
        }
        // get the current index position
        tag = currentIndex + 1
        
        // check if the current position is bigger than the collection size
        if (CGFloat(tag) * frame.size.width) >= contentSize.width {
            // if yes, then send it back to the first element of collectionViewCell
            tag = 0
        }
        scrollToItem(at: IndexPath(item: tag, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    public func setAsCarousel(withDelay delay: TimeInterval = 4) -> Timer {
        tag = 0
        return Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(changePosition), userInfo: nil, repeats: true)
    }
    
    public var currentPosition: Int {
        setNeedsLayout()
        layoutIfNeeded()
        return Int(contentOffset.x / frame.size.width)
    }
    
    public func setupNormalLayout(
        itemSize: CGSize,
        verticalSpacing vSpacing: CGFloat,
        horizontalSpacing hSpacing: CGFloat,
        insets: UIEdgeInsets,
        collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        
        // Horizontal Flow
        let layout = collectionViewLayout
        layout.scrollDirection = .horizontal
        layout.sectionInset = insets
        layout.minimumLineSpacing = vSpacing
        layout.minimumInteritemSpacing = hSpacing
        layout.itemSize = itemSize
        setCollectionViewLayout(layout, animated: true)
    }
    
    public func setupNormalLayout(
        numberOfItemsInRow totalItemsAtRow: CGFloat,
        itemHeightRatio heightRatio: CGFloat,
        verticalSpacing vSpacing: CGFloat,
        horizontalSpacing hSpacing: CGFloat,
        collectionViewWidth _width: CGFloat? = nil,
        insets: UIEdgeInsets = UIEdgeInsets(0),
        collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        
        // Vertical Flow
        let layout = collectionViewLayout
        layout.sectionInset = insets
        layout.minimumLineSpacing = vSpacing
        layout.minimumInteritemSpacing = hSpacing
        
        setNeedsLayout()
        layoutIfNeeded()
        // substract the edges of collectionView
        var width = _width ?? frame.size.width - insets.left - insets.right
        // substract the spacing between two items
        width -= ((totalItemsAtRow - 1) * hSpacing)
        // divide the width by total items in a row
        width /= totalItemsAtRow
        let height = (width * heightRatio)
        
        layout.itemSize = CGSize(
            width: width.rounded(.down),
            height: height
        )
        setCollectionViewLayout(layout, animated: true)
    }
    
    public func addRefreshControll(withTitle title: String = "Pull to refresh", target: UIViewController, selector: Selector, backgroundColor: UIColor = .clear) -> UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.backgroundColor = backgroundColor
        refresh.attributedTitle = NSAttributedString(string: title)
        refresh.addTarget(target, action: selector, for: .valueChanged)
        insertSubview(refresh, at: 0)
        return refresh
    }
    
    public func updateHeight(numberOfItemsInRow totalItem: CGFloat = 1, totalData: Int) {
        let total = CGFloat(totalData)
        let layout = (collectionViewLayout as! UICollectionViewFlowLayout)
        let height = layout.itemSize.height
        let totaldata = total / totalItem
        snp.updateConstraints { (make) in
            let value = Double(totaldata).rounded(.up)
            var items = CGFloat(value) * height
            items += layout.sectionInset.top + layout.sectionInset.bottom + (layout.sectionInset.bottom / 2)
            items += (layout.minimumLineSpacing * (totaldata - 1))
            make.height.equalTo(items)
        }
    }
}
