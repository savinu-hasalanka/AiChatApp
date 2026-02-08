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
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let createdDate: Date?
    
    init(
        avatarId: String?,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        createdDate: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
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
        AvatarModel(avatarId: UUID().uuidString, name: "Alpha", characterOption: .alien, characterAction: .smilling, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Beta", characterOption: .dog, characterAction: .eating, characterLocation: .forest, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Gamma", characterOption: .cat, characterAction: .drinking, characterLocation: .museum, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
        AvatarModel(avatarId: UUID().uuidString, name: "Delta", characterOption: .woman, characterAction: .shopping, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, createdDate: .now),
    ]
}
