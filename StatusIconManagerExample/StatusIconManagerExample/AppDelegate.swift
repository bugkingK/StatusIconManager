//
//  AppDelegate.swift
//  StatusIconManagerExample
//
//  Created by Kimun Kwon on 2021/06/23.
//

import Cocoa
import StatusIconManager

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let sb = NSStoryboard(name: "Main", bundle: .main)
        let vc = sb.instantiateController(withIdentifier: "ViewController") as? NSViewController
        StatusIconManager.shared.set(icon: .init(named: "icon-status"), viewController: vc)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

