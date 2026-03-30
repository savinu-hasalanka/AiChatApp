//
//  ProfileModalView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 17/02/2026.
//

import SwiftUI

struct ProfileModalView: View {
    
    var imageName: String? = Constants.randomImage
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "An alien in the park."
    var onXMarkPressed: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                VStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.black)
                    .padding(4)
                    .tappableBackground()
                    .anyButton {
                        onXMarkPressed()
                    }
                    .padding(8)
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.red.ignoresSafeArea()
        
        ProfileModalView()
            .padding(40)
    }
}
