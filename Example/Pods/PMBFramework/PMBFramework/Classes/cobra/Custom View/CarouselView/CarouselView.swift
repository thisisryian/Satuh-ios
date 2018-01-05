//
//  CarouselView.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/9/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import Kingfisher

public class CarouselView: UIView, View {
    
    fileprivate var data: [ImageResource?] = []
    
    public let carousel = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    public  let shade = UIView()
    public  let picIcon = UIImageView()
    public  let totalPic = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        shade.setupSubviews([picIcon, totalPic])
        setupSubviews([carousel, shade])
        
        setupConstraint()
        setupView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data: [ImageResource?]) {
        self.data = data
        totalPic.text = "\(data.count)"
        
        carousel.delegate = self
        carousel.dataSource = self
    }
    
    internal func setupView() {
        
        carousel.register(CarouselCollectionCell.self, forCellWithReuseIdentifier: "cell")
        carousel.backgroundColor = .lightGray
        carousel.isPagingEnabled = true
        carousel.bounces = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        carousel.setupNormalLayout(
            itemSize: CGSize(width: screenSize.width, height: carousel.frame.height),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            insets: UIEdgeInsets(0),
            collectionViewLayout: layout
        )
        
        shade.backgroundColor = .grayAlpha
        
        //        picIcon.image = R.image.welcome_img()
        picIcon.tintColor = .white
        
        totalPic.textColor = .white
        totalPic.font = UIFont.light(.b1)
        
    }
    
    internal func setupConstraint() {
        
        carousel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(screenSize.height / 3)
        }
        
        shade.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(carousel)
        }
        
        picIcon.snp.makeConstraints { (make) in
            make.top.leading.equalTo(shade).offset(Margin.s8)
            make.bottom.equalTo(shade).offset(-Margin.s8)
            make.size.equalTo(20)
        }
        
        totalPic.snp.makeConstraints { (make) in
            make.centerY.equalTo(picIcon)
            make.leading.equalTo(picIcon.snp.trailing).offset(Margin.s8)
            make.trailing.equalTo(shade).offset(-Margin.s8)
        }
        layoutIfNeeded()
    }
    
}

extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarouselCollectionCell
        let this = data[indexPath.row]
        if let cover = this {
            cell.banner.kf.setImage(with: cover)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageController = ImageViewController()
        imageController.data = data
        imageController.currentIndex = collectionView.contentOffset.x / screenSize.width
        DSource.navbar?.present(imageController, animated: true, completion: nil)
    }
}
