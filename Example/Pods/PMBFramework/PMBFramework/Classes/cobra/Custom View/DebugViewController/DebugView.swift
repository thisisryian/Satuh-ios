//
//  DebugView.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/26/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class DebugView: UIView {
    
    let faderBtn = UIButton()
    let pickerView = UIPickerView()
    let selectDateBtn = UIButton(text: "Select Date", color: UIColor.Main.blue)
    let debugTv = UITextView()
    let removeAllBtn = UIButton(text: "Remove All", color: UIColor.Main.red)
    
    init() {
        super.init(frame: mainScreen)
        
        setupSubviews([selectDateBtn, debugTv, removeAllBtn, faderBtn, pickerView])
        
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func showPicker(_ bool: Bool) {
        pickerView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self).offset((bool) ? 0 : screenSize.height)
        }
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.8) { 
            self.faderBtn.alpha = (bool) ? 1 : 0
            self.layoutIfNeeded()
        }
    }
    
    func setupView() {
        
        selectDateBtn.setLayer(cornerRadius: 8, borderWidth: 1, borderColor: .white)
        
        debugTv.isEditable = false
        debugTv.dataDetectorTypes = .all
        debugTv.font = UIFont.regular(.b3)
        
        removeAllBtn.setLayer(cornerRadius: 8, borderWidth: 1, borderColor: UIColor.Main.red)
        removeAllBtn.backgroundColor = UIColor.Main.red.alpha(0.3)
    }
    
    func setupConstraint() {
        
        selectDateBtn.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(Margin.s8)
            make.trailing.equalTo(self).offset(-Margin.s8)
            make.height.equalTo(Margin.s24)
        }
        
        debugTv.snp.makeConstraints { (make) in
            make.top.equalTo(selectDateBtn.snp.bottom).offset(Margin.s12)
            make.leading.trailing.equalTo(selectDateBtn)
        }
        
        removeAllBtn.snp.makeConstraints { (make) in
            make.top.equalTo(debugTv.snp.bottom).offset(Margin.s12)
            make.leading.trailing.equalTo(selectDateBtn)
            make.bottom.equalTo(self)
            make.height.equalTo(Margin.s24)
        }
        
        faderBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        pickerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self).offset(screenSize.height)
            make.height.equalTo((screenSize.height * 2) / 5)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
