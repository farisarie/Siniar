//
//  Profile.swift
//  Siniar
//
//  Created by yoga arie on 14/05/22.
//

import Foundation

class Profile{
    let userId: String
    var email: String?
    var phone: String?
    var gender: String?
    var dob: Date?
    
    init(userId: String){
        self.userId = userId
    }
}
