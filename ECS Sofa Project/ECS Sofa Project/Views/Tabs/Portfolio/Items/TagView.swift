//
//  TagView.swift
//  ECS Sofa Project
//
//  Created by Alessandro Cei on 15/01/23.
//

import SwiftUI

struct TagView: View, Identifiable {
    
    var colors: [Tags : Color] = [.SwiftUI: .red, .UIKit: .orange, .CoreML: .blue, .CoreData: .gray, .PhotosUI: .purple]
    var name: Tags
    var id = UUID()
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .frame(width: 80, height: 25)
            .foregroundColor(colors[name])
            .overlay{
                Text(String(describing: name))
                    .foregroundColor(.white)
            }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(name: .SwiftUI)
    }
}
