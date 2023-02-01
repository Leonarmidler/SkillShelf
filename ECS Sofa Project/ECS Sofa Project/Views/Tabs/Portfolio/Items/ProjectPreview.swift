//
//  ProjectPreview.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectPreview: View {
    let project: ProjectEntity
    let height: CGFloat
    let radius: CGFloat
    var body: some View {
        Image(uiImage: UIImage(data: project.image! )!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: height)
            .cornerRadius(radius, corners: [.allCorners])
            .shadow(color: .black.opacity(0.15), radius: 24, x: 0, y: 8)
            .overlay {
                ZStack {
                    VStack {
                        Spacer()
                        Rectangle()
                            .cornerRadius(radius, corners: [.bottomRight, .bottomLeft])
                            .frame(minHeight: height / 5, maxHeight: height / 5)
                            .foregroundColor(.white)
                            .overlay {
                                HStack {
                                    Text(project.title ?? "")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.leading, 5)
                            }
                    }
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.black, lineWidth: 2)
                }
            }
    }
}

// struct ProjectPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectPreview(project: ProjectModel(id: UUID(), image: UIImage(named: "Project"), title: "Title", summary: "Description", tags: [.SwiftUI, .UIKit]), height: 120, radius: 12)
//    }
// }

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
