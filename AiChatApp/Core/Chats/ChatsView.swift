//
//  ChatsView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 28/01/2026.
//

import SwiftUI

struct ChatsView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(ChatManager.self) private var chatManager
    @Environment(LogManager.self) private var logManager
    
    @State private var chats: [ChatModel] = []
    @State private var isLoadingChats: Bool = true
    @State private var recentAvatars: [AvatarModel] = []
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentSection
                }
                chatSection
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
            .screenAppearAnalytics(name: "ChatsView")
            .onAppear {
                loadRecentAvatars()
            }
            .task {
                await loadChats()
            }
        }
    }
    
    enum Event: LoggableEvent {
        
        case loadAvatarsStart
        case loadAvatarsSuccess(avatarCount: Int)
        case loadAvatarsFail(error: Error)
        case loadChatsStart
        case loadChatsSuccess(chatCount: Int)
        case loadChatsFail(error: Error)
        case chatPressed(chat: ChatModel)
        case avatarPressed(avatar: AvatarModel)

        
        var eventName: String {
            switch self {
            case .loadAvatarsStart: return "ChatsView_LoadAvatars_Start"
            case .loadAvatarsSuccess: return "ChatsView_LoadAvatars_Success"
            case .loadAvatarsFail: return "ChatsView_LoadAvatars_Fail"
            case .loadChatsStart: return "ChatsView_LoadChats_Start"
            case .loadChatsSuccess: return "ChatsView_LoadChats_Success"
            case .loadChatsFail: return "ChatsView_LoadChats_Fail"
            case .chatPressed: return "ChatsView_Chat_Pressed"
            case .avatarPressed: return "ChatsView_Avatar_Pressed"
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .loadAvatarsSuccess(avatarCount: let avatarCount):
                return [
                    "avatarCount": avatarCount
                ]
            case .loadChatsSuccess(chatCount: let chatCount):
                return [
                    "chatCount": chatCount
                ]
            case .loadChatsFail(error: let error), .loadAvatarsFail(error: let error):
                return error.eventParameters
            case .chatPressed(chat: let chat):
                return chat.eventParameters
            case .avatarPressed(avatar: let avatar):
                return avatar.eventParameters
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            case .loadChatsFail, .loadAvatarsFail:
                return .severe
            default :
                return .analytics
            }
        }
    }
    
    private func loadRecentAvatars() {
        logManager.trackEvent(event: Event.loadAvatarsStart)
        do {
            recentAvatars = try avatarManager.getRecentAvatars()
            logManager.trackEvent(event: Event.loadAvatarsSuccess(avatarCount: recentAvatars.count))
        } catch {
            logManager.trackEvent(event: Event.loadAvatarsFail(error: error))
        }
            
    }
    
    private func loadChats() async {
        logManager.trackEvent(event: Event.loadChatsStart)
        do {
            let uid = try authManager.getAuthId()
            chats = try await chatManager.getAllChats(userId: uid)
                .sortedByKeyPath(keyPath: \.modifiedDate, ascending: false)
            logManager.trackEvent(event: Event.loadChatsSuccess(chatCount: chats.count))
        } catch {
            logManager.trackEvent(event: Event.loadChatsFail(error: error))
        }
        
        isLoadingChats = false
    }
    
    private var chatSection: some View {
        Section {
            if isLoadingChats {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .removeListRowFormatting()
            } else if chats.isEmpty {
                Text("Your chats will appear here!")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .removeListRowFormatting()
            } else {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: authManager.auth?.uid,
                        chat: chat) {
                            try? await avatarManager.getAvatar(id: chat.avatarId)
                        } getLastChatMessage: {
                            try? await chatManager.getLastChatMessage(chatId: chat.id)
                        }
                        .anyButton(.highlight) {
                            onChatPressed(chat: chat)
                        }
                        .removeListRowFormatting()
                }
            }
        } header: {
            Text(chats.isEmpty ? "" : "CHATS")
        }
    }
    
    private var recentSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(recentAvatars, id: \.self) { avatar in
                        if let imageName = avatar.profileImageName {
                            VStack(spacing: 8) {
                                ImageLoaderView(urlString: imageName)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(Circle())
                                
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .scrollIndicators(.hidden)
            .removeListRowFormatting()
        } header: {
            Text("RECENTS")
        }
    }
    
    private func onChatPressed(chat: ChatModel) {
        logManager.trackEvent(event: Event.chatPressed(chat: chat))
        path.append(.chat(avatarId: chat.avatarId, chat: chat))
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        logManager.trackEvent(event: Event.avatarPressed(avatar: avatar))
        path.append(.chat(avatarId: avatar.avatarId, chat: nil))
    }
}

#Preview("Has data") {
    ChatsView()
        .previewEnvironment()
}

#Preview("No data") {
    ChatsView()
        .environment(
            AvatarManager(
                service: MockAvatarService(avatars: []),
                local: MockLocalAvatarPersistence(avatars: [])
            )
        )
        .environment(ChatManager(service: MockChatService(chats: [])))
        .previewEnvironment()
}

#Preview("Slow loading chats") {
    ChatsView()
        .environment(ChatManager(service: MockChatService(delay: 5)))
        .previewEnvironment()
}
