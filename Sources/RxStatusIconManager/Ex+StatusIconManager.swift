//
//  Ex+StatusIconManager.swift
//
//
//  Created by Kimun Kwon on 2021/06/23.
//

import AppKit
import RxSwift
import RxCocoa
import StatusIconManager

public extension Reactive where Base: StatusIconManager {
    
    private var delegate: RxStatusIconDelegateProxy {
        return RxStatusIconDelegateProxy.proxy(for: base)
    }
    
    var didOpen: ControlEvent<(didOpen: StatusIconManager, item: NSStatusItem)> {
        return ControlEvent(events: delegate.didOpenEvent)
    }
    
    var didClose: ControlEvent<(didOpen: StatusIconManager, item: NSStatusItem)> {
        return ControlEvent(events: delegate.didCloseEvent)
    }
}
