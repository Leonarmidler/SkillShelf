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
    //@State var tagSelections = [(Tags, Bool)]()
    @State var checks: [Bool]
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(Array(viewModel.tagList.enumerated()), id: \.offset) { index, tag in
                    HStack {
                        TagView(name: tag)
                        Spacer()
                        Button {
                            if (newTags.firstIndex(where: {$0.name == tag}) == nil) {
                                newTags.append(TagView(name: tag))
                            } else {
                                newTags.removeAll(where: {$0.name == tag})
                            }
                            checks[index].toggle()
                        } label: {
                            Image(systemName: checks[index] ? "checkmark.circle" : "circle")
                                .foregroundColor(Color(UIColor.label))
                        }
                        
                    }
                    .padding()
                }
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
                for tagView in tagViews {
                    let index = viewModel.tagList.firstIndex(of: tagView.name)
                    checks[index!] = true
                }
                newTags = tagViews
            }
        }
        
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView(isSelectingTag: .constant(true), tagViews: .constant([TagView(name: .SwiftUI)]), checks: Array(repeating: false, count: PortfolioViewModel().tagList.count))
            .environmentObject(PortfolioViewModel())
            .preferredColorScheme(.dark)
    }
}
