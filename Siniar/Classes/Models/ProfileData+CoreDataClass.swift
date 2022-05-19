//
//  ProfileData+CoreDataClass.swift
//  Siniar
//
//  Created by yoga arie on 14/05/22.
//
//

import Foundation
import CoreData

@objc(ProfileData)
public class ProfileData: NSManagedObject {

    
    class func save(_ profile: Profile, in context: NSManagedObjectContext){
        let request: NSFetchRequest<ProfileData> = ProfileData.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", profile.userId)
        
        let profileData: ProfileData
        if let data = try? context.fetch(request).first{
            profileData = data
        }
        else {
            let entity = NSEntityDescription.entity(forEntityName: "ProfileData", in: context)!
            profileData = NSManagedObject(entity: entity, insertInto: context) as! ProfileData
        }
        profileData.userId = profile.userId
        profileData.email = profile.email
        profileData.phone = profile.phone
        profileData.gender = profile.gender
        profileData.dob = profile.dob
        
        
    }
    
    class func fetch(userId: String, in context: NSManagedObjectContext) -> Profile? {
        let request: NSFetchRequest<ProfileData> = ProfileData.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", userId)
       
        if let data = try? context.fetch(request).first{
            let profileData: ProfileData = data
            let profile = Profile(userId: userId)
            profile.email = profileData.email //nampilin data dari core data ke edit profile view controller
            profile.phone = profileData.phone
            profile.gender = profileData.gender
            profile.dob = profileData.dob
            
            return profile
        } else {
            return nil
        }
        
}

}
