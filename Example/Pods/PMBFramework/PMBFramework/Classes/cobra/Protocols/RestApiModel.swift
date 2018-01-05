//
//  RestApiModel.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/22/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import SwiftyJSON

public protocol Model {
    init(json: JSON)
}
