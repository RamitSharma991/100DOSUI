//
//  Movie+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Ramit Sharma on 22/08/24.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    public var wrappedTitle: String {
        title ?? "Unknown Value"
    }

}

extension Movie : Identifiable {
    

}
