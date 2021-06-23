# StatusIconManager

Put icons in the status bar quickly and easily.

The StatusIconDelegate allows you to track open and close. It also supports Rx.


## Preview
![](/assets/example.png)

## Using
```swift
let sb = NSStoryboard(name: "Main", bundle: .main)
let vc = sb.instantiateController(withIdentifier: "ViewController") as? NSViewController
StatusIconManager.shared.set(icon: .init(named: "icon-status"), viewController: vc)

func statusView(didOpen: StatusIconManager, item: NSStatusItem) {
    
}

func statusView(didClose: StatusIconManager, item: NSStatusItem) {
    
}

```

## License

<i>StatusIconManager</i> is available under the MIT license. See the LICENSE file for more info.
