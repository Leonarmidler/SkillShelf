//
//  TagSelectionView.swift
//  ECS Sofa Project
//
//  Created by Alessandro Cei on 15/01/23.
//

import SwiftUI

struct TagSelectionView: View {
    
    @Binding var isSelectingTag: Bool
    @Binding var tagViews: [TagView]
    
    //@State var tagList: [Tags] = [.SwiftUI, .UIKit, .CoreML, .CoreData, .PhotosUI]
    @EnvironmentObject var viewModel: PortfolioViewModel
    @State var newTags: [TagView] = []
    @State var tagSelections = [(Tags, Bool)]()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(tagSelections, id:\.0) { item in
                    HStack{
                        TagView(name: item.0)
                        Spacer()
                        if item.1 == true {
                            Button(action: {
                                for (index, element) in newTags.enumerated() {
                                    if element.name == item.0 {
                                        newTags.remove(at: index)
                                        tagSelections[tagSelections.firstIndex(where: {$0.0 == item.0})!].1 = false
                                    }
                                }
                            }, label: {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(Color(UIColor.label))
                            })
                        } else {
                            Button(action: {
                                newTags.append(TagView(name: item.0))
                                tagSelections[tagSelections.firstIndex(where: {$0.0 == item.0})!].1 = true
                            }, label: {
                                Image(systemName: "circle")
                                    .foregroundColor(Color(UIColor.label))
                            })
                        }
                    }
                    .padding(.vertical)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSelectingTag = false
                        tagViews = newTags
                    } label: {
                        Text("Add")
                    }
                    
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isSelectingTag = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .navigationTitle("Select tags")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                newTags = tagViews
                for tag in viewModel.tagList {
                    tagSelections.append((tag, false))
                }
                for selectedTag in tagViews {
                    for tag in viewModel.tagList {
                        if tag == selectedTag.name {
                            if let index = tagSelections.firstIndex(where: {$0.0 == selectedTag.name}) {
                                tagSelections[index].1 = true
                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView(isSelectingTag: .constant(true), tagViews: .constant([TagView(name: .SwiftUI)]))
            .preferredColorScheme(.dark)
    }
}
