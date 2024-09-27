//
//  SettingsViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import Foundation

final class SettingsViewModel {
    private var userSettingsRepository: UserSettingsRepositoryInterface
    @Published var settings = [SettingsCellViewModel]()
    @Published var showNotificationSettings: Bool = false
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        fetchSettings()
    }
    
    func fetchSettings() {
        settings = [
            SettingsCellViewModel(type: .name),
            SettingsCellViewModel(
                type: .notification,
                isOn: userSettingsRepository.notificationEnabled
            ),
            SettingsCellViewModel(type: .reset),
            SettingsCellViewModel(type: .instragram),
        ]
    }
    
    func setNotificationStatus(isOn: Bool) {
        if isOn {
            showNotificationSettings = true
        } else {
            userSettingsRepository.notificationEnabled = false
            UserNotificationManager.shared.disableNotification()
            fetchSettings()
        }
    }
}
