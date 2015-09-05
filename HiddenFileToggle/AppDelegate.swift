//
//  AppDelegate.swift
//  HiddenFileToggle
//
//  Created by 孔凡 on 15/9/5.
//  Copyright (c) 2015年 Frank Kung. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet var statusMenu: NSMenu!
    
    let showIcon: NSImage = NSImage(named: "showIcon")!
    let hiddenIcon: NSImage = NSImage(named: "hiddenIcon")!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        showIcon.setTemplate(true)
        hiddenIcon.setTemplate(true)
        // add status menu
        statusItem.menu = statusMenu
        statusItem.image = showIcon

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

