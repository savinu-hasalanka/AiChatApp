//
//  ChatModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let createdDate: Date
    let modifiedDate: Date
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ChatModel(
                id: "mock_chat_001",
                userId: "user-001",
                avatarId: "avatar-001",
                createdDate: Date().addingTimeInterval(days: -5),
                modifiedDate: Date().addingTimeInterval(days: -2)
            ),
            ChatModel(
                id: "mock_chat_002",
                userId: "user-002",
                avatarId: "avatar-002",
                createdDate: Date().addingTimeInterval(days: -10),
                modifiedDate: Date().addingTimeInterval(days: -7)
            ),
            ChatModel(
                id: "mock_chat_003",
                userId: "user-003",
                avatarId: "avatar-003",
                createdDate: Date().addingTimeInterval(days: -1),
                modifiedDate: Date().addingTimeInterval(hours: -3)
            ),
            ChatModel(
                id: "mock_chat_004",
                userId: "user-004",
                avatarId: "avatar-004",
                createdDate: Date().addingTimeInterval(days: -30),
                modifiedDate: Date().addingTimeInterval(days: -25)
            )
        ]
    }
}
