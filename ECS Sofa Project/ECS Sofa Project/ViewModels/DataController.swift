//
//  DataController.swift
//  ECS Sofa Project
//
//  Created by Serena on 16/01/23.
//

import CoreData
import Foundation
import UIKit

final class DataController: ObservableObject {
    @Published var savedProjects: [ProjectEntity] = []

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "SavedProjects")
        container.loadPersistentStores { description, error in
            if let error {
                print(error)
            } else {
                print(description)
            }
        }
        fetchData()
    }

    func fetchData() {
        let request = NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
        do {
            savedProjects = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }

    // test function
    func addProject(project: ProjectModel) {
        let newProject = ProjectEntity(context: container.viewContext)
        newProject.id = project.id
        newProject.title = project.title
        newProject.summary = project.summary
        if project.image == nil {
            newProject.image = UIImage(named: "noImage")?.jpegData(compressionQuality: 50)
        } else {
            newProject.image = project.image?.jpegData(compressionQuality: 50)
        }
        saveData()
    }
    
    func deleteProject(project: ProjectEntity) {
        container.viewContext.delete(project)
        
        saveData()
    }

    func deleteAll() {
        for index in savedProjects.indices {
            let entity = savedProjects[index]
            container.viewContext.delete(entity)
        }

        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
