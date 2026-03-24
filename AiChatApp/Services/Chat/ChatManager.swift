//
//  ChatManager.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 24/03/2026.
//

protocol ChatService: Sendable {
    func createNewChat(chat: ChatModel) async throws
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws
}

struct MockChatService: ChatService {
    
    func createNewChat(chat: ChatModel) async throws {
        
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        
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
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        // Add message to the messages sub collection
        try messageCollection(chatId: chatId).document(message.id).setData(from: message, merge: true)
        
        // Update chaat dateModified
        try await collection.document(chatId).updateData([
            ChatModel.CodingKeys.modifiedDate: Date.now
        ])
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
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        try await service.addChatMessage(chatId: chatId, message: message)
    }
    
}
