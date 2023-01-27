//
//  PortfolioViewModel.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import Foundation
import PhotosUI
import SwiftUI

enum Tags: String, CaseIterable {
    case SwiftUI,
         UIKit,
         CoreML,
         CoreData,
         PhotosUI
    
//    var name: String {
//        switch self {
//            case .SwiftUI: return "SwiftUI"
//            case .UIKit: return "UIKit"
//            case .CoreML: return "CoreML"
//            case .CoreData: return "CoreData"
//            case .PhotosUI: return "PhotosUI"
//        }
//    }
}


@MainActor
final class PortfolioViewModel: ObservableObject {
    // API VARIABLES
    @Published var repositories: [Repository] = []
    @Published var checks: [Bool] = []
    let decoder = JSONDecoder()
    
    @Published var isEditing = false
    @Published var isAddingProject = false
    @Published var isAddingFromGit = false
    @Published var tagList: [Tags] = [.SwiftUI, .UIKit, .CoreML, .CoreData, .PhotosUI]
    var tags: Tags = .SwiftUI
    
    func getRepositories(userName: String) async {
        do {
            let url = URL(string: "https://api.github.com/users/\(userName)/repos?type=all")
            let request = URLRequest(url: url!)
            let (data, _) = try await URLSession.shared.data(for: request)
            self.repositories = try decoder.decode([Repository].self, from: data)
            checks = Array(repeating: false, count: self.repositories.count)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func getTags(project: ProjectEntity){
        
    }
    
    func setTags(project: ProjectEntity){
        
    }
}
