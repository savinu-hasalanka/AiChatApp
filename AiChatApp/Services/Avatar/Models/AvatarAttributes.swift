//
//  AvatarAttributes.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 08/02/2026.
//

enum CharacterOption: String, CaseIterable, Hashable {
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

enum CharacterAction: String, CaseIterable, Hashable {
    case smilling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying
    
    static var `default`: Self {
        .smilling
    }
}

enum CharacterLocation: String, CaseIterable, Hashable {
    case park, mall, museum, city, desert, forest, space
    
    static var `default`: Self {
        .park
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    init(charaterOption: CharacterOption, charaterAction: CharacterAction, charaterLocation: CharacterLocation) {
        self.characterOption = charaterOption
        self.characterAction = charaterAction
        self.characterLocation = charaterLocation
    }
    
    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
    
    var characterDescription: String {
        let prefix = characterOption.startsWithVowel ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)."
    }
}
