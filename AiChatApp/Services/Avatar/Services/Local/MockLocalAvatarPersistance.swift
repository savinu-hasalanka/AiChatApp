//
//  MockLocalAvatarPersistance.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 22/03/2026.
//


@MainActor
struct MockLocalAvatarPersistance: LocalAvatarPersistance {
    func addRecentAvatar(avatar: AvatarModel) throws {
        
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}