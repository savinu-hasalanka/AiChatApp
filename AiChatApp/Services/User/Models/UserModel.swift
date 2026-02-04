//
//  UserModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import Foundation
import SwiftUI

struct UserModel {
    
    let userID: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userID: String,
        dateCreated: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userID = userID
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else { return Color.accentColor }
        
        return Color(hex: profileColorHex)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            UserModel(
                userID: "user-001",
                dateCreated: Date().addingTimeInterval(days: -60),
                didCompleteOnboarding: true,
                profileColorHex: "#4ECDC4"
            ),
            UserModel(
                userID: "user-002",
                dateCreated: Date().addingTimeInterval(days: -45),
                didCompleteOnboarding: true,
                profileColorHex: "#FF6B6B"
            ),
            UserModel(
                userID: "user-003",
                dateCreated: Date().addingTimeInterval(days: -20),
                didCompleteOnboarding: false,
                profileColorHex: "#1A535C"
            ),
            UserModel(
                userID: "user-004",
                dateCreated: Date().addingTimeInterval(days: -10),
                didCompleteOnboarding: true,
                profileColorHex: "#FFE66D"
            )
        ]
    }
}
