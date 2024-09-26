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
    @Published var lockEnabled: Bool
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        notificationEnabled = userSettingsRepository.notificationEnabled
        lockEnabled = userSettingsRepository.lockEnabled
    }
    
    func setNotificationStatus(isOn: Bool) {
        notificationEnabled = isOn
    }
    
    func setLockStatus(isOn: Bool) {
        lockEnabled = isOn
    }
}
