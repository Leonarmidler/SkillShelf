//
//  ProjectPreview.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectPreview: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(maxWidth: 170, maxHeight: 120)
            Image("Project")
        }
    }
}

struct ProjectPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPreview()
    }
}
