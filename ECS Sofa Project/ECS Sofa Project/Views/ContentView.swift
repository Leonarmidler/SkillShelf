//
//  ContentView.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataController = DataController()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView {
            PortfolioView()
                .tabItem {
                    Text("Portfolio")
                    Image(systemName: "tray.full")
                }.tag(1)
            InProgressView()
                .tabItem {
                    Text("In Progress")
                    Image(systemName: "checklist")
                }.tag(2)
        }
        .environmentObject(dataController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataController())
    }
}
