//
//  PickerView.swift
//  DPM
//
//  Created by DickyChengg on 5/3/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class PickerView: UIView, View {
    
    static let pickerWidth = screenSize.width - 32
    
    public let contentView = UIView()
    private let view = UIView()
    public let title = UILabel(text: "", color: .secondGray)
    
    public let pickerView = UIPickerView()
    
    public let dismissBtn = UIButton()
    public let selectBtn = UIButton(text: "Pilih", color: .white)
    public let cancelBtn = UIButton(text: "Batal", color: .white)
    
    public init() {
        super.init(frame: mainScreen)
        backgroundColor = .backgroundAlpha
        
        view.addSubview(title)
        contentView.setupSubviews([view, pickerView, selectBtn, cancelBtn])
        setupSubviews([dismissBtn, contentView])
        
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.setLayer(cornerRadius: 5)
        
//        title.font = UIFont.mediumFont(ofSize: 15)
        title.textAlignment = .center
        
        pickerView.backgroundColor = .white
        pickerView.setLayer(cornerRadius: 5)
        
        selectBtn.backgroundColor = .primary
        selectBtn.titleLabel?.font = UIFont.regular(.b1)
        selectBtn.setLayer(cornerRadius: 4)
        
        cancelBtn.backgroundColor = .secondary
        cancelBtn.titleLabel?.font = UIFont.semiBold(.h4)
        cancelBtn.setLayer(cornerRadius: 4)
    }
    
    func setupConstraint() {
        dismissBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(self)
        }
        
        view.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.width.equalTo(PickerView.pickerWidth)
            make.centerX.equalTo(contentView)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.leading.equalTo(view).offset(UI(Margin.s8))
            make.bottom.trailing.equalTo(view).offset(-UI(Margin.s8))
        }
        
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom).offset(UI(Margin.s4))
            make.bottom.equalTo(selectBtn.snp.top).offset(-UI(Margin.s16))
            make.width.equalTo(view)
            make.height.equalTo(screenSize.height * 1 / 4)
            make.centerX.equalTo(contentView)
        }
        
        selectBtn.snp.makeConstraints { (make) in
            make.bottom.trailing.equalTo(contentView).offset(-UI(Margin.s16))
            make.width.equalTo((screenSize.width - 44) / 2)
            make.height.equalTo(35)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(selectBtn)
            make.leading.equalTo(contentView).offset(UI(Margin.s16))
            make.size.equalTo(selectBtn)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
