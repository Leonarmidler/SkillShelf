//
//  AddProjectModal.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import PhotosUI
import SwiftUI

struct AddProjectModal: View {
    @State private var newProject = ProjectModel(title: "", image: nil)
    @ObservedObject var viewModel: PortfolioViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Enter project title", text: $newProject.title)
                    }
                    Section("Select image for your project") {
                        PickerView(newProject: $newProject)
                    }
                }
                .formStyle(.grouped)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addProject(newProject: newProject)
                        viewModel.isAddingProject = false
                    } label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        viewModel.isAddingProject = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

// struct AddProjectModal_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProjectModal(isAddingProject: .constant(false))
//    }
// }
