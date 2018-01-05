//
//  XPopUpPickerTableCell.swift
//  SGByte-Property
//
//  Created by Mic Limz on 8/11/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import RxDataSources

public class XPopUpPickerTableCell : UITableViewCell {
    public let label = UILabel()
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(label)
        setupCell()
        setupConstraint()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        label.font = UIFont.semiBold(.h4)
        
    }
    
    func setupConstraint() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Margin.s4 * UI(1, 3))
            make.bottom.equalTo(self).offset(-Margin.s4 * UI(1, 3))
            make.leading.equalTo(self).offset(Margin.s8 * UI(1, 1.5))
            make.trailing.equalTo(self).offset(-Margin.s8 * UI(1, 1.5))
        }

        setNeedsLayout()
        layoutIfNeeded()
    }

}
