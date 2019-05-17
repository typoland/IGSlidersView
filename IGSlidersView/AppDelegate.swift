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
    @IBOutlet weak var previewController:PreviewController!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NotificationCenter.default.addObserver(
            self,
            selector: #selector ( redrawPreview ),
            name: Notification.Name.IGSlidersControllerStylesChanged,
            object: nil)
        editViewController.readFromDefaults(self)
        editViewController.insertViewInto(editView)
        previewController.redrawPreview(with: editViewController.instances)
        previewController.redrawSliders(with: editViewController.slidersCoordinates)
    }

    @objc func redrawPreview (_ notification:Notification) {
        guard let (coordinates, slidersData) = notification.object as? (coordinates:[(name:String, values:[Double])],
            sliders:[[[(styleName:String, value:Double)]]]) else {return}
        previewController.redrawSliders(with: slidersData)
        previewController.redrawPreview(with: coordinates)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

