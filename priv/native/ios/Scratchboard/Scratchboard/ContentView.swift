//
//  ContentView.swift
//  Scratchboard
//
//  Created by May Matyi on 10/28/22.
//

import SwiftUI
import LiveViewNative

struct ContentView: View {
    var body: some View {
        LiveView(coordinator: LiveViewCoordinator(URL(string: "http://localhost:4000")!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
