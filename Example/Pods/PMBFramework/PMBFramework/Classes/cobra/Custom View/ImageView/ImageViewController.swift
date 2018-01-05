//
//  ImageViewController.swift
//  SGByte-Property
//
//  Created by Roni Aja on 8/9/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import Kingfisher

public class ImageViewController: BaseViewController {
    lazy var root = CollectionImageView()
    public var data: [ImageResource?] = []
    public var currentIndex: CGFloat = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        root.setupData(data: &data, index: currentIndex)
        root.closeBtn.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        root.collectionView.layoutIfNeeded()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc public func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
}
