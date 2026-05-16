//
//  ABTestService.swift
//  AiChatApp
//
//  Created by Savinu Hasalanka on 16/05/2026.
//

@MainActor
protocol ABTestService: Sendable {
    var activeTests: ActiveABTests { get }
    func saveUpdatedConfig(updatedTests: ActiveABTests) throws
    func fetchUpdatedConfig() async throws -> ActiveABTests
}
