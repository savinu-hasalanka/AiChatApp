//
//  MockUserPersistence.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

struct MockUserPersistence: LocalUserPersistence {
    
    let currentUser: UserModel?
    
    init(currentUser: UserModel? = nil) {
        self.currentUser = currentUser
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}
