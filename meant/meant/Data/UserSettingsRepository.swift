//
//  UserSettingsRepository.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class UserSettingsRepository: UserSettingsRepositoryInterface {
    @UserDefaultsData(key: "username", defaultValue: "지연")
    var username: String
    
    @UserDefaultsData(key: "notificationEnabled", defaultValue: false)
    var notificationEnabled: Bool
    
    @UserDefaultsData(key: "notificationTime", defaultValue: Date().date(from: "21:00"))
    var notificationTime: Date
    
    @UserDefaultsData(key: "notificationMessage", defaultValue: "하루를 마무리할 시간이에요. 🍃")
    var notificationMessage: String
}
