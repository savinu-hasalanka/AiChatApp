//
//  AIService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//
import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
}
