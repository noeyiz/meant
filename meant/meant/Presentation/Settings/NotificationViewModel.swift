//
//  NotificationViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class NotificationViewModel {
    private var userSettingsRepository: UserSettingsRepositoryInterface
    @Published var message: String
    @Published var time: Date
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        message = userSettingsRepository.notificationMessage
        time = userSettingsRepository.notificationTime
    }
    
    func updateMessage(_ message: String) {
        self.message = message
    }
    
    func updateTime(_ time: Date) {
        self.time = time
    }
    
    func saveNotification() {
        userSettingsRepository.notificationEnabled = true
        userSettingsRepository.notificationMessage = message
        userSettingsRepository.notificationTime = time
        UserNotificationManager.shared.scheduleNotification(for: time, message: message)
    }
}
