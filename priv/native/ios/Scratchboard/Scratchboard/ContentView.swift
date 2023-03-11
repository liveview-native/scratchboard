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
    @State private var session = LiveSessionCoordinator(URL(string: "http://localhost:4000/")!)
    
    var body: some View {
        LiveView(session: session)
    }
}
