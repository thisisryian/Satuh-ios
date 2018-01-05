//
//  Model.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/14/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import SwiftyJSON

public struct ApiModel<Element: Model>: Model {
    
    public private(set) var data: [Element] = []
    public private(set) var model: Element! = Element(json: JSON.init(parseJSON: ""))
    public private(set) var total: Int = 0
    public private(set) var totals: [String : Int] = [:]
    public private(set) var messages: [String] = []
    
    public var prefferedMessage: String {
        return (messages.count > 0) ? messages[0] : ""
    }
    
    public var listMessage: String {
        return messages.joined(separator: "\n")
    }
    
    // response yg standard
    public init(json: JSON) {
        messages = json["messages"].arrayValue.map { value in
            return value.stringValue
        }
        
        guard json["data"].arrayValue.count > 0 else {
            // model
            model = Element(json: json["data"])
            return
        }
        // array
        data = json["data"].arrayValue.map { value in
            return Element(json: value)
        }
        
        total = json["total"].int ?? Int(json["total"].string ?? "") ?? data.count
    }
    
    
    public init(json: JSON, dataKey: [String]) {
        var json = json
        
        messages = json["messages"].arrayValue.map { value in
            return value.stringValue
        }
        
        for key in dataKey {
            json = json[key]
        }
        guard json.arrayValue.count > 0 else {
            // model
            model = Element(json: json)
            return
        }
        // array
        data = json.arrayValue.map { value in
            return Element(json: value)
        }
        
        total = json["total"].int ?? Int(json["total"].string ?? "") ?? data.count
    }
    
    public init(json: JSON, dataKey: String) {
        messages = json["messages"].arrayValue.map { value in
            return value.stringValue
        }
        
        guard json["data"][dataKey].arrayValue.count > 0 else {
            // model
            model = Element(json: json["data"][dataKey])
            return
        }
        // array
        data = json["data"][dataKey].arrayValue.map { value in
            return Element(json: value)
        }
        
        total = json["total"].int ?? Int(json["total"].string ?? "") ?? data.count
    }
    
    public init(json: JSON, dataKey: String, totalKeys: [String]) {
        self.init(json: json, dataKey: dataKey)
        for key in totalKeys {
            totals[key] = json["data"][key].int ?? Int(json["data"][key].string ?? "0")
        }
        if totals.count == 1 {
            for (_, value) in totals {
                total = value
            }
        }
    }
    
}
