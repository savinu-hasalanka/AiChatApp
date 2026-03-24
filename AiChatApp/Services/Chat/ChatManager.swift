//
//  ChatManager.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 24/03/2026.
//

protocol ChatService: Sendable {
    func createNewChat(chat: ChatModel) async throws
    func getChat(userId: String, avatarId: String) async throws -> ChatModel?
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws
    func streamChatMessage(chatId: String) -> AsyncThrowingStream<[ChatMessageModel], Error>
}

struct MockChatService: ChatService {
    
    func createNewChat(chat: ChatModel) async throws {
        
    }
    
    func getChat(userId: String, avatarId: String) async throws -> ChatModel?  {
        ChatModel.mock
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        
    }
    
    func streamChatMessage(chatId: String) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        AsyncThrowingStream { continuation in
            
        }
    }
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseChatService: ChatService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("chats")
    }
    
    private func messageCollection(chatId: String) -> CollectionReference {
        collection.document(chatId).collection("messages")
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
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        // Add message to the messages sub collection
        try messageCollection(chatId: chatId).document(message.id).setData(from: message, merge: true)
        
        // Update chaat dateModified
        try await collection.document(chatId).updateData([
            ChatModel.CodingKeys.modifiedDate: Date.now
        ])
    }
    
    func streamChatMessage(chatId: String) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        messageCollection(chatId: chatId).streamAllDocuments()
    }
    
}

@MainActor
@Observable
class ChatManager {
    
    let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func createNewChat(chat: ChatModel) async throws {
        try await service.createNewChat(chat: chat)
    }
    
    func getChat(userId: String, avatarId: String) async throws -> ChatModel? {
        try await service.getChat(userId: userId, avatarId: avatarId)
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        try await service.addChatMessage(chatId: chatId, message: message)
    }
    
    func streamChatMessage(chatId: String) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        service.streamChatMessage(chatId: chatId)
    }
    
}
