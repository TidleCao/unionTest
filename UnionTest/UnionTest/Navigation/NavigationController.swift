//
//  NavigationController.swift
//  UnionTest
//
//  Created by jifu on 29/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

import Cocoa

class NavigationItem: NSObject {
    var itemName: String = ""
    var children: [NavigationItem]?
    
    convenience init(itemName: String, children: [NavigationItem]) {
        self.init(itemName: itemName)
        self.children = children
    }
    
    convenience init(itemName: String) {
        self.init()
        self.itemName = itemName
        self.children = nil
    }
}

class NavigationController: NSViewController {
    var items: [NavigationItem] = {
        let testStation = NavigationItem(itemName: "TestStation")
        
        let workspace = NavigationItem(itemName: "WORKSPACE", children: [testStation])
        let stationSettings = NavigationItem(itemName: "Station")
        
        let settings = NavigationItem(itemName: "SETTINGS", children: [stationSettings])
        return [workspace, settings]
    }()
    
    @IBOutlet weak var outlineView: NSOutlineView!
        {
        didSet {
            outlineView.delegate = self
            outlineView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.expandItem(nil, expandChildren: true)
    }
   

}

extension NavigationController: NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {

        if let item = item as? NavigationItem {
           return item.children?.count ?? 0
        }
        
       return items.count
    }
    

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let item = item as? NavigationItem {
            let isLeaf = (item.children?.count ?? 0 ) == 0
            return !isLeaf;
        }
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? NavigationItem {
            return item.children![index]
        }
        return items[index]
    }
    

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var cellView: NSTableCellView!
        if let item = item as? NavigationItem {
            if let count = item.children?.count, count > 0 {
                cellView = outlineView.make(withIdentifier: "HeaderCell", owner: self) as! NSTableCellView
                cellView.textField?.stringValue = item.itemName
            }else {
                cellView = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView
                cellView.textField?.stringValue = item.itemName
            }
        }
       // cellView.textField?.sizeToFit()
        
        return  cellView
    }

}
