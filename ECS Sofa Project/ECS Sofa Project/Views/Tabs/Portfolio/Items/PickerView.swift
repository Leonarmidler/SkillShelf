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
        VStack {
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
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
