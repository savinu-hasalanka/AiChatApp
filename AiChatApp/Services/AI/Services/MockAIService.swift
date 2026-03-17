//
//  MockAIService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//
import SwiftUI

struct MockAIService: AIService {
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(nanoseconds: 3)
        return UIImage(systemName: "star.fill")!
    }  
}
