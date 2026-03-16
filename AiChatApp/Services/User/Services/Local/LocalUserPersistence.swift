//
//  LocalUserPersistence.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
