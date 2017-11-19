//
//  DataTypeUtils.swift
//  JsonKit
//
//  Created by hai nguyen on 11/19/17.
//  Copyright © 2017 hai nguyen. All rights reserved.
//

import Foundation

enum JsonDataType {
    case string
    case number
    case object
    case array
    case boolean
    case null
    
    var name: String {
        get {
            return String(describing: self)
        }
    }
    
    static func getJsonType(value: Any?) -> JsonDataType {
        switch value {
        case is String:
            return .string
        case is Array<Any>:
            return .array
        case is Dictionary<String, Any>:
            return .object
        case is NSNull:
            return .null
        case nil:
            return .null
        default:
            return .number
        }
    }
}

extension String {
    public mutating func removeAChar(char: Character) {
        self = self.replacingOccurrences(of: String(char), with: "", options: NSString.CompareOptions.literal, range: nil)
    }
    
    public mutating func removeSpace() {
        self.removeAChar(char: " ")
    }
    
    public mutating func removeNewLineChar() {
        self.removeAChar(char: "\n")
    }
    
    public mutating func removeTabChar() {
        self.removeAChar(char: "\t")
    }
    
    public mutating func removeArrayChar(charArray: Array<Character>) {
        for aChar in charArray {
            self.removeAChar(char: aChar)
        }
    }
    
    func toDict() -> Dictionary<String, Any>! {
        let json = try? JSONSerialization.jsonObject(with: self.data(using: .utf8)!, options: [])
        if json is Dictionary<String, Any> {
            return json as! Dictionary<String, Any>
        }
        return nil
    }
    
    func toItem() -> Item! {
        guard let dict = self.toDict() else {
            return nil
        }
        return dict.toItem()
    }
}

extension Dictionary {
    func toItem() -> Item! {
        if self is Dictionary<String, Any> {
            return Item(json: self as! Dictionary<String, Any>)
        }
        return nil
    }
}
