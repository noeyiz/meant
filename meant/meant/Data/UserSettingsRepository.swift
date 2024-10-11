//
//  UserSettingsRepository.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class UserSettingsRepository: UserSettingsRepositoryInterface {
    @UserDefaultsData(key: "onboardingCompleted", defaultValue: false)
    var onboardingCompleted: Bool
    
    @UserDefaultsData(key: "username", defaultValue: "지연")
    var username: String
    
    @UserDefaultsData(key: "notificationEnabled", defaultValue: false)
    var notificationEnabled: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: Date().date(from: "21:00"))
    var notificationTime: Date
    
    @UserDefaultsData(key: "notificationMessage", defaultValue: "하루의 의미를 찾을 시간이에요. 🍃")
    var notificationMessage: String
    
    @UserDefaultsData(key: "lastAccessDate", defaultValue: Date())
    var lastAccessDate: Date
    
    @UserDefaultsData(key: "cachedRecordId", defaultValue: nil)
    var cachedRecordId: UUID?
    
    @UserDefaultsData(key: "cachedRecordIds", defaultValue: [])
    var cachedRecordIds: Set<UUID>
}
