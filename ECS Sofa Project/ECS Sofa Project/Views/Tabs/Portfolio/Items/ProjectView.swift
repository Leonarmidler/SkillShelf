//
//  ProjectView.swift
//  ECS Sofa Project
//
//  Created by Alessandro Cei on 19/01/23.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var viewModel: PortfolioViewModel
    
    var project: ProjectEntity 
    let columns: [GridItem] = [GridItem(), GridItem(), GridItem()]
    var body: some View {
//        let image = UIImage(data: project.image!)
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 30) {
                        Image(uiImage: UIImage(data: project.image!)!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .frame(width: geo.size.width, height: geo.size.height * 0.3)
                            .padding(.top)
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("TITLE")
                                    .fontWeight(.light)
                                    .font(.system(.headline, design: .rounded))
                                Text(project.title ?? "")
                                    .font(.title2)
                            }
                            Spacer()
                        }
                        .padding()
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("DESCRIPTION")
                                    .fontWeight(.light)
                                    .font(.system(.headline, design: .rounded))
                                Text(project.summary ?? "")
                                    .font(.title2)
                            }
                            Spacer()
                        }
                        .padding()
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("TAGS")
                                        .fontWeight(.light)
                                        .font(.system(.headline, design: .rounded))
                                    Spacer()
                                }
                                LazyVGrid(columns: columns) {
                                    ForEach(viewModel.convertToTags(from: project.tags ?? []), id: \.self) { tag in
                                        TagView(name: tag)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Title")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.isEditing = true
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isEditing) {
            let editProject = ProjectModel(id: project.idCD!, image: UIImage(data: project.image!), title: project.title!, summary: project.summary!, tags: viewModel.convertToTags(from: project.tags!))
            AddProjectModal(newProject: editProject)
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: DataController().savedProjects[0])
            .preferredColorScheme(.dark)
            .environmentObject(DataController())
            .environmentObject(PortfolioViewModel())
    }
}
