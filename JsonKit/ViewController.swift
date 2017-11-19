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
        print("firt item : \(firstItem.string)")
        currentItem = firstItem
        currentElement =  currentItem?.elementList[0]
        outlineViewStructureData.reloadData()
        // send display structure data to observer TODO: need update observe pattern first
        
    }
    
    
}


// MARK: - <#NSOutlineViewDataSource#>
extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        let cout = (currentItem == nil) ? 0 : (currentItem!.childCout)
        print("cout : \(cout)")
        return cout
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return (currentItem == nil) ? Element(key: String(), value: nil) : currentItem!.elementList[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return (currentElement == nil) ? false : currentElement!.isExpandable
    }
}


// MARK: - <#NSOutlineViewDelegate#>
extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
//        let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "KeyCell"), owner: self) as? NSTableCellView
//        let valueView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ValueCell"), owner: self) as? NSTableCellView
        print("view for element : \(String(describing: item))")
        var view: NSTableCellView?
        if item is Element {
            if (tableColumn?.identifier)!.rawValue == "KeyColumn" {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "KeyCell"), owner: self) as? NSTableCellView
                let keyTextField = view?.textField
                keyTextField?.stringValue = (item as! Element).key
                keyTextField?.sizeToFit()
            } else if (tableColumn?.identifier)!.rawValue == "ValueColumn" {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ValueCell"), owner: self) as? NSTableCellView
                let valueTextField = view?.textField
                valueTextField?.stringValue = (item as! Element).getModel()
                valueTextField?.sizeToFit()
            }
//            if tableColumn?.identifier == "KeyColumn" {
//                view = outlineView.make(withIdentifier: "KeyCell", owner: self) as? NSTableCellView
//                let keyTextField = view?.textField
//                keyTextField?.stringValue = (item as! Element).key
//                keyTextField?.sizeToFit()
//            } else if tableColumn?.identifier == "ValueColumn" {
//                view = outlineView.make(withIdentifier: "ValueCell", owner: self) as? NSTableCellView
//                let valueTextField = valueView?.textField
//                valueTextField?.stringValue = (item as! Element).getModel()
//                valueTextField?.sizeToFit()
//            }
            return view
        }
        return nil
    }
}

