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
    @Published var notificationEnabled: Bool
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        notificationEnabled = userSettingsRepository.notificationEnabled
    }
    
    func setNotificationStatus(isOn: Bool) {
        notificationEnabled = isOn
    }
}
