//
//  ProjectPreview.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectPreview: View {
    let project: ProjectModel
    let height: CGFloat
    let radius: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
            .overlay {
                Image(uiImage: (project.image ?? UIImage(named: "noImage"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
                    .cornerRadius(radius)
                VStack {
                    Spacer()
                    HStack {
                        Text(project.title)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                }
                .padding(8)
            }
    }
}

 struct ProjectPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPreview(project: ProjectModel(image: UIImage(named: "Project"), title: "Title", description: "Description", tags: [.SwiftUI, .UIKit]), height: 120, radius: 12)
    }
 }
