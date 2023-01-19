//
//  AddFromGitModal.swift
//  ECS Sofa Project
//
//  Created by Serena on 19/01/23.
//

import SwiftUI

struct AddFromGitModal: View {
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    
    @State private var userName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("GitHub user") {
                        TextField("Enter GitHub user name", text: $userName)
                    }
                    
                    Button {
                        Task {
                            await viewModel.getRepositories(userName: userName)
                        }
                    } label: {
                        Text("Search")
                    }
                }
                .formStyle(.grouped)
                Section("User's repositories") {
                    ForEach(viewModel.repositories) { repo in
                        HStack {
                            Text(repo.name)
                            Spacer()
                            Button {
//                                viewModel.repoSelections.firstIndex(where: {$0.0 == repo.name }) = true
                            } label: {
//                                Image(systemName: viewModel.repositories[index].isSelected ? "checkmark.circle" : "circle")
//                                    .foregroundColor(Color(UIColor.label))
                            }
                            
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // function that calls another API to retrieve the selected repo
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
//            .onAppear() {
//                viewModel.setRepoSelections()
//            }
        }
    }
}

struct AddFromGitModal_Previews: PreviewProvider {
    static var previews: some View {
        AddFromGitModal()
    }
}
