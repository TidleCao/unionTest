//
//  ViewController.swift
//  UnionTest
//
//  Created by jifu on 29/05/2017.
//  Copyright © 2017 UnionTest. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var navigationController: NavigationController! = {
        return NavigationController(nibName: "NavigationController", bundle: Bundle.main)!
        
    }()
    
    @IBOutlet weak var contentView: NSView!
    
    @IBOutlet weak var navigationView: NSView! {
        didSet {
            navigationView.addSubview(navigationController.view)
            navigationController.view.setFrameSize(navigationView.bounds.size)
        }
    }
    @IBOutlet weak var splitView: NSSplitView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

