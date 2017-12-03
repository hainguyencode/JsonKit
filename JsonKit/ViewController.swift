//
//  ViewController.swift
//  JsonKit
//
//  Created by hai nguyen on 11/19/17.
//  Copyright © 2017 hai nguyen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var currentItem: Item? = nil
    var currentElement: Element? = nil
    
    // MARK: UI Elements
    @IBOutlet var txtViewRawData: NSTextView!
    @IBOutlet weak var chkBoxPrettyJson: NSButton!
    @IBOutlet weak var outlineViewStructureData: NSOutlineView!
    
    // MARK: NSViewController delegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    
    // MARK: handle actions
    
    /// process when user press parse button
    @IBAction func pressBtnButton(_ sender: Any) {
        print("raw text : \(txtViewRawData.string)")
        guard let firstItem = txtViewRawData.string.toItem() else {
            return
        }
        prepareItemAndElement(item: firstItem)
        outlineViewStructureData.reloadData()
        // send display structure data to observer TODO: need update observe pattern first
    }
}


// MARK: - <#NSOutlineViewDataSource#>
extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        print("child cout of \(item.debugDescription): \(String(describing: currentItem?.childCout))")
        if item is Element {
            let element = item as! Element
            if element.type == .object {
                if element.value is Dictionary<String, Any> {
                    prepareItemAndElement(item: (element.value as! Dictionary<String, Any>).toItem())
                }
            }
            if element.type == .array {
                if element.value is Array<Any> {
                    prepareItemAndElement(item: (element.value as! Array<Any>).toItem())
                }
            }
        }
        return (currentItem == nil) ? 0 : (currentItem!.childCout)
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        print("view for item: \(currentItem.debugDescription) with index: \(index)")
        if currentItem == nil {
            return Element(key: String(), value: nil)
        }
        if currentItem!.elementList.count <= index {
            return Element(key: String(), value: nil)
        }
        return currentItem!.elementList[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if (item is Element) {
            return (item as! Element).isExpandable
        }
        return false
    }
}


// MARK: - <#NSOutlineViewDelegate#>
extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        if item is Element {
            if (tableColumn?.identifier)!.rawValue == KeyCol {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: KeyCell), owner: self) as? NSTableCellView
                let keyTextField = view?.textField
                keyTextField?.stringValue = (item as! Element).key
                keyTextField?.sizeToFit()
            } else if (tableColumn?.identifier)!.rawValue == ValueCol {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: ValueCell), owner: self) as? NSTableCellView
                let valueTextField = view?.textField
                let element = (item as! Element)
                valueTextField?.stringValue = element.getModel()
                valueTextField?.sizeToFit()
            }
            return view
        }
        return nil
    }
}


// MARK: - work with item and element
extension ViewController {  // handle with item and element
    private func prepareItemAndElement(item: Item) {
        print("prepareItemAndElement item : \(item.string)")
        currentItem = item
        currentElement =  currentItem?.elementList[0]
    }
}

