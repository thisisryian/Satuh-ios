//
//  SatuhLoadingView.swift
//  Alamofire
//
//  Created by Denny Ong on 1/5/18.
//

import UIKit
import PMBFramework

class SatuhLoadingView: UIView {
    
    let activityIndicator = UIActivityIndicatorView()
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = UIColor.black.alpha(0.5)
        
        addSubview(activityIndicator)
        setupConstraint()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
    }
    
    func setupConstraint() {

        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}
