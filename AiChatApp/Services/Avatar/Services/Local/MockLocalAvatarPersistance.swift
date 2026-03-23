//
//  MockLocalAvatarPersistence.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 22/03/2026.
//


@MainActor
struct MockLocalAvatarPersistence: LocalAvatarPersistence {
    func addRecentAvatar(avatar: AvatarModel) throws {
        
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
