//
//  CollectionImageViewCollectionCell.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/9/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit

public class CollectionImageViewCollectionCell:  UICollectionViewCell, Item {
    
    public let scrollView = UIScrollView()
    public let image = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        scrollView.addSubview(image)
        addSubview(scrollView)
        
        setupConstraint()
        setupItem()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        image.contentMode = .scaleAspectFit
    }
    
    func setupConstraint() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.width.equalTo(self)
        }
        
        image.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.center.equalTo(scrollView)
        }
    }
    
    func resetZoomValue() {
        scrollView.zoomScale = 1.0
    }
    
}

extension CollectionImageViewCollectionCell: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
}
