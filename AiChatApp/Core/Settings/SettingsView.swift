//
//  SettingsView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Sign Out")
                }
            }
            .navigationTitle("Settins")
        }
    }
    
    private func onSignOutPressed() {
        // sign out logic goes here
        dismiss()
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
