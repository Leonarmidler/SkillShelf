//
//  ProjectPreview.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectPreview: View {
    let project: ProjectModel
    let height: CGFloat = 120
    let radius: CGFloat = 16
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
            .overlay {
                Image(uiImage: project.image!)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
                    .cornerRadius(radius)
                VStack {
                    Spacer()
                    HStack {
                        Text(project.title)
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(8)
            }
    }
}

// struct ProjectPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectPreview()
//    }
// }
