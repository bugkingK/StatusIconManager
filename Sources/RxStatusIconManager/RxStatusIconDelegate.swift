//
//  RxStatusIconDelegateProxy.swift
//  
//
//  Created by Kimun Kwon on 2021/06/23.
//

import AppKit
import RxSwift
import RxCocoa
import StatusIconManager

final class RxStatusIconDelegateProxy: DelegateProxy<StatusIconManager, StatusIconDelegate> {
    
    let didOpenEvent = PublishSubject<(didOpen: StatusIconManager, item: NSStatusItem)>()
    let didCloseEvent = PublishSubject<(didOpen: StatusIconManager, item: NSStatusItem)>()
    
    init(statusIconManager: StatusIconManager) {
        super.init(parentObject: statusIconManager, delegateProxy: RxStatusIconDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxStatusIconDelegateProxy(statusIconManager: $0) }
    }
    
    static func currentDelegate(for object: StatusIconManager) -> StatusIconDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: StatusIconDelegate?, to object: StatusIconManager) {
        object.delegate = delegate
    }
    
}

extension RxStatusIconDelegateProxy: DelegateProxyType { }

extension RxStatusIconDelegateProxy: StatusIconDelegate {
    func statusView(didOpen: StatusIconManager, item: NSStatusItem) {
        didOpenEvent.onNext((didOpen, item))
    }
    
    func statusView(didClose: StatusIconManager, item: NSStatusItem) {
        didCloseEvent.onNext((didClose, item))
    }
}
