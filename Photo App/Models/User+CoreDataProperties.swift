//
//  User+CoreDataProperties.swift
//  Photo App
//
//  Created by Aleksandr on 08.04.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: Data?
    @NSManaged public var isLoad: Bool
    @NSManaged public var password: String?
    @NSManaged public var user: String?

}

extension User : Identifiable {

}
