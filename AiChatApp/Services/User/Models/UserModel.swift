//
//  UserModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    let userID: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userID: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userID = userID
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userID: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
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
                creationDate: Date().addingTimeInterval(days: -60),
                didCompleteOnboarding: true,
                profileColorHex: "#4ECDC4"
            ),
            UserModel(
                userID: "user-002",
                creationDate: Date().addingTimeInterval(days: -45),
                didCompleteOnboarding: true,
                profileColorHex: "#FF6B6B"
            ),
            UserModel(
                userID: "user-003",
                creationDate: Date().addingTimeInterval(days: -20),
                didCompleteOnboarding: false,
                profileColorHex: "#1A535C"
            ),
            UserModel(
                userID: "user-004",
                creationDate: Date().addingTimeInterval(days: -10),
                didCompleteOnboarding: true,
                profileColorHex: "#FFE66D"
            )
        ]
    }
}
