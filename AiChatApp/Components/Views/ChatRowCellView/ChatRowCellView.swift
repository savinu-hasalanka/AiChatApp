//
//  ChatRowCellView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 03/02/2026.
//

import SwiftUI

struct ChatRowCellView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var imageName: String? = Constants.randomImage
    var headLine: String? = "Alpha"
    var subheadline: String? = "This is your last message in the chat"
    var hasNewChat: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 4) {
                if let headLine {
                    Text(headLine)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }
                if let subheadline {
                    Text(subheadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(1)
                }
                
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewChat {
                Text("NEW")
                    .badgeButton()
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .frame(maxWidth: 50)
            }
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(colorScheme.backgroundPrimary)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        List {
            ChatRowCellView()
                .removeListRowFormatting()
            ChatRowCellView(hasNewChat: false)
                .removeListRowFormatting()
            ChatRowCellView(imageName: nil)
                .removeListRowFormatting()
            ChatRowCellView(headLine: nil, hasNewChat: false)
                .removeListRowFormatting()
            ChatRowCellView(subheadline: nil)
                .removeListRowFormatting()
        }
    }
}
