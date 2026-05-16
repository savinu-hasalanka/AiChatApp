//
//  MockABTestService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/05/2026.
//
import SwiftUI

@MainActor
class MockABTestService: ABTestService {
    
    var activeTests: ActiveABTests

    init(
        createAccountTest: Bool? = nil,
        onboardingCommunityTest: Bool? = nil,
        categoryRowTest: CategoryRowTestOption? = nil
    ) {
        self.activeTests = ActiveABTests(
            createAccountTest: createAccountTest ?? false,
            onboardingCommunityTest: onboardingCommunityTest ?? false,
            categoryRowTest: categoryRowTest ?? .default
        )
    }
    
    func saveUpdatedConfig(updatedTests: ActiveABTests) throws {
        activeTests = updatedTests
    }
    
    func fetchUpdatedConfig() async throws -> ActiveABTests {
        activeTests
    }
}

