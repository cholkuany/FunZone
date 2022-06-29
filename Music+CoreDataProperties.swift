//
//  Music+CoreDataProperties.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//
//

import Foundation
import CoreData


extension Music {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music> {
        return NSFetchRequest<Music>(entityName: "Music")
    }


}

extension Music : Identifiable {

}
