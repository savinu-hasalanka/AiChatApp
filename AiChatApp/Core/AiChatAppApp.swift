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
            AppView()
                .environment(delegate.dependencies.authManageer)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.aiManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Depedencies!
  
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        dependencies = Depedencies()
        
        return true
  }
}

struct Depedencies {
    let authManageer: AuthManager
    let userManager: UserManager
    let aiManager: AIManager

    init() {
        authManageer = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())
        aiManager = AIManager(service: OpenAIService())
    }
}
