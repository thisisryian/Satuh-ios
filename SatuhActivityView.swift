//
//  SatuhActivityView.swift
//  Alamofire
//
//  Created by Denny Ong on 1/4/18.
//

import UIKit
import PMBFrameworkd

class SatuhActivityView: UIView {
    
    init() {
        super.init(frame: mainScreen)
        backgroundColor = .background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func setupView() {
        
    }
    
    func setupConstraint() {
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
