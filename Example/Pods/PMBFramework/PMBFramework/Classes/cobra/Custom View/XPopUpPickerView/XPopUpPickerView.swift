//
//  XPopUpPickerView.swift
//  SGByte-Property
//
//  Created by Mic Limz on 8/11/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit


public class XPopUpPickerView : UIView {
    
    private(set) var XPopUpTable : UITableView! = UITableView()
    public let containerV = UIView()
    public let okButton = UIButton(text: "Confirm", color: .white, buttonType: .system)
    public let cancelButton = UIButton(text: "Cancel", color: .white, buttonType: .system)
    public let dismissButton = UIButton()
    
    public init() {
        super.init(frame: screenSize)
        backgroundColor = .grayAlpha
        
        setupSubviews([dismissButton, containerV, okButton, cancelButton, XPopUpTable])
        setupConstraint()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        XPopUpTable.register(XPopUpPickerTableCell.self, forCellReuseIdentifier: "cell")
        XPopUpTable.separatorStyle = .none
        XPopUpTable.bounces = false
        XPopUpTable.setLayer(cornerRadius: 5)
        okButton.backgroundColor = .primary
        cancelButton.backgroundColor = UIColor.init(hexa: 0x069cc4)
        containerV.setLayer(cornerRadius: 5)
        containerV.backgroundColor = .white

    }
    
    func setupConstraint() {
        containerV.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Margin.s32 * UI(1,2))
            make.leading.equalTo(self).offset(Margin.s16 * UI(1,2))
            make.trailing.equalTo(self).offset(-Margin.s16 * UI(1,2))
            make.bottom.equalTo(self).offset(-Margin.s32 * UI(1,2))
        }
        XPopUpTable.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerV)
        }
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(XPopUpTable.snp.bottom)
            make.leading.bottom.equalTo(containerV)
        }
        okButton.snp.makeConstraints { (make) in
            make.top.equalTo(cancelButton)
            make.leading.equalTo(cancelButton.snp.trailing)
            make.trailing.bottom.equalTo(containerV)
        }
        dismissButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }

}
