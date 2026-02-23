//
//  UserAuthInfo+Firebase.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 23/02/2026.
//

import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
