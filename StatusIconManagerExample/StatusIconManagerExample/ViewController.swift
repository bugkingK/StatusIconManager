//
//  ViewController.swift
//  StatusIconManagerExample
//
//  Created by Kimun Kwon on 2021/06/23.
//

import Cocoa
import RxSwift
import StatusIconManager
import RxStatusIconManager

class ViewController: NSViewController {
    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        StatusIconManager.shared.rx.didOpen
            .subscribe(onNext: { _ in debugPrint("didOpen") })
            .disposed(by: disposeBag)
        
        StatusIconManager.shared.rx.didClose
            .subscribe(onNext: { _ in debugPrint("didClose") })
            .disposed(by: disposeBag)
    }
}

