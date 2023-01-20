//
//  Portfolio.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @StateObject private var viewModel = PortfolioViewModel()
    let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.projectArray) { project in
                                NavigationLink(destination: {
                                    ProjectView(project: project)
                                }, label: {
                                    ProjectPreview(project: project, height: geo.size.width * 0.3, radius: 12)
                                })
                            }
                            .navigationTitle("Portfolio")
                        }
                        .padding()
                        Spacer()
                    }
                    .toolbar {
                        Button(action: {
                            viewModel.isAddingProject = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    .sheet(isPresented: $viewModel.isAddingProject) {
                        AddProjectModal(viewModel: viewModel)
                    }
                }
            }
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .preferredColorScheme(.dark)
    }
}
