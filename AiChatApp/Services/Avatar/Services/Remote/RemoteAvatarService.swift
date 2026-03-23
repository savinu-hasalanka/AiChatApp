//
//  AvatarService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 18/03/2026.
//

import SwiftUI

protocol RemoteAvatarService: Sendable {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
    func getAvatar(id: String) async throws -> AvatarModel
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel]
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel]
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel]
    func removeAuthorIdFromAvatar(avatarId: String) async throws
    func removeAuthorIdFromAllUserAvatars(userId: String) async throws
    func incrementAvatarClickCount(avatarId: String) async throws
}
