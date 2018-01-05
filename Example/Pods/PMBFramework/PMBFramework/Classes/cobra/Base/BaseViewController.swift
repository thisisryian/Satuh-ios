//
//  BaseViewController.swift
//  Pods
//
//  Created by Denny Ong on 9/11/17.
//
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    public var disposable = DisposeBag()
    
    override open func viewDidDisappear(_ animated: Bool) {
        disposable = DisposeBag()
    }
    
}
