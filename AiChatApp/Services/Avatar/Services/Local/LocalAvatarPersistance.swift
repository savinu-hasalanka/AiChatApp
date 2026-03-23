//
//  LocalAvatarPersistence.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 22/03/2026.
//

@MainActor
protocol LocalAvatarPersistence {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
