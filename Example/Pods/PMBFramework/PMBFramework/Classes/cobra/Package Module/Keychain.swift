//
//  Keychain.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/21/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Foundation

import Security

let kSecClassValue = kSecClass as NSString
let kSecValueDataValue = kSecValueData as NSString
let kSecMatchLimitValue = kSecMatchLimit as NSString
let kSecReturnDataValue = kSecReturnData as NSString
let kSecAttrAccountValue = kSecAttrAccount as NSString
let kSecAttrServiceValue = kSecAttrService as NSString
let kSecMatchLimitOneValue = kSecMatchLimitOne as NSString
let kSecClassGenericPasswordValue = kSecClassGenericPassword as NSString

public class Keychain {
    
    public class func deleteToken() {
        Keychain.LoginToken.delete()
        Keychain.PermanentToken.delete()
    }
    
    public class PermanentToken {
        public class func save(_ token: String) {
            Keychain.save(DSource.Generate.permanentToken, data: token)
        }
        
        public class func load() -> String? {
            return Keychain.loadKey(DSource.Generate.permanentToken) as? String
        }
        
        public class func delete() {
            Keychain.deletekey(DSource.Generate.permanentToken)
        }
    }
    
    public class LoginToken {
        public class func save(_ token: String) {
            Keychain.save(DSource.Generate.loginToken, data: token)
        }
        
        public class func load() -> String? {
            return Keychain.loadKey(DSource.Generate.loginToken) as? String
        }
        
        public class func delete() {
            Keychain.deletekey(DSource.Generate.loginToken)
        }
    }
    
    public class func save(_ saveData: String, data: String) {
        guard let dataFromString = data.data(using: .utf8, allowLossyConversion: false) else { return }
        
        let keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, saveData, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecValueDataValue])
        
        if SecItemCopyMatching(keychainQuery as CFDictionary, nil) == noErr {
            SecItemDelete(keychainQuery as CFDictionary)
            Keychain.save(saveData, data: data)
        }
        else {
            _ = SecItemAdd(keychainQuery as CFDictionary, nil)
            // OSStatus
            //            debug("\(saveData) = \(data); status = \(status)")
        }
    }
    
    public class func loadKey (_ service: String) -> AnyObject? {
        var result : String!
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        
        guard status == errSecSuccess else { return nil }
        
        let retrievedData : Data? = dataTypeRef as? Data
        result = String (data: retrievedData!, encoding: .utf8)
        return result as AnyObject?
    }
    
    public class func deletekey(_ key: String) {
        let keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key], forKeys: [kSecClassValue, kSecAttrServiceValue])
        _ = SecItemDelete(keychainQuery as CFDictionary)
        // OSStatus
        //        debug("Delete Keychain with key \(key) = \(status)")
    }
    
}
