//
//  ChatMessageModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import Foundation
import IdentifiableByString

struct ChatMessageModel: Identifiable, Codable, StringIdentifiable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: AIChatModel?
    let seenByIds: [String]?
    let dateCreated: Date?
    
    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: AIChatModel? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case authorId = "author_id"
        case content
        case seenByIds = "seen_by_ids"
        case dateCreated = "date_created"
    }
    
    var dateCreatedCalculated: Date {
        dateCreated ?? .distantPast
    }
    
    func hasBeenSeenBy(userId: String) -> Bool{
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static func newUserMessage(chatId: String, userID: String, message: AIChatModel) -> Self {
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: userID,
            content: message,
            seenByIds: [userID],
            dateCreated: .now
        )
    }

    static func newAIMessage(chatId: String, avatarId: String, message: AIChatModel) -> Self {
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: avatarId,
            content: message,
            seenByIds: [],
            dateCreated: .now
        )
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ChatMessageModel(
                id: "msg-001",
                chatId: "chat-001",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, content: "Hey! How’s it going?"),
                seenByIds: ["user-002"],
                dateCreated: Date().addingTimeInterval(days: -2, hours: -3)
            ),
            ChatMessageModel(
                id: "msg-002",
                chatId: "chat-001",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, content: "All good 😄 What about you?"),
                seenByIds: ["user-001", "user-002"],
                dateCreated: Date().addingTimeInterval(days: -2, hours: -2, minutes: -30)
            ),
            ChatMessageModel(
                id: "msg-003",
                chatId: "chat-002",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, content: "Did you check the latest build?"),
                seenByIds: nil,
                dateCreated: Date().addingTimeInterval(days: -1, hours: -5)
            ),
            ChatMessageModel(
                id: "msg-004",
                chatId: "chat-003",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, content: "Let’s sync tomorrow."),
                seenByIds: ["user-004"],
                dateCreated: Date().addingTimeInterval(hours: -3)
            )
        ]
    }
}
