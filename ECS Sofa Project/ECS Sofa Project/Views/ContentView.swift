//
//  ContentView.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = PortfolioViewModel()
    @StateObject private var dataController = DataController()
    
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
        .environmentObject(viewModel)
        .environmentObject(dataController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
