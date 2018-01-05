//
//  URLRequest+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/21/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Foundation

extension URLRequest {
    public var shortUrlString: String {
        let path = url?.path ?? ""
        let query = url?.query ?? ""
        return "\(path)?\(query)"
    }
    
}
