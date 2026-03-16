//
//  UserServices.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

protocol UserServices {
    var remote: RemoteUserService { get }
    var local: LocalUserPersistence { get }
}

struct MockUserServices: UserServices {
    let remote: RemoteUserService
    let local: LocalUserPersistence
    
    init(user: UserModel? = nil) {
        self.remote = MockUserService(user: user)
        self.local = MockUserPersistence(currentUser: user)
    }
}

struct ProductionUserServices: UserServices {
    let remote: RemoteUserService = FirebaseUserService()
    let local: LocalUserPersistence = FileManagerUserPersistence()
}
