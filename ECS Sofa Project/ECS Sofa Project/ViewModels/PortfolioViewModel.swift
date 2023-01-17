//
//  PortfolioViewModel.swift
//  ECS Sofa Project
//
//  Created by Serena on 12/01/23.
//

import Foundation
import PhotosUI
import SwiftUI

final class PortfolioViewModel: ObservableObject {
    @Published var isAddingProject = false
    @Published var projectArray = [
        ProjectModel(title: "Title", image: UIImage(named: "Project")),
        ProjectModel(title: "Title", image: UIImage(named: "Project")),
        ProjectModel(title: "Title", image: UIImage(named: "Project"))
    ]

    func addProject(newProject: ProjectModel) {
        projectArray.append(newProject)
    }
}
