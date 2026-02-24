//
//  AiChatAppApp.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 27/01/2026.
//

import SwiftUI
import Firebase

@main
struct AiChatAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            EnvironmentBuilder {
                AppView()
            }
        }
    }
}

struct EnvironmentBuilder<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .environment(AuthManager(service: FirebaseAuthService()))
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
