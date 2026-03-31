//
//  Dictionary+EXT.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 31/03/2026.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    var asAlphabeticalArray: [(key: String, value: Any)] {
        self.map( {(key: $0, value: $1)} ).sortedByKeyPath(keyPath: \.key)
    }
}
