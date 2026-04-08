//
//  AppView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 27/01/2026.
//

import SwiftUI

struct AppView: View {
    
//    @AppStorage("showTabBarView") var showTabBar: Bool = false
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(LogManager.self) private var logManager
    
    @State var appState: AppState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    enum Event: LoggableEvent {
        
        case existingAuthStart
        case existingAuthFail(error: Error)
        case anonAuthStart
        case anonAuthSuccess
        case anonAuthFail(error: Error)
        
        var eventName: String {
            switch self {
            case .existingAuthStart: return "AppView_ExistingAuth_Start"
            case .existingAuthFail: return "AppView_Existing_Fail"
            case .anonAuthStart: return "AppView_AnonAuth_Start"
            case .anonAuthSuccess: return "AppView_Anon_Success"
            case .anonAuthFail: return "AppView_Anon_Fail"
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .existingAuthFail(error: let error), .anonAuthFail(error: let error):
                return error.eventParameters
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            case .existingAuthFail, .anonAuthFail:
                return .severe
            default :
                return .analytics
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authManager.auth {
            // user is authenticated
            logManager.trackEvent(event: Event.existingAuthStart)
            
            do {
                try await userManager.logIn(auth: user, isNewUser: false)
            } catch {
                logManager.trackEvent(event: Event.existingAuthFail(error: error))
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
            
        } else {
            // user is not authenticated
            logManager.trackEvent(event: Event.anonAuthStart)
            do {
                let result = try await authManager.signInAnonymously()
                
                // log in to app
                logManager.trackEvent(event: Event.anonAuthSuccess)
                
                // log in
                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)
            } catch {
                logManager.trackEvent(event: Event.anonAuthFail(error: error))
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        }
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(UserManager(services: MockUserServices(user: .mock)))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(services: MockUserServices(user: nil)))

}
