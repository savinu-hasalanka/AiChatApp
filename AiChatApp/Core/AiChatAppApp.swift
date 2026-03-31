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
                .environment(delegate.dependencies.chatManager)
                .environment(delegate.dependencies.aiManager)
                .environment(delegate.dependencies.avatarManager)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.authManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
  
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        #if MOCK
        dependencies = Dependencies(config: .mock(isSignedIn: true))
        #elseif DEV
        dependencies = Dependencies(config: .dev)
        #else
        dependencies = Dependencies(config: .prod)
        #endif
        
        return true
  }
}

enum BuildConfiguration {
    case mock(isSignedIn: Bool), dev, prod
}

struct Dependencies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AIManager
    let avatarManager: AvatarManager
    let chatManager: ChatManager
    
    // Mock - mock dependencies
    // Development - production dependencies + some extra dev tools
    // Production - production dependencies
    
    init(config: BuildConfiguration) {
        switch config {
        case .mock(let isSignedIn):
            authManager = AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil))
            userManager = UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil))
            aiManager = AIManager(service: MockAIService())
            avatarManager = AvatarManager(service: MockAvatarService(), local: MockLocalAvatarPersistence())
            chatManager = ChatManager(service: MockChatService())
        case .dev:
            authManager = AuthManager(service: MockAuthService())
            userManager = UserManager(services: MockUserServices())
            aiManager = AIManager(service: MockAIService())
            avatarManager = AvatarManager(service: MockAvatarService(), local: MockLocalAvatarPersistence())
            chatManager = ChatManager(service: MockChatService())
        case .prod:
            authManager = AuthManager(service: FirebaseAuthService())
            userManager = UserManager(services: ProductionUserServices())
            aiManager = AIManager(service: OpenAIService())
            avatarManager = AvatarManager(service: FirebaseAvatarService(), local: SwiftDataLocalAvatarPersistence())
            chatManager = ChatManager(service: FirebaseChatService())
        }
    }
}

extension View {
    func previewEnvironment(isSignedIn: Bool = true) -> some View {
        self
            .environment(ChatManager(service: MockChatService()))
            .environment(AIManager(service: MockAIService()))
            .environment(AvatarManager(service: MockAvatarService()))
            .environment(UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil)))
            .environment(AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil)))
            .environment(AppState())
    }
}
