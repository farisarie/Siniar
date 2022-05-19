//
//  ProfileData+CoreDataProperties.swift
//  Siniar
//
//  Created by yoga arie on 14/05/22.
//
//

import Foundation
import CoreData


extension ProfileData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileData> {
        return NSFetchRequest<ProfileData>(entityName: "ProfileData")
    }

    @NSManaged public var userId: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var gender: String?
    @NSManaged public var dob: Date?

}
