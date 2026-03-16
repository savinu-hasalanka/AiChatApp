//
//  RemoteUserService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}
