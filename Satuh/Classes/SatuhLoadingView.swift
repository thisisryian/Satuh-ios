//
//  SatuhLoadingView.swift
//  Alamofire
//
//  Created by Denny Ong on 1/5/18.
//

import UIKit
import PMBFramework

class SatuhLoadingView: UIView {
    
    let backgroundView = UIView()
    let activity = UIActivityIndicatorView()
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .gray
        
        backgroundView.addSubview(activity)
        addSubview(backgroundView)
        
        setupConstraint()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
    func setupConstraint() {
        
        
        
        setNeedsLayout()
        layoutIfNeeded()
        
    }

}
