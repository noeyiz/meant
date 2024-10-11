//
//  DIContainer.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private let recordRepository = RecordRepository()
    private let userSettingsRepository = UserSettingsRepository()
    
    private init() {}
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            recordRepository: recordRepository,
            userSettingsRepository: userSettingsRepository
        )
    }
    
    func makeRecordViewModel() -> RecordViewModel {
        return RecordViewModel(recordRepository: recordRepository)
    }
    
    func makeRecordDetailViewModel(recordID: UUID) -> RecordDetailViewModel {
        return RecordDetailViewModel(recordRepository: recordRepository, recordID: recordID)
    }
    
    func makeReminiscenceViewModel(recordID: UUID) -> ReminiscenceViewModel {
        return ReminiscenceViewModel(recordRepository: recordRepository, recordID: recordID)
    }
    
    func makeEditViewModel(for id: UUID) -> EditViewModel {
        return EditViewModel(recordRepository: recordRepository, recordID: id)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(userSettingsRepository: userSettingsRepository)
    }
    
    func makeNameViewModel() -> NameViewModel {
        return NameViewModel(userSettingsRepository: userSettingsRepository)
    }
    
    func makeNotificationViewModel() -> NotificationViewModel {
        return NotificationViewModel(userSettingsRepository: userSettingsRepository)
    }
}
