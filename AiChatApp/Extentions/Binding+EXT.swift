//
//  Binding+EXT.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 17/02/2026.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
