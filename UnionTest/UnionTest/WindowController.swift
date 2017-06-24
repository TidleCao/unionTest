//
//  WindowController.swift
//  UnionTest
//
//  Created by jifu on 29/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let win = window {
            win.titleVisibility = .hidden
            win.titlebarAppearsTransparent = true
            win.styleMask.insert(.fullSizeContentView)
            win.isMovableByWindowBackground = true
        }
        
    }
    
}
