//
//  AppView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 27/01/2026.
//

import SwiftUI

struct AppView: View {
    
    @AppStorage("showTabBarView") var showTabBar: Bool = false
    
    var body: some View {
        
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("TabBar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
    }
}

#Preview("AppView - Tabbar") {
    AppView(showTabBar: true)
}

#Preview("AppView - Onboarding") {
    AppView(showTabBar: false)
}
