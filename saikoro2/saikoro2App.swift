//
//  saikoro2App.swift
//  saikoro2
//
//  Created by user on 2023/11/09.
//

import SwiftUI
import AppKit

@main
struct saikoro2App: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #endif
    var body: some Scene {
        WindowGroup {
            SwiftUIView()
        }
    }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate{
    private var statusItem: NSStatusItem!
    
    private var popover: NSPopover?
    
    @objc func terminate() {
        NSApp.terminate(self)
    }

//    @objc func openPreferencesWindow() {
//
//
//    }

    @objc func showPopover(_ sender: NSStatusBarButton) {
        
        guard let event = NSApp.currentEvent else { return }
                if event.type == NSEvent.EventType.rightMouseUp {
                    let menu = NSMenu()
//                    menu.addItem(
//                        withTitle: NSLocalizedString("Preference", comment: "Show preferences window"),
//                        action: #selector(openPreferencesWindow),
//                        keyEquivalent: ""
//                    )
//                    menu.addItem(.separator())
                    menu.addItem(
                        withTitle: NSLocalizedString("Quit", comment: "Quit app"),
                        action: #selector(terminate),
                        keyEquivalent: ""
                    )
                    statusItem?.popUpMenu(menu)
                    return
                }
        
        // NSPopoverのサイズを調整
        let popoverWidth: CGFloat =     250
        let popoverHeight: CGFloat = 300
        
        if popover == nil {
            let popover = NSPopover() // ↓ を追加
            popover.contentSize = NSSize(width: popoverWidth, height: popoverHeight)
            popover.behavior = .transient
            popover.animates = false
            self.popover = popover
            popover.contentViewController = NSHostingController(rootView:SwiftUIView())
        }
        
        
        
        popover?.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
        // popover?.show(...) の下に追加
        popover?.contentViewController?.view.window?.makeKey()
        
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let button = statusItem.button!

        // メニューバーの外観が明るいか暗いかを判定
        let isDarkMode = NSApp.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua

        if isDarkMode {
            // メニューバーが暗い場合のアイコン
            button.image = NSImage(named: "menuiconDark")
        } else {
            // メニューバーが明るい場合のアイコン
            button.image = NSImage(named: "menuicon")
        }
        
        // テンプレートとして扱われるように設定
        button.image?.isTemplate = true

        button.action = #selector(showPopover)

        NSApp.setActivationPolicy(.accessory)

        button.action = #selector(showPopover)
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        NSApp.windows.first?.orderOut(nil)
    }


}
#endif
