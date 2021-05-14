//
//  CoreDataService.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import CoreData
import Foundation

final class CoreDataService {
    var didUpdateDataBase: ((CoreDataService) -> ())?

    private var storeURL: URL = {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        else { fatalError("document path not found") }
        return documentsURL.appendingPathComponent("Film.sqlite")
    }()

    private let dataModelName = "Film"
    private let dataModelExtension = "momd"

    // MARK: - Init stack

    private(set) lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: dataModelName, withExtension: dataModelExtension)
        else { fatalError("model not found") }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError("managedObjectModel cannot be created") }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try coordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: storeURL,
                options: nil
            )
        } catch {
            fatalError(error.localizedDescription)
        }
        return coordinator
    }()

    private lazy var writterContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        context.mergePolicy = NSOverwriteMergePolicy
        return context
    }()

    private(set) lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = writterContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return context
    }()

    private func saveContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    // MARK: - Save context

    func performSave(_ block: (NSManagedObjectContext) -> ()) {
        let context = saveContext()
        context.performAndWait {
            block(context)
            if context.hasChanges {
                do {
                    try performSave(in: context)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }

    func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }

    func fetch(for category: MovieCategory, completion: ([FilmResult]?) -> ()) {
        let request: NSFetchRequest<FilmResultDB> = FilmResultDB.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", category.correctName)
        let context = saveContext()
        let filmResult = try? context.fetch(request)
        completion(filmResult?.compactMap { FilmResult(filmResultDB: $0) })
    }
}
