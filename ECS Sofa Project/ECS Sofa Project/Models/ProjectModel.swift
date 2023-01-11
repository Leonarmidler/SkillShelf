//
//  ProjectModel.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectModel: Identifiable {
    
    let id = UUID()

    let title: String
    let imgName: String
    
}


let projectArray = [
    ProjectModel(title: "Title", imgName: "Project"),
    ProjectModel(title: "Title", imgName: "Project"),
    ProjectModel(title: "Title", imgName: "Project")
]
