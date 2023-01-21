//
//  ProjectView.swift
//  ECS Sofa Project
//
//  Created by Alessandro Cei on 19/01/23.
//

import SwiftUI

struct ProjectView: View {
    var project: ProjectModel
    let columns: [GridItem] = [GridItem(), GridItem(), GridItem()]
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack (spacing: 30){
                        Image(uiImage: (project.image ?? UIImage(named: "Project"))!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .frame(width: geo.size.width, height: geo.size.height * 0.3)
                            .padding(.top)
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("TITLE")
                                    .fontWeight(.light)
                                    .font(.system(.headline, design: .rounded))
                                Text(project.title)
                                    .font(.title2)
                            }
                            Spacer()
                        }
                        .padding()
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("DESCRIPTION")
                                    .fontWeight(.light)
                                    .font(.system(.headline, design: .rounded))
                                Text(project.description)
                                    .font(.title2)
                            }
                            Spacer()
                        }
                        .padding()
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack{
                                    Text("TAGS")
                                        .fontWeight(.light)
                                        .font(.system(.headline, design: .rounded))
                                    Spacer()
                                }
                                LazyVGrid(columns: columns){
                                    ForEach(project.tags, id: \.self){ tag in
                                        TagView(name: tag)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Title")
                .toolbar() {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Edit")
                        }
                    }
                }
                
            }
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: ProjectModel(title: "Ciao", description: "Lorem ipsum", tags: [.SwiftUI, .UIKit, .CoreData, .PhotosUI]))
            .preferredColorScheme(.dark)
    }
}
