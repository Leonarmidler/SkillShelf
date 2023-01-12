//
//  ProjectModel.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectModel: Identifiable {
    
    let id = UUID()

    var title: String
    var image: UIImage?
    
    func addProject() {
        projectArray.append(self)
    }
    
}


var projectArray = [
    ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil),
    ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil),
    ProjectModel(title: "Title", image: UIImage(named: "Project") ?? nil)
]
