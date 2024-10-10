//
//  EditViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class EditViewModel {
    private let recordRepository: RecordRepositoryInterface
    var record: Record
    
    init(recordRepository: RecordRepositoryInterface, recordID: UUID) {
        self.recordRepository = recordRepository
        self.record = recordRepository.fetchRecords().first(where: { $0.id == recordID })!
    }
    
    func updateRecord(content: String) {
        record.content = content
        do {
            try recordRepository.updateRecord(record)
            NotificationCenter.default.post(name: .recordsDidUpdate, object: nil)
        } catch {
            print("수정 실패")
        }
    }
}
