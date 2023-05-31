//
//  CoreDataManager.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 25/05/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "IOSLearningCircleModels")
        persistentContainer.loadPersistentStores {_, error in
            if let error = error {
                fatalError("Loading of store failed : \(error)")
            }
        }
        return persistentContainer
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }}
