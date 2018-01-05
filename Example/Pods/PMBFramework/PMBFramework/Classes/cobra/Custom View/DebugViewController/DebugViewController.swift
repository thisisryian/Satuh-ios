//
//  DebugViewController.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/26/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class DebugViewController: UIViewController {
    lazy var root = DebugView()
    var disposable = DisposeBag()

    public var dates = Variable<[String]>([])
    public var log: Variable<String> = Variable<String>("")
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DSource.tabbar.navigationItem.title = "Debug Log"
        DSource.tabbar.navigationItem.leftBarButtonItems = []
        DSource.tabbar.navigationItem.rightBarButtonItems = []
        
        root.faderBtn.rx.tap.subscribe { _ in
            self.root.showPicker(false)
            }.disposed(by: disposable)
        
        dates.asObservable().bind(to: root.pickerView.rx.itemTitles) { (row, model) in
            return model
            }.disposed(by: disposable)
        
        root.pickerView.rx.itemSelected.subscribe(onNext: { (row: Int, component: Int) in
            debug(key: "Debug PickerView", "selected row \(row)")
        }).disposed(by: disposable)
        
        root.selectDateBtn.rx.tap.subscribe { _ in
            var tag = self.root.selectDateBtn.tag
            tag = (tag == 0) ? 1 : 0
            self.root.selectDateBtn.tag = tag
            self.root.showPicker(tag == 0)
            }.disposed(by: disposable)
        
        log.asObservable().subscribe(onNext: { (str) in
            self.root.debugTv.text = str
        }).disposed(by: disposable)
        
        root.removeAllBtn.rx.tap.subscribe { _ in
            DebugData.removeAll()
            }.disposed(by: disposable)
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposable = DisposeBag()
    }
    
}
