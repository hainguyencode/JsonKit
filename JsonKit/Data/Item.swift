//
//  Item.swift
//  JsonKit
//
//  Created by hai nguyen on 11/19/17.
//  Copyright © 2017 hai nguyen. All rights reserved.
//

import Foundation

enum ItemEntryType {
    case Normal
    case Array
    case Dictionary
}

class Item {
    private let rawDict: Dictionary<String, Any>
    var elementList = [Element]()
//    var arrayOfNormalItem = [Any]()
//    var arrayOfArrayItem = [Array<Any>]()
//    var arrayOfDictionary = [Dictionary<String, Any>]()
    var hasChild: Bool = false
//    {
//        get {
//            if (!arrayOfDictionary.isEmpty) ||
//                (!arrayOfArrayItem.isEmpty) {
//                return true
//            }
//            return false
//        }
//    }
    var isEmpty: Bool = true
//    {
//        get {
//            if (!arrayOfArrayItem.isEmpty) ||
//                (!arrayOfDictionary.isEmpty) ||
//                (!arrayOfNormalItem.isEmpty) {
//                return false
//            }
//            return true
//        }
//    }
    var string: String = String()
//    {
//        get {
//            var string: String = String()
//            if !arrayOfDictionary.isEmpty {
//                string += "array of dict : " + String(describing: arrayOfDictionary) + "\n"
//            }
//            if !arrayOfArrayItem.isEmpty {
//                string += "array of array : " + String(describing: arrayOfArrayItem) + "\n"
//            }
//            if !arrayOfNormalItem.isEmpty {
//                string += "array of other : " + String(describing: arrayOfNormalItem) + "\n"
//            }
//            return string
//        }
//    }
    var childCout: Int = 0
//    {
//        get {
//            return (arrayOfNormalItem.count + arrayOfArrayItem.count + arrayOfDictionary.count)
//        }
//    }
//    var firstElement: String? = nil
//    {
//        get {
//            if !arrayOfNormalItem.isEmpty {
//                return JsonDataType.getJsonType(value: arrayOfNormalItem.first).name
//            }
//            if !arrayOfArrayItem.isEmpty {
//                return JsonDataType.getJsonType(value: arrayOfArrayItem.first).name
//            }
//            if !arrayOfDictionary.isEmpty {
//                return JsonDataType.getJsonType(value: arrayOfDictionary.first).name
//            }
//            return nil
//        }
//    }
    
    
    init(json: [String: Any]) {
        rawDict = json
        print("rawDict: \(String(describing: rawDict))")
        for anEntry in rawDict {
            elementList.append(Element(key: anEntry.key, value: anEntry.value))
        }
        childCout = elementList.count
        if childCout > 0 {
            isEmpty = false
            hasChild = true
        }
        string = String(describing: elementList)
    }
}
