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
    @Published var showSettingsApp: Bool = false
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        fetchSettings()
    }
    
    func fetchSettings() {
        settings = [
            SettingsCellViewModel(type: .name),
            SettingsCellViewModel(type: .notification, isOn: userSettingsRepository.notificationEnabled),
            SettingsCellViewModel(type: .instragram),
        ]
    }
    
    func setNotificationStatus(isOn: Bool) {
        if isOn {
            UserNotificationManager.shared.checkNotificationAuthorization { [weak self] isAuthorized in
                guard let self = self else { return }
                if isAuthorized {
                    showNotificationSettings = true
                } else {
                    showSettingsApp = true
                }
            }
        } else {
            userSettingsRepository.notificationEnabled = false
            UserNotificationManager.shared.disableNotification()
            fetchSettings()
        }
    }
}
