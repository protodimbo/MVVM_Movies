//
//  FilmResultDB+CoreDataProperties.swift
//  Movie App
//
//  Created by  protodimbo on 14.05.2021.
//
//

import CoreData
import Foundation

/// CoreDataModel
public extension FilmResultDB {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FilmResultDB> {
        NSFetchRequest<FilmResultDB>(entityName: "FilmResultDB")
    }

    @NSManaged var backdropPath: String
    @NSManaged var id: Int64
    @NSManaged var overview: String
    @NSManaged var title: String
    @NSManaged var voteAverage: Double
    @NSManaged var originalTitle: String
    @NSManaged var releaseDate: String
}

extension FilmResultDB: Identifiable {}
