//
//  ProjectModel.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct ProjectModel: Identifiable {
    let id: UUID
    var image: UIImage?
    var title: String
    var summary: String
    var tags: [Tags]
}
