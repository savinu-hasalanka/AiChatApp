//
//  FirebaseChatService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 30/03/2026.
//

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseChatService: ChatService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("chats")
    }
    
    private func messageCollection(chatId: String) -> CollectionReference {
        collection.document(chatId).collection("messages")
    }
    
    private var chatReportsCollection: CollectionReference {
        Firestore.firestore().collection("chat_reports")
    }
    
    func createNewChat(chat: ChatModel) async throws {
        try collection.document(chat.id).setData(from: chat, merge: true)
    }
    
    func getChat(userId: String, avatarId: String) async throws -> ChatModel? {
//        let result: [ChatModel] = try await collection
//            .whereField(ChatModel.CodingKeys.userId.rawValue, isEqualTo: userId)
//            .whereField(ChatModel.CodingKeys.avatarId.rawValue, isEqualTo: avatarId)
//            .getAllDocuments()
//        
//        return result.first
        
        try await collection.getDocument(id: ChatModel.chatId(userId: userId, avatarId: avatarId))
        
    }
    
    func getAllChats(userId: String) async throws -> [ChatModel] {
        try await collection
            .whereField(ChatModel.CodingKeys.userId.rawValue, isEqualTo: userId)
            .getAllDocuments()
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        // Add message to the messages sub collection
        try messageCollection(chatId: chatId).document(message.id).setData(from: message, merge: true)
        
        // Update chaat dateModified
        try await collection.document(chatId).updateData([
            ChatModel.CodingKeys.modifiedDate: Date.now
        ])
    }
    
    func getLastChatMessage(chatId: String) async throws -> ChatMessageModel? {
        let messages: [ChatMessageModel] = try await messageCollection(chatId: chatId)
            .order(by: ChatMessageModel.CodingKeys.dateCreated.rawValue, descending: true)
            .limit(to: 1)
            .getAllDocuments()
        
        return messages.first
    }
    
    func streamChatMessage(chatId: String) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        messageCollection(chatId: chatId).streamAllDocuments()
    }
    
    func deleteChat(chatId: String) async throws {
        async let deleteChat: () = collection.deleteDocument(id: chatId)
        async let deleteMessages: () = messageCollection(chatId: chatId).deleteAllDocuments()
        
        let (_, _) = await (try deleteChat, try deleteMessages)
    }
    
    func deleteAllChatsForUser(userId: String) async throws {
        let chats = try await getAllChats(userId: userId)
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            for chat in chats {
                group.addTask {
                    try await deleteChat(chatId: chat.id)
                }
            }
            
            try await group.waitForAll()
        }
    }
    
    func reportChat(report: ChatReportModel) async throws {
        try await chatReportsCollection.setDocument(document: report)
    }
    
}
