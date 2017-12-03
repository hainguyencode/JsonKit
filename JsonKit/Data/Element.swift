//
//  Element.swift
//  JsonKit
//
//  Created by hai nguyen on 11/19/17.
//  Copyright © 2017 hai nguyen. All rights reserved.
//

import Foundation

struct Element {
    let key: String
    let value: Any?
    public let type: JsonDataType
    let isExpandable: Bool
    
    
    /// init from dict element
    ///
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - value: <#value description#>
    init(key: String, value: Any?) {
        self.key = key
        self.value = value
        type = JsonDataType.getJsonType(value: self.value)
        switch type {
        case .array, .object:
            isExpandable = true
        default:
            isExpandable = false
        }
    }
    
    func getModel() -> String! {
        switch type {
        case .array, .object, .null:
            return type.name
        case .string:
            return value as! String
        default:
            if value is Int {
                return String(value as! Int)
            }
            if value is UInt {
                return String(value as! UInt)
            }
            if value is Float {
                return String(value as! Float)
            }
            if value is Double {
                return String(value as! Double)
            }
            return nil
        }
    }
    
    func toItem() -> Item! {
        switch self.type {
        case .array:
            return Item(json: self.value as! Array<Any>)
        case .object:
            return Item(json: self.value as! Dictionary<String, Any>)
        default:
            return nil
        }
    }
}
