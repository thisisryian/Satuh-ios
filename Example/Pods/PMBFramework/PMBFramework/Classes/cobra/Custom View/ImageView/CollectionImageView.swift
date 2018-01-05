//
//  CollectionImageView.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/9/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import Kingfisher

public class CollectionImageView: UIView, View {
    
    fileprivate var data: [ImageResource?] = []
    public var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    public var closeBtn = UIButton(type: .system)
    fileprivate let informationLabel = UILabel()
    fileprivate var prevIndex = 0
    
    public init() {
        super.init(frame: screenSize)
        backgroundColor = UIColor.init(hexa: 0x404040)
        
        setupSubviews([closeBtn, collectionView, informationLabel])
        
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(data: inout [ImageResource?], index: CGFloat) {
        self.data = data
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        self.collectionView.setContentOffset(CGPoint(x: index * screenSize.width, y: 0), animated: true)
        self.informationLabel.text = "\(Int(index) + 1) " + "dari" + " \(data.count)"
    }
    
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setupNormalLayout(itemSize: screenSize.size, verticalSpacing: 0, horizontalSpacing: 0, insets: UIEdgeInsets(0), collectionViewLayout: layout)
        collectionView.register(CollectionImageViewCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        closeBtn.setTitle(" X ", for: .normal)
        closeBtn.setTitleColor(.white, for: .normal)
        
        informationLabel.font = UIFont.systemFont(ofSize: 15)
        informationLabel.textColor = .white
        informationLabel.textAlignment = .center
    }
    
    func setupConstraint() {
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Margin.s24)
            make.leading.equalTo(self).offset(Margin.s12)
            make.size.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(closeBtn.snp.bottom).offset(Margin.s12)
            make.bottom.equalTo(informationLabel.snp.top).offset(-Margin.s12)
            make.leading.trailing.equalTo(self)
        }
        
        informationLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-Margin.s24)
            make.leading.trailing.equalTo(self)
        }
        
        layoutIfNeeded()
    }
    
}

extension CollectionImageView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionImageViewCollectionCell
        cell.image.kf.setImage(with: data[indexPath.row])
        return cell
    }
}

extension CollectionImageView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / screenSize.width)
        informationLabel.text = "\(index + 1) " + "dari" + " \(data.count)"
        guard index != prevIndex, let cell = collectionView.cellForItem(at: IndexPath(item: index - 1, section: 0)) as? CollectionImageViewCollectionCell else {
            return
        }
        cell.resetZoomValue()
    }
}
