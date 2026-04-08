//
//  WelcomeView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(AppState.self) private var root
    @Environment(LogManager.self) private var logManager

    @State private var imageName: String = Constants.randomImage
    @State private var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()
                
                titleSection
                    .padding(.top, 24)
                
                ctaButtons
                    .padding(16)
                
                policyLinks
            }
        }
        .screenAppearAnalytics(name: "WelcomeView")
        .sheet(isPresented: $showSignInView) {
            CreateAccountView(
                title: "Sign In",
                subtitle: "Connect to an existing account.",
                onDidSignIn: { isNewUser in
                    handleDidSignIn(isNewUser: isNewUser)
                }
            )
            .presentationDetents([.medium])
        }
    }
    
    enum Event: LoggableEvent {
        case didSignIn(isNewUser: Bool)
        case signInPressed
        
        var eventName: String {
            switch self {
            case .didSignIn: return "WelcomeView_DidSignIn"
            case .signInPressed: return "WelcomeView_SignIn_Pressed"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .didSignIn(isNewUser: let isNewUser):
                return [
                    "is_new_user": isNewUser
                ]
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            default:
                return .analytics
            }
        }
    }
    
    private func handleDidSignIn(isNewUser: Bool) {
        logManager.trackEvent(event: Event.didSignIn(isNewUser: isNewUser))

        if isNewUser {
            // Do nothing, user goes through onboarding
        } else {
            // Push into TabBar view
            root.updateViewState(showTabBarView: true)
        }
    }
    
    private func onSignInPressed() {
        showSignInView = true
        logManager.trackEvent(event: Event.signInPressed)
    }
    
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("AI Chat ✌️")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("LinkedIn @savinu-hasalanka")
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            Text("Already have an account? Sign in.")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    onSignInPressed()
                }
        }
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceUrl)!) {
                Text("Terms of Service")
            }
            Circle()
                .fill()
                .frame(width: 4, height: 4)
            Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Policy")
            }
            
        }
    }
}

#Preview {
    WelcomeView()
}
