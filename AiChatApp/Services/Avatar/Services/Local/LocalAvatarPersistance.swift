//
//  LocalAvatarPersistance.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 22/03/2026.
//

@MainActor
protocol LocalAvatarPersistance {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
