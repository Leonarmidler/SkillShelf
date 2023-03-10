//
//  Portfolio.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var viewModel: PortfolioViewModel
    @EnvironmentObject private var dataController: DataController
    @State private var showingAlert = false
    let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns) {
                            ForEach(dataController.savedProjects) { project in
//                                let image = UIImage(data: project.image!)
//                                let tempTags = convertToTags(from: tagNames!)
//                                let newProject = ProjectModel(id: project.idCD!, image: image!, title: project.title!, summary: project.summary!, tags: tempTags)
                                NavigationLink {
                                    ProjectView(project: project)
                                } label: {
                                    ProjectPreview(project: project, height: geo.size.width * 0.3, radius: 12)
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        // the index of the selected project is saved
                                        viewModel.indexToDelete = dataController.savedProjects.firstIndex(of: project)!
                                        showingAlert = true
                                    } label: {
                                        Image(systemName: "trash")
                                        Text("Delete Project")
                                    }
                                }
                                .alert("Are you sure you want to delete this?", isPresented: $showingAlert) {
                                    Button("Delete", role: .destructive) {
                                        // the selected project is deleted
                                        dataController.deleteProject(indexToDelete: viewModel.indexToDelete)
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
                Button {
                    viewModel.isAddingProject = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.isAddingProject) {
                AddProjectModal(newProject: ProjectModel(id: UUID(), title: "", summary: "", tags: []))
            }
        }
        .environmentObject(viewModel)
        .environmentObject(dataController)
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(DataController())
            .environmentObject(PortfolioViewModel())
    }
}
