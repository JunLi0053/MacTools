//
//  MTMenuItem.swift
//  MacTools
//
//  Created by Jun on 2020/4/3.
//  Copyright © 2020 Jun. All rights reserved.
//

import Cocoa

class MTMenuItem: NSCollectionViewItem {

    @IBOutlet weak var itemImageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
    }
    override var isSelected: Bool {
      didSet {
        view.layer?.backgroundColor = isSelected ? NSColor.init(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor : NSColor.clear.cgColor
      }
    }
    
}
