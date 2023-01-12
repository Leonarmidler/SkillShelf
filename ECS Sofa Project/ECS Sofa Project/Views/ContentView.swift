//
//  ContentView.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView {
            Portfolio()
                .tabItem {
                    Text("Portfolio")
                    Image(systemName: "tray.full")
                }.tag(1)
            InProgress()
                .tabItem {
                    Text("In Progress")
                    Image(systemName: "checklist")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
