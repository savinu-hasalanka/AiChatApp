//
//  ProfileView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showSettingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }
    
    private var settingsButton: some View {
        Button {
            onSettingsButtonPressed()
        } label: {
            Image(systemName: "gear")
                .font(.headline)
                .foregroundStyle(.tint)
        }
    }
    
    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
}

#Preview {
    ProfileView()
}
