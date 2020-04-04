//
//  ViewController.swift
//  MacTools
//
//  Created by Jun on 2020/3/28.
//  Copyright © 2020 Jun. All rights reserved.
//

import Cocoa
import Masonry

class ViewController: NSViewController, NSTextViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var container: NSView!
    @IBOutlet weak var menuCollectionView: NSCollectionView!
    
    let menuIcon = ["json","json"]
    var jsonVC : MTJsonVC!
    var scheduleVC : MTScheduleVC!
    var vcs = [NSViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(MTMenuItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(MTMenuItem.className()))
        menuCollectionView.selectItems(at: [IndexPath.init(item: 0, section: 0)], scrollPosition: NSCollectionView.ScrollPosition.top)
        
        configVC()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func configVC() {
        jsonVC = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MTJsonVC") as? MTJsonVC
        self.addChild(jsonVC)
        self.container.addSubview(jsonVC.view)
        jsonVC.view.mas_makeConstraints { (make) in
            make?.edges.equalTo()(0);
        }
        vcs.append(jsonVC)
        
        scheduleVC = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MTScheduleVC") as? MTScheduleVC
        self.addChild(scheduleVC)
        self.container.addSubview(scheduleVC.view)
        scheduleVC.view.isHidden = true
        scheduleVC.view.mas_makeConstraints { (make) in
            make?.edges.equalTo()(0);
        }
        vcs.append(scheduleVC)
    }
    
    func switchVC(_ item: Int!) {
        for (index, vc) in vcs.enumerated() {
            vc.view.isHidden = index != item
        }
    }
    
    // 返回Item个数
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuIcon.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item:MTMenuItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init(MTMenuItem.className()), for: indexPath) as! MTMenuItem
        item.itemImageView.image = NSImage.init(named: NSImage.Name.init(menuIcon[indexPath.item]))!
        return item
    }
    // 点击方法
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let indexPath = indexPaths.first!
        print("items select",indexPath.item)
        switchVC(indexPath.item)
    }
    
    // 返回Item的size
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize.init(width: 80, height: 60)
    }

}


