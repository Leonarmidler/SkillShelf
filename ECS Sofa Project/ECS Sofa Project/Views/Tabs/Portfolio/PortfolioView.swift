//
//  Portfolio.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct PortfolioView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @StateObject private var dataController = DataController()
    @State private var showingAlert: Bool = false
    let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns) {
                            ForEach(dataController.savedProjects) { project in
                                let image = UIImage(data: project.image!)
                                
                                let newProject = ProjectModel(id: project.idCD!, image: image!, title: project.title!, summary: project.summary!, tags: [])
                                NavigationLink(destination: {
                                    ProjectView(project: newProject)
                                }, label: {
                                    ProjectPreview(project: newProject, height: geo.size.width * 0.3, radius: 12)
                                })
                                .contextMenu {
                                    Button(role: .destructive) {
                                        showingAlert = true
                                    } label: {
                                        Image(systemName: "trash")
                                        Text("Delete Project")
                                    }
                                }
                                .alert("Are you sure you want to delete this?", isPresented: $showingAlert) {
                                    Button("Delete", role: .destructive) {
                                        dataController.deleteProject(project: project)
                                    }
                                    Button("Cancel", role: .cancel) { }
                                } message: {
                                    Text("There is no undo.")
                                }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Portfolio")
            .toolbar {
                Button(action: {
                    viewModel.isAddingProject = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $viewModel.isAddingProject) {
                AddProjectModal(idProject: UUID(),newProject: ProjectModel(id: UUID(), title: "", summary: "", tags: []))
            }
        }
        .environmentObject(viewModel)
        .environmentObject(dataController)
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
