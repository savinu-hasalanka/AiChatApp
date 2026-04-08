//
//  AvatarAttributes.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 08/02/2026.
//

enum CharacterOption: String, CaseIterable, Hashable, Codable {
    case man, woman, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
    
    var plural: String {
        switch self {
        case .man:
            "men"
        case .woman:
            "women"
        case .alien:
            "aliens"
        case .dog:
            "dogs"
        case .cat:
            "cats"
        }
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

enum CharacterAction: String, CaseIterable, Hashable, Codable {
    case smilling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying
    
    static var `default`: Self {
        .smilling
    }
}

enum CharacterLocation: String, CaseIterable, Hashable, Codable {
    case park, mall, museum, city, desert, forest, space
    
    static var `default`: Self {
        .park
    }
}

struct AvatarDescriptionBuilder: Codable {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
    
    enum CodingKeys: String, CodingKey {
        case characterOption = "character_option"
        case characterAction = "character_action"
        case characterLocation = "character_location"
    }
    
    var characterDescription: String {
        let prefix = characterOption.startsWithVowel ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)."
    }
    
    var eventParameters: [String: Any] {
        [
            CodingKeys.characterOption.rawValue: characterOption,
            CodingKeys.characterAction.rawValue: characterAction,
            CodingKeys.characterLocation.rawValue: characterLocation,
            "characterDescription": characterDescription
        ]
    }
}
