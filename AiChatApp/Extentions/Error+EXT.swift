//
//  Error+EXT.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 05/04/2026.
//

import Foundation

extension Error {
    
    var eventParameters: [String: Any] {
        [
            "error_description": localizedDescription
        ]
    }
    
}
