//
//  CoreDataStack.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 28.07.2023.
//

import CoreData

final class CoreDataStack {
    
    private init() {}
    static let shared = CoreDataStack()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppKey.coreDataName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteDBItem(object: OverviewEntity) {
        storeContainer.viewContext.delete(object)
    }
    
    private func deleteItem(at entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let coordinator = managedContext.persistentStoreCoordinator
        do {
            try coordinator!.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func clearAllBD() {
        EntityNameType.allCases.forEach({ nameType in
            deleteItem(at: nameType.rawValue)
        })
    }
}
