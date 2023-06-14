//
//  MobileView.swift
//  Scratchboard
//
//  Created by May Matyi on 10/28/22.
//

import SwiftUI
import LiveViewNative
import LiveViewNativeAVKit
import LiveViewNativeWebView

struct MyRegistry: CustomRegistry {
    typealias Root = AppRegistries
}

struct AppRegistries: AggregateRegistry {
    typealias Registries = Registry3<
        MyRegistry,
        AVKitRegistry<Self>,
        WebViewRegistry<Self>
    >
}

@MainActor
struct ContentView: View {
    @StateObject private var session: LiveSessionCoordinator<AppRegistries> = {
        var config = LiveSessionConfiguration()
        config.navigationMode = .enabled
        
        return LiveSessionCoordinator(URL(string: "http://127.0.0.1:4000/")!, config: config)
    }()

    var body: some View {
        LiveView(session: session)
    }
}
