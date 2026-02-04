//
//  AvatarModel.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 01/02/2026.
//

import Foundation

struct AvatarModel: Hashable {
    let avatarId: String?
    let name: String?
    let charaterOption: CharaterOption?
    let charaterAction: CharaterAction?
    let charaterLocation: CharaterLocation?
    let profileImageName: String?
    let authorId: String?
    let createdDate: Date?
    
    init(
        avatarId: String?,
        name: String? = nil,
        charaterOption: CharaterOption? = nil,
        charaterAction: CharaterAction? = nil,
        charaterLocation: CharaterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        createdDate: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.charaterOption = charaterOption
        self.charaterAction = charaterAction
        self.charaterLocation = charaterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.createdDate = createdDate
    }
    
    var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] = [
        AvatarModel(avatarId: UUID().uuidString, name: "Alpha", charaterOption: .alien, charaterAction: .smilling, charaterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Beta", charaterOption: .dog, charaterAction: .eating, charaterLocation: .forest, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Gamma", charaterOption: .cat, charaterAction: .drinking, charaterLocation: .museum, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Delta", charaterOption: .woman, charaterAction: .shopping, charaterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
    ]
}

struct AvatarDescriptionBuilder {
    let charaterOption: CharaterOption
    let charaterAction: CharaterAction
    let charaterLocation: CharaterLocation
    
    init(charaterOption: CharaterOption, charaterAction: CharaterAction, charaterLocation: CharaterLocation) {
        self.charaterOption = charaterOption
        self.charaterAction = charaterAction
        self.charaterLocation = charaterLocation
    }
    
    init(avatar: AvatarModel) {
        self.charaterOption = avatar.charaterOption ?? .default
        self.charaterAction = avatar.charaterAction ?? .default
        self.charaterLocation = avatar.charaterLocation ?? .default
    }
    
    var characterDescription: String {
        let prefix = charaterOption.startsWithVowel ? "An" : "A"
        return "\(prefix) \(charaterOption.rawValue) that is \(charaterAction.rawValue) in the \(charaterLocation.rawValue)."
    }
}

enum CharaterOption: String, CaseIterable, Hashable {
    case man, woman, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
    
    var startsWithVowel: Bool {
        switch self {
        case .alien:
            return true
        default:
            return false
        
        }
    }
}

enum CharaterAction: String {
    case smilling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying
    
    static var `default`: Self {
        .smilling
    }
}

enum CharaterLocation: String {
    case park, mall, museum, city, desert, forest, space
    
    static var `default`: Self {
        .park
    }
}
