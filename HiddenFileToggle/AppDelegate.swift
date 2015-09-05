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

        // read finder AppleShowAllFiles field value
        let task = NSTask()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", "/usr/bin/defaults read com.apple.finder AppleShowAllFiles"]

        let pipe: NSPipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()

        let read = pipe.fileHandleForReading
        let dataRead = read.readDataToEndOfFile()
        let stringRead = NSString(data: dataRead, encoding: NSUTF8StringEncoding)

        if ( (stringRead as? String) == "YES" ) {
            statusItem.image = showIcon
        } else {
            statusItem.image = hiddenIcon
        }

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func showHiddenFileClicked(sender: NSMenuItem) {
        showIcon.setTemplate(true)
        hiddenIcon.setTemplate(true)

        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        
        if (sender.state == NSOnState) {
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
            statusItem.image = hiddenIcon
        }
        else {
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
            statusItem.image = showIcon
        }

        task.launch()
        task.waitUntilExit()

        // restart finder
        let restartFinder = NSTask()
        restartFinder.launchPath = "/usr/bin/killall"
        restartFinder.arguments = ["Finder"]
        restartFinder.launch()
    }

}

