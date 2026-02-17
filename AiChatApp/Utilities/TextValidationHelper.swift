//
//  TextValidationHelper.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/02/2026.
//

import Foundation

struct TextValidationHelper {
    
    static func checkIfTextIsValid(text: String) throws {
        let minimumCharacterCount = 4
        
        guard text.count >= minimumCharacterCount else {
            throw TextValidationError.notEnoughCharacters(min: minimumCharacterCount)
        }
        
        let badWords: [String] = [
            "shit", "bitch"
        ]
        
        if badWords.contains(text.lowercased()) {
            throw TextValidationError.hasBadWords
        }
    }
    
    enum TextValidationError: LocalizedError {
        case notEnoughCharacters(min: Int)
        case hasBadWords
        
        var errorDescription: String? {
            switch self {
            case .notEnoughCharacters(min: let min):
                "Please enter at least \(min) characters."
            case .hasBadWords:
                "Bad word detected. Please rehrase your message."
            }
        }
    }
    
}
