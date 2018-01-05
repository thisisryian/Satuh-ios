//
//  XPopUpPickerDataSource.swift
//  SGByte-Property
//
//  Created by Mic Limz on 8/12/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import RxDataSources

public struct RowData {
    public var rowTitle : String
    public var tag : Any?
    
    public init(rowTitle: String, tag : Any? = nil){
        self.rowTitle = rowTitle
        self.tag = tag
    }
}

public struct TableData {
    public var header: String
    public var items: [Item]
}

extension TableData: SectionModelType {
    public typealias Item = RowData
    
    public init(original: TableData, items: [Item]) {
        self = original
        self.items = items
    }
}
