//
//  InProgress.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct InProgressView: View {
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject var dataController: DataController
    
    @State var tags: [String] = []
    
    var body: some View {
        Text("Ciao")
            .onAppear {
//                tags.append("SwiftUI")
//                tags.append("UIKit")
//                tags.append("CoreML")
//                tags.append("CoreData")
//                tags.append("PhotosUI")
//
//                for tag in tags {
//                    dataController.addTag(tag: tag)
//                }
                for x in dataController.savedTags {
                    print(x.name ?? "eheh")
                }
            }
    }
}

// struct InProgress_Previews: PreviewProvider {
//    static var previews: some View {
//        InProgressView()
//    }
// }
