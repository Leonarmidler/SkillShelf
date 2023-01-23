//
//  PortfolioViewModel.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import Foundation
import PhotosUI
import SwiftUI

enum Tags {
    case SwiftUI
    case UIKit
    case CoreML
    case CoreData
    case PhotosUI
}


@MainActor
final class PortfolioViewModel: ObservableObject {
    // API VARIABLES
    @Published var repositories: [Repository] = []
    @Published var checks: [Bool] = []
    let decoder = JSONDecoder()
    
    @Published var isAddingProject = false
    @Published var isAddingFromGit = false
    @Published var tagList: [Tags] = [.SwiftUI, .UIKit, .CoreML, .CoreData, .PhotosUI]

    @Published var projectArray = [
        ProjectModel(image: UIImage(named: "Project") ?? nil, title: "Title", description: "Lorem ipsum dolor sit amet", tags: []),
        ProjectModel(image: UIImage(named: "Project") ?? nil, title: "Title", description: "Lorem ipsum dolor sit amet", tags: []),
        ProjectModel(image: UIImage(named: "Project") ?? nil, title: "Title", description: "Lorem ipsum dolor sit amet", tags: [])
    ]
    
    func addProject(newProject: ProjectModel) {
        projectArray.append(newProject)
    }
    
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
}
