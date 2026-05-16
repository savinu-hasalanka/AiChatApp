//
//  CategoryRowTestOption.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/05/2026.
//
import SwiftUI

enum CategoryRowTestOption: String, Codable, CaseIterable {
    case original, top, hidden
    
    static var `default`: Self {
        .original
    }
}
