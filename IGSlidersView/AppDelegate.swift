//
//  AppDelegate.swift
//  IGSlidersView
//
//  Created by Łukasz Dziedzic on 29/04/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Cocoa
import IGSliders

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var editViewController:IGSlidersController!
    @IBOutlet weak var editView: NSView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        editViewController.insertViewInto(editView)
        editViewController.readFromDefaults(self)

//        editView.addSubview(editViewController.view)
//        editViewController.view.frame = NSMakeRect(0, 0, editView.frame.width, editView.frame.height)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

