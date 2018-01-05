//
//  CarouselCollectionCell.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/9/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit

public class CarouselCollectionCell: UICollectionViewCell, Item {
    
    let banner = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(banner)
        
        setupConstraint()
        setupItem()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupItem() {
        
        banner.backgroundColor = .darkGray
    }
    
    internal func setupConstraint() {
        banner.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            
        }
        layoutIfNeeded()
        
        
    }
}
