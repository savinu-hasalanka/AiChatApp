//
//  FirebaseUserService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/03/2026.
//

import FirebaseFirestore
import FirebaseFirestoreInternal
import SwiftfulFirestore

typealias ListenerRegistration = FirebaseFirestore.ListenerRegistration

struct FirebaseUserService: RemoteUserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.userID).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
            
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}
