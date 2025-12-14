//
//  tyme_itApp.swift
//  tyme-it
//
//  Created by Akhilesh Amle on 14/12/25.
//

import SwiftUI

@main
struct tyme_itApp: App {
    var body: some Scene {
        WindowGroup {
            StopwatchView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        // Optional: make the window background clear to blend content to edges
        // .windowResizability(.contentSize)
        #endif
    }
}
