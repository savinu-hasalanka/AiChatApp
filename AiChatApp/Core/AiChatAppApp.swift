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
                .environment(delegate.authManageer)
                .environment(delegate.userManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var authManageer: AuthManager!
    var userManager: UserManager!
  
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        authManageer = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())
        
        return true
  }
}
