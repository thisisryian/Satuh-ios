//
//  XCarouselView.swift
//  SGByte-Property
//
//  Created by Mic Limz on 8/30/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

//import UIKit
//import RxSwift
//import RxCocoa
//import Kingfisher
//
//public class XCarouselView<T: Model>: UICollectionView {
//
//    private var data = Variable<[T]>([])
//
//    public var total: Int {
//        return data.value.count
//    }
//
//    public var currentText: String {
//        return "\(currentPosition + 1) of \(total)"
//    }
//
//    public init() {
//        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
//        setupView()
//
//    }
//
//    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
//
//        setupView()
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupView() {
//        backgroundColor = .black
//        register(XCarouselCell.self, forCellWithReuseIdentifier: "cell")
//        isPagingEnabled = true
//    }
//
//    public func reloadLayout() {
//        setNeedsLayout()
//        layoutIfNeeded()
//        setupNormalLayout(itemSize: frame.size, verticalSpacing: 0, horizontalSpacing: 0, insets: UIEdgeInsets.zero)
//    }
//
//    public func set(data: [T]) {
//        self.data.value = data
//    }
//
//    public func bindData(disposable: DisposeBag, _ callback: @escaping ((Int, T, XCarouselCell)->Void)) {
//        data.asObservable().bind(to: self.rx.items(cellIdentifier: "cell", cellType: XCarouselCell.self)) { (index, model, cell) in
//            callback(index, model, cell)
//        }.addDisposableTo(disposable)
//    }
//
//
//
//    public func scrollTo(index: Int, animated: Bool = true) {
//        guard index >= 0 && index < total else { return }
//        setNeedsLayout()
//        layoutIfNeeded()
//        setContentOffset(CGPoint(x: (CGFloat(index) * frame.size.width) ,y : 0), animated: true)
//    }
//
//    public func index(ofCell index: Int) -> XCarouselCell? {
//        guard index >= 0 && index < total else { return nil }
//        return cellForItem(at: IndexPath(item: index, section: 0)) as? XCarouselCell
//    }
//
//    public func index(ofModel index: Int) -> T? {
//        guard index >= 0 && index < total else { return nil }
//        return data.value[index]
//    }
//
//}

