//
//  Notes+CoreDataProperties.swift
//  FunZone
//
//  Created by admin on 6/3/22.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var noteTitle: String?
    @NSManaged public var noteBody: String?

}

extension Notes : Identifiable {

}
