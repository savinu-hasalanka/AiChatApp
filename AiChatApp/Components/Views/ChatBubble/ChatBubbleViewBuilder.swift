//
//  ChatBubbleViewBuilder.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 08/02/2026.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
    
    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    
    var body: some View {
        ChatBubbleView(
            text: message.content ?? "",
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
            imageName: imageName,
            showImage: !isCurrentUser
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 75 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 75)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(isCurrentUser: true)
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorID: UUID().uuidString,
                    content: "This is some long content that goes on to multiple lines. This is some long content that goes on to multiple lines.",
                    seenByIds: nil,
                    dateCreated: .now
                )
            )
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorID: UUID().uuidString,
                    content: "This is some long content that goes on to multiple lines. This is some long content that goes on to multiple lines.",
                    seenByIds: nil,
                    dateCreated: .now
                ),
                isCurrentUser: true
            )
        }
        .padding(12)
    }
}
