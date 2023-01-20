//
//  AddFromGitModal.swift
//  ECS Sofa Project
//
//  Created by Serena on 19/01/23.
//

import SwiftUI

struct AddFromGitModal: View {
    
    @EnvironmentObject var viewModel: PortfolioViewModel

    @State var checks: [Bool] = Array(repeating: false, count: 10)
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
                                    checks = Array(repeating: false, count: 10)
                                    checks[index].toggle()
                                } label: {
                                    Image(systemName: checks[index] ? "checkmark.circle" : "circle")
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
        }
    }
}

//struct AddFromGitModal_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFromGitModal()
//    }
//}
