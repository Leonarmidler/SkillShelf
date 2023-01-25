//
//  PickerView.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import SwiftUI
import PhotosUI

struct PickerView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Binding var newProject: ProjectModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    HStack {
                        Spacer()
                        Text("")
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            if (newProject.image != nil) {
                                Image(uiImage: newProject.image!)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.system(size: 100))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
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
            }
        }
    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
