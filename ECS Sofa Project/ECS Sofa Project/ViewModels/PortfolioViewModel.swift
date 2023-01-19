//
//  PortfolioViewModel.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
final class PortfolioViewModel: ObservableObject {
    // API VARIABLES
    @Published var repositories: [Repository] = []
    let decoder = JSONDecoder()
    
    @Published var isAddingProject = false
    @Published var projectArray = [
        ProjectModel(title: "Title", image: UIImage(named: "Project")),
        ProjectModel(title: "Title", image: UIImage(named: "Project")),
        ProjectModel(title: "Title", image: UIImage(named: "Project"))
    ]
    
    func addProject(newProject: ProjectModel) {
        projectArray.append(newProject)
    }
    
    func getRepositories() async {
        do {
            let url = URL(string: "https://api.github.com/users/Alessandro-Cei/repos?type=all")
            let request = URLRequest(url: url!)
            let (data, _) = try await URLSession.shared.data(for: request)
            
            self.repositories = try decoder.decode([Repository].self, from: data)
            
            
            for repo in repositories {
                print(repo.name)
            }            
        } catch {
            print("SONO NEL CATCH")
            print(error.localizedDescription)
        }
    }
}
