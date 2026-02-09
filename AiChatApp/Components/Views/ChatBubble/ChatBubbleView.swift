//
//  ChatBubbleView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 08/02/2026.
//

import SwiftUI

struct ChatBubbleView: View {
    
    var text: String = "This is a sample text"
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var imageName: String?
    var showImage: Bool = true
    
    private let offset: CGFloat = 14
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .offset(y: offset)
            }
            
            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(6)
        }
        .padding(.bottom, showImage ? offset : 0)
        
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleView()
            ChatBubbleView(text: "This is a chat bubble with a lot of text that wraps to multiple lines and it keeps going. This is a chat bubble with a lot of text that wraps to multiple lines and it keeps going.")
            
            ChatBubbleView(
                textColor: .white,
                backgroundColor: .accent,
                imageName: nil,
                showImage: false
            )
            
            ChatBubbleView(
                text: "This is a chat bubble with a lot of text that wraps to multiple lines and it keeps going. This is a chat bubble with a lot of text that wraps to multiple lines and it keeps going.",
                textColor: .white,
                backgroundColor: .accent,
                imageName: nil,
                showImage: false
            )
        }
        .padding()
    }
}
