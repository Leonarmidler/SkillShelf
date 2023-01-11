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
    let width: CGFloat  = 170
    let radius: CGFloat = 16
    
    var body: some View {

        RoundedRectangle(cornerRadius: radius)
            .frame(width: width, height: height)
            .overlay{
                Image(project.imgName)
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .cornerRadius(radius)
                VStack{
                    Spacer()
                    HStack{
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

struct ProjectPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPreview(project: projectArray[0])
    }
}
