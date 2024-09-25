//
//  RecordViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class RecordViewModel {
    private let recordRepository: RecordRepositoryInterface
    
    init(recordRepository: RecordRepositoryInterface) {
        self.recordRepository = recordRepository
    }
    
    func saveRecord(content: String, recordType: RecordType) {
        let newRecord = Record(
            id: UUID(),
            date: Date(),
            type: recordType.rawValue,
            content: content
        )
        do {
            try recordRepository.saveRecord(newRecord)
        } catch {
            print("저장 실패")
        }
    }
}
