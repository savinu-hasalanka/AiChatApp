//
//  ImageLoaderView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: contentMode)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 200, height: 200)
        .anyButton(.highlight) {
            
        }
}
