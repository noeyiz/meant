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
    
    private init() {}
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(recordRepository: recordRepository)
    }
    
    func makeRecordViewModel() -> RecordViewModel {
        return RecordViewModel(recordRepository: recordRepository)
    }
    
    func makeRecordDetailViewModel(for id: UUID) -> RecordDetailViewModel {
        return RecordDetailViewModel(recordRepository: recordRepository, recordID: id)
    }
}
