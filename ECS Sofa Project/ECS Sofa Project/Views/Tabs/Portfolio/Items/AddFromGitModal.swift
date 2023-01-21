//
//  AddFromGitModal.swift
//  ECS Sofa Project
//
//  Created by Serena on 19/01/23.
//

import SwiftUI

struct AddFromGitModal: View {
    
    // Index of the repo
    @State var repoIndex = 0
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    @Binding var newProject: ProjectModel
    
    @State private var userName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("GitHub user") {
                        TextField("Enter GitHub user name", text: $userName)
                    }
                    
                    HStack{
                        Spacer()
                        Button {
                            Task {
                                await viewModel.getRepositories(userName: userName)
                            }
                        } label: {
                            Text("Search")
                        }
                        Spacer()
                    }
                    
                    Section("User's repositories") {
                        ForEach(Array(viewModel.repositories.enumerated()), id: \.offset) { index, repo in
                            HStack {
                                Text(repo.name)
                                Spacer()
                                Button {
                                    viewModel.checks = Array(repeating: false, count: viewModel.repositories.count)
                                    viewModel.checks[index].toggle()
                                    self.repoIndex = index
                                } label: {
                                    Image(systemName: viewModel.checks[index] ? "checkmark.circle" : "circle")
                                        .foregroundColor(Color(UIColor.label))
                                }
                                
                            }
                        }
                    }
                }
                .formStyle(.grouped)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newProject.title = viewModel.repositories[repoIndex].name
                        newProject.description = viewModel.repositories[repoIndex].description ?? ""
                        viewModel.isAddingFromGit = false
                    } label: {
                        Text("Done")
                    }
                    
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        viewModel.isAddingFromGit = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

//struct AddFromGitModal_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFromGitModal()
//    }
//}
