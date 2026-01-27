//
//  AppViewBuilder.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 27/01/2026.
//

import SwiftUI

struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    
    var showTabBar: Bool = false
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboardingView: OnboardingView
    
    var body: some View {
        ZStack {
            if showTabBar {
                tabbarView
                    .transition(.move(edge: .leading))
            } else {
                onboardingView
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.smooth, value: showTabBar)
    }

}

fileprivate struct PreviewView: View {
    
    @State var showTabBar: Bool = false
    
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
        .onTapGesture {
            showTabBar.toggle()
        }
    }
}

#Preview {
    PreviewView()
}
