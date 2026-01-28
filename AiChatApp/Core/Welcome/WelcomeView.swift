//
//  WelcomeView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            Text("Welcome!")
                .frame(maxHeight: .infinity)
            
            NavigationLink {
                OnboardingCompletedView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }

        }
        .padding(16)
    }
}

#Preview {
    WelcomeView()
}
