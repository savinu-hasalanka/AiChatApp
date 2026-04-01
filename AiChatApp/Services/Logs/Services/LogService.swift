//
//  LogService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 01/04/2026.
//

import SwiftUI

protocol LogService {
    
    func identifyUser(userId: String, name: String?, email: String?)
    func addUserProperties(dict: [String: Any], isHighPriority: Bool)
    func deleteUserProfile()
    
    func trackEvent(event: LoggableEvent)
    func trackScreenEvent(event: LoggableEvent)
}
