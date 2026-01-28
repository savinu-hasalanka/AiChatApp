//
//  AppView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 27/01/2026.
//

import SwiftUI

struct AppView: View {
    
//    @AppStorage("showTabBarView") var showTabBar: Bool = false
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
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
