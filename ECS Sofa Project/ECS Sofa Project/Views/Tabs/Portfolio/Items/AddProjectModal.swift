//
//  AddProjectModal.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import PhotosUI
import SwiftUI

struct AddProjectModal: View {
//    @State var idProject: UUID
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject var dataController: DataController
    @State var newProject: ProjectModel

    @State var tagViews: [TagView] = []
    @State var isSelectingTag = false
    
    let columns: [GridItem] = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    Form {
                        Section("") {
                            PickerView(newProject: $newProject)
                                .frame(width: geo.size.width, height: geo.size.height * 0.2)
                        }
                        .listRowBackground(Color.clear)
                        Section("Title") {
                            TextField("Enter project title", text: $newProject.title)
                        }
                        Section("Description") {
                            TextField("Enter project description", text: $newProject.summary)
                        }
                        Section("Tags") {
                            VStack {
                                Button {
                                    isSelectingTag.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(Color(UIColor.systemGreen))
                                        Text("Add a tag")
                                            .foregroundColor(Color(UIColor.label))
                                    }
                                }
                                .offset(x: 0, y: 3)
                                LazyVGrid(columns: columns) {
                                    ForEach(tagViews) { tagView in
                                        tagView
                                    }
                                }
                            }
                            .sheet(isPresented: $isSelectingTag) {
                                TagSelectionView(checks: Array(repeating: false, count: viewModel.tagList.count), isSelectingTag: $isSelectingTag, tagViews: $tagViews)
                            }
                        }
                        Spacer()
                            .listRowBackground(Color.clear)
                        if viewModel.isAddingProject {
                            Section("") {
                                HStack {
                                    Spacer()
                                    Button {
                                        viewModel.isAddingFromGit = true
                                    } label: {
                                        Text("Retrieve from GitHub")
                                            .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.07)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(16)
                                    }
                                    Spacer()
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    .formStyle(.grouped)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !viewModel.isEditing {
                            Button {
                                var tempTags: [Tags] = []
                                for tagView in tagViews {
                                    tempTags.append(tagView.name)
                                }
                                newProject.tags = tempTags
                                viewModel.isAddingProject = false
                                dataController.addProject(project: newProject)
                            } label: {
                                Text("Add")
                            }
                        } else {
                            Button {
                                viewModel.isEditing = false
                                var tempTags: [Tags] = []
                                for tagView in tagViews {
                                    tempTags.append(tagView.name)
                                }
                                newProject.tags = tempTags
                                dataController.editProject(editedProject: newProject)
                            } label: {
                                Text("Done")
                            }
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            viewModel.isAddingProject = false
                            viewModel.isEditing = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .navigationTitle(viewModel.isEditing ? "Edit Project" : "Add Project")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                if viewModel.isEditing {
                    for tag in newProject.tags {
                        tagViews.append(TagView(name: tag))
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddingFromGit) {
            AddFromGitModal(newProject: $newProject)
        }
    }
}

struct AddProjectModal_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectModal(newProject: ProjectModel(id: UUID(), title: "", summary: "", tags: []))
            .environmentObject(DataController())
            .environmentObject(PortfolioViewModel())
            .preferredColorScheme(.dark)
    }
}
