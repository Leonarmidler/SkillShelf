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
    @Published var savedTags: [TagEntity] = []

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
        fetchTags()
    }

    func fetchData() {
        let request = NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
        do {
            savedProjects = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }

    // PROJECTS
    
    func addProject(project: ProjectModel) {
        let newProject = ProjectEntity(context: container.viewContext)
        newProject.idCD = project.id
        newProject.title = project.title
        newProject.summary = project.summary
        if project.image == nil {
            newProject.image = UIImage(named: "noImage")?.jpegData(compressionQuality: 50)
        } else {
            newProject.image = project.image?.jpegData(compressionQuality: 50)
        }

        saveData()
    }
    
    func editProject(idProject: UUID, editedProject: ProjectModel){
        if let index = savedProjects.firstIndex(where: {idProject == $0.idCD}) {
            
            savedProjects[index].title = editedProject.title
            savedProjects[index].summary = editedProject.summary
            savedProjects[index].image = editedProject.image?.jpegData(compressionQuality: 50)
            
            saveData()
        }
    }
    
    func deleteProject(project: ProjectEntity) {
        if let index = savedProjects.firstIndex(where: {project.idCD == $0.idCD}) {
            container.viewContext.delete(savedProjects[index])
            saveData()
        }
    }
    
    // TAGS
    
    func addTag(tag: String) {
        
        let newTag = TagEntity(context: container.viewContext)
        newTag.name = tag
        savedTags.append(newTag)
        saveData()
        
    }
    
    func fetchTags() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        do {
            savedTags = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
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
            fetchTags()
            fetchData()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
