//
//  CategoryListView.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 17/02/2026.
//

import SwiftUI

struct CategoryListView: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(LogManager.self) private var logManager
    
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImage
    
    @Binding var path: [NavigationPathOption]
    @State private var avatars: [AvatarModel] = []
    @State private var isLoading: Bool = true
    
    @State private var showAlert: AnyAppAlert?
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            if isLoading {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
            } else if avatars.isEmpty {
                Text("No avatars found 😭")
                    .frame(maxWidth: .infinity)
                    .padding(40)
                    .foregroundStyle(.secondary)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
            } else {
                ForEach(avatars, id: \.self) { avatar in
                    CustomListCellView(
                        title: avatar.name ?? "",
                        subtitle: avatar.characterDescription,
                        imageName: avatar.profileImageName ?? ""
                    )
                    .anyButton(.highlight, action: {
                        onAvatarPressed(avatar: avatar)
                    })
                    .removeListRowFormatting()
                }
            }
        }
        .showCustomAlert(alert: $showAlert)
        .screenAppearAnalytics(name: "CategoryListView")
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
        .task {
            await loadAvatars(category: category)
        }
    }
    
    enum Event: LoggableEvent {
        
        case loadAvatarsStart
        case loadAvatarsSuccess
        case loadAvatarsFail(error: Error)
        case avatarPressed(avatar: AvatarModel)
        
        var eventName: String {
            switch self {
            case .loadAvatarsStart: return "CategoryList_LoadAvatars_Start"
            case .loadAvatarsSuccess: return "CategoryList_LoadAvatars_Success"
            case .loadAvatarsFail: return "CategoryList_LoadAvatars_Fail"
            case .avatarPressed: return "CategoryList_Avatar_Pressed"
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .loadAvatarsFail(error: let error):
                return error.eventParameters
            case .avatarPressed(avatar: let avatar):
                return avatar.eventParameters
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            case .loadAvatarsFail:
                return .severe
            default :
                return .analytics
            }
        }
    }
    
    private func loadAvatars(category: CharacterOption) async {
        logManager.trackEvent(event: Event.loadAvatarsStart)
        do {
            avatars = try await avatarManager.getAvatarsForCategory(category: category)
            logManager.trackEvent(event: Event.loadAvatarsSuccess)
        } catch {
            showAlert = AnyAppAlert(error: error)
            logManager.trackEvent(event: Event.loadAvatarsFail(error: error))
        }
        
        isLoading = false
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId, chat: nil))
        logManager.trackEvent(event: Event.avatarPressed(avatar: avatar))
    }
}

#Preview("Has data") {
    CategoryListView(path: .constant([]))
        .environment(AvatarManager(service: MockAvatarService()))
}

#Preview("No data") {
    CategoryListView(path: .constant([]))
        .environment(AvatarManager(service: MockAvatarService(avatars: [])))
}

#Preview("Slow loading") {
    CategoryListView(path: .constant([]))
        .environment(AvatarManager(service: MockAvatarService(delay: 5.0)))
}

#Preview("Error loading") {
    CategoryListView(path: .constant([]))
        .environment(AvatarManager(service: MockAvatarService(delay: 5.0, showError: true)))
}
