//
//  UserSettingsRepositoryInterface.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

protocol UserSettingsRepositoryInterface {
    var onboardingCompleted: Bool { get set }
    var username: String { get set }
    var notificationEnabled: Bool { get set }
    var notificationTime: Date { get set }
    var notificationMessage: String { get set }
    var lastAccessDate: Date { get set }
    var cachedRecordId: UUID? { get set }
    var cachedRecordIds: Set<UUID> { get set }
}
