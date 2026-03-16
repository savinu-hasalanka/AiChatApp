//
//  FileManagerUserPersistence.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

import SwiftUI

struct FileManagerUserPersistence: LocalUserPersistence {
    private let userDocumentKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
