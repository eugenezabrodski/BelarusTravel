//
//  UsersModel.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 31.01.23.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }
}
