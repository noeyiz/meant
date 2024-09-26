//
//  NameViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class NameViewModel {
    private var userSettingsRepository: UserSettingsRepositoryInterface
    var username: String
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        username = userSettingsRepository.username
    }
    
    func saveName(name: String) {
        userSettingsRepository.username = name
        NotificationCenter.default.post(name: .usernameDidUpdate, object: nil)
    }
}
