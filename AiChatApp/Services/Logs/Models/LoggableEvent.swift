//
//  LoggableEvent.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 01/04/2026.
//


protocol LoggableEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var type: LogType { get }
}

struct AnyLoggableEvent: LoggableEvent {
    let eventName: String
    let parameters: [String : Any]?
    let type: LogType
    
    init(eventName: String, parameters: [String : Any]? = nil, type: LogType = .analytics) {
        self.eventName = eventName
        self.parameters = parameters
        self.type = type
    }
}
