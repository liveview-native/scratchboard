//
//  ContentView.swift
//  Scratchboard
//
//  Created by May Matyi on 10/28/22.
//

import SwiftUI
import LiveViewNative

@MainActor
struct ContentView: View {
    @StateObject private var session: LiveSessionCoordinator<EmptyRegistry> = {
        var config = LiveSessionConfiguration()
        config.navigationMode = .enabled
        
        return LiveSessionCoordinator(URL(string: "http://127.0.0.1:5000/")!, config: config)
    }()

    var body: some View {
        LiveView(session: session)
    }
}
