//
//  SignUp+CoreDataProperties.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//
//

import Foundation
import CoreData


extension SignUp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SignUp> {
        return NSFetchRequest<SignUp>(entityName: "SignUp")
    }

    @NSManaged public var usernameAttribute: String?
    @NSManaged public var passwordAttribute: String?

}

extension SignUp : Identifiable {

}
