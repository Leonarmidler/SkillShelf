//
//  PortfolioViewModel.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import Foundation
import SwiftUI
import PhotosUI

final class PortfolioViewModel: ObservableObject {
    @Published var isAddingProject = false
    @Published var projectArray = [
        ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil),
        ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil),
        ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil)
    ]

    func addProject(newProject: ProjectModel) {
        projectArray.append(newProject)
    }
    
}
