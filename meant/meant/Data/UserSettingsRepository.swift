//
//  UserSettingsRepository.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class UserSettingsRepository: UserSettingsRepositoryInterface {
    @UserDefaultsData(key: "username", defaultValue: "")
    var username: String
    
    @UserDefaultsData(key: "notificationEnabled", defaultValue: false)
    var notificationEnabled: Bool
    
    @UserDefaultsData(key: "notificatinTime", defaultValue: Date())
    var notificatinTime: Date
}
