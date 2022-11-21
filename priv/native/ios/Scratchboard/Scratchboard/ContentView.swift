//
//  ContentView.swift
//  Scratchboard
//
//  Created by May Matyi on 10/28/22.
//

import SwiftUI
import PhoenixLiveViewNative

struct ContentView: View {
    @State var coordinator = LiveViewCoordinator(URL(string: "http://localhost:4000/hello")!)

    var body: some View {
        LiveView(coordinator: coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
