//
//  StatusIconManager.swift
//  
//
//  Created by Kimun Kwon on 2021/06/23.
//

import AppKit

public protocol StatusIconDelegate: AnyObject {
    func statusView(didOpen: StatusIconManager, item: NSStatusItem)
    func statusView(didClose: StatusIconManager, item: NSStatusItem)
}

open class StatusIconManager: NSObject {
    public static let shared: StatusIconManager = .init()
    private let popover: NSPopover = .init()
    private let statusIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private var eventMonitor: EventMonitor = .init(mask: [.leftMouseUp, .rightMouseUp])
    public var delegate: StatusIconDelegate?
    
    private override init() {
        super.init()
        eventMonitor.handler = { [weak self] _ in
            if self?.popover.isShown == true {
                self?.close()
            }
        }
        
        if let button = self.statusIcon.button {
            button.target = self
            button.action = #selector(toggle)
            button.focusRingType = .none
            button.setButtonType(.pushOnPushOff)
        }
    }
    
    open func set(icon: NSImage?, viewController: NSViewController?) {
        statusIcon.button?.image = icon
        popover.contentViewController = viewController
    }
    
    open func set(icon: NSImage?, window: NSWindowController) {
        self.set(icon: icon, viewController: window.contentViewController)
    }
    
    @objc open func toggle() {
        if popover.isShown {
            close()
        } else {
            show()
        }
    }
    
    public func show() {
        guard let button = statusIcon.button else {
            fatalError("Status Item button does not exist.")
        }
        
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        delegate?.statusView(didOpen: self, item: statusIcon)
        eventMonitor.start()
    }
    
    public func close() {
        popover.close()
        delegate?.statusView(didClose: self, item: statusIcon)
        eventMonitor.stop()
    }
}

final fileprivate class EventMonitor: NSObject {
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    fileprivate var handler: ((NSEvent?) -> Void)?
    
    public init(mask: NSEvent.EventTypeMask, handler: ((NSEvent?) -> Void)? = nil) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        guard let handler = handler else { return }
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
