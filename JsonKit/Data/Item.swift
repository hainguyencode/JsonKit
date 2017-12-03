//
//  Item.swift
//  JsonKit
//
//  Created by hai nguyen on 11/19/17.
//  Copyright © 2017 hai nguyen. All rights reserved.
//

import Foundation

enum ItemEntryType {
    case Array
    case Dictionary
}

class Item {
    let type: ItemEntryType
    
    var elementList = [Element]()
    var hasChild: Bool = false
    var isEmpty: Bool = true
    var string: String = String()
    var childCout: Int = 0

    init(json: [String: Any]) {
        print("json: \(String(describing: json))")
        for anEntry in json {
            elementList.append(Element(key: anEntry.key, value: anEntry.value))
        }
        childCout = elementList.count
        if childCout > 0 {
            isEmpty = false
            hasChild = true
        }
        type = .Dictionary
        string = String(describing: elementList)
        print("elementList: \(elementList)")
    }
    
    init(json: Array<Any>) {
        print("rawArray: \(json.debugDescription)")
        var index = 0
        for anEntry in json {
            elementList.append(Element(key: String(index), value: anEntry))
            index += 1
        }
        childCout = elementList.count
        if childCout > 0 {
            isEmpty = false
            hasChild = true
        }
        type = .Array
        string = String(describing: elementList)
        print("elementList: \(elementList)")
    }
}
