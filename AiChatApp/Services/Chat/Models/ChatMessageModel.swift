//
//  ChatMessageModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import Foundation

struct ChatMessageModel {
    let id: String
    let chatId: String
    let authorID: String?
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date?
    
    init(
        id: String,
        chatId: String,
        authorID: String? = nil,
        content: String? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorID = authorID
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    func hasBeenSeenBy(userId: String) -> Bool{
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static var mock: ChatMessageModel {
        mocks[0]
    }
    
    static var mocks: [ChatMessageModel] {
        [
            ChatMessageModel(
                id: "msg-001",
                chatId: "chat-001",
                authorID: "user-001",
                content: "Hey! How’s it going?",
                seenByIds: ["user-002"],
                dateCreated: Date().addingTimeInterval(days: -2, hours: -3)
            ),
            ChatMessageModel(
                id: "msg-002",
                chatId: "chat-001",
                authorID: "user-002",
                content: "All good 😄 What about you?",
                seenByIds: ["user-001", "user-002"],
                dateCreated: Date().addingTimeInterval(days: -2, hours: -2, minutes: -30)
            ),
            ChatMessageModel(
                id: "msg-003",
                chatId: "chat-002",
                authorID: "user-003",
                content: "Did you check the latest build?",
                seenByIds: nil,
                dateCreated: Date().addingTimeInterval(days: -1, hours: -5)
            ),
            ChatMessageModel(
                id: "msg-004",
                chatId: "chat-003",
                authorID: "user-001",
                content: "Let’s sync tomorrow.",
                seenByIds: ["user-004"],
                dateCreated: Date().addingTimeInterval(hours: -3)
            )
        ]
    }
}
