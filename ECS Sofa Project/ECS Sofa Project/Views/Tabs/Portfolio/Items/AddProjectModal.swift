//
//  AddProjectModal.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI
import PhotosUI

struct AddProjectModal: View {
    
    @State private var newProject = ProjectModel(title: "", image: nil)
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Binding var isAddingProject: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Enter project title", text: $newProject.title)
                    }
                    
                    Section("Select image for your project") {
                        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                            HStack {
                                Spacer()
                                Text("")
                                Image(systemName: "photo.on.rectangle")
                                    .font(.largeTitle)
                                Spacer()
                            }
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                // Retrieve selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    let uiImage = UIImage(data: selectedImageData!)
                                    newProject.image = uiImage
                                }
                            }
                        }
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                        }
                    }
                    
                }
                .formStyle(.grouped)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newProject.addProject()
                        
                        print(projectArray)
                        
                        isAddingProject = false
                    } label: {
                        Text("Add")
                    }
                    
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isAddingProject = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct AddProjectModal_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectModal(isAddingProject: .constant(false))
    }
}
