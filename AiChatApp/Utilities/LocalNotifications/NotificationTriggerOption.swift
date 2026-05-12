//
//  NotificationTriggerOption.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 12/05/2026.
//

import SwiftUI
import CoreLocation

public enum NotificationTriggerOption {
    case date(date: Date, repeats: Bool)
    case time(timeInterval: TimeInterval, repeats: Bool)

    @available(macCatalyst, unavailable, message: "Location-based notifications are not available on Mac Catalyst.")
    case location(coordinates: CLLocationCoordinate2D, radius: CLLocationDistance, notifyOnEntry: Bool, notifyOnExit: Bool, repeats: Bool)
}
