//
//  RestApiError.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/22/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//


import SwiftyJSON

public class ApiError: Error {
    
    public var listArray: [String] = []
    public var listString: String {
        return listArray.joined(separator: "\n")
    }
    public var statusCode: Int = 0
    public var messages: String = ""
    public var error: String = ""
    
    init() {} // fileprivate
    
    public init(json: JSON, error: Error?, code: Int) { // fileprivate
        if let data = json["error"].array {
            listArray = data.map { value in
                return value.stringValue
            }
        } else {
            listArray = [json["error"].stringValue]
        }
        
        self.error = error?.localizedDescription ?? ""
        messages = json["message"].stringValue
        statusCode = code
        apiLog(key: "Api Error JSON", error)
        apiLog(key: "Api Error Response", listString)
        apiLog(key: "Api Error Message", messages)
        apiLog(key: "Status Code", statusCode)
        apiLog(key: "Localized Error", self.error)
    }
    
    public func first() -> String {
        return listArray.first ?? ""
    }
    
    public func unreachable() { // fileprivate
        statusCode = 0
        messages = "Unable to connect to the internet"
        listArray = [messages]
    }
}
