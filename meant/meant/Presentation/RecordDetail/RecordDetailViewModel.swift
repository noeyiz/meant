//
//  RecordDetailViewModel.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import Foundation

final class RecordDetailViewModel {
    private let recordRepository: RecordRepositoryInterface
    @Published var record: Record
    
    init(recordRepository: RecordRepositoryInterface, recordID: UUID) {
        self.recordRepository = recordRepository
        self.record = recordRepository.fetchRecords().first(where: { $0.id == recordID })!
    }
    
    func updateRecord() {
        record = recordRepository.fetchRecords().first(where: { $0.id == record.id })!
    }
    
    func deleteRecord() {
        do {
            try recordRepository.deleteRecord(record)
            NotificationCenter.default.post(name: .recordsDidUpdate, object: nil)
        } catch {
            print("삭제 실패")
        }
    }
    
    func deleteReminiscence(for index: Int) {
        let reminiscence = record.reminiscences[index]
        do {
            try recordRepository.deleteReminiscence(for: record.id, reminiscenceID: reminiscence.id)
            updateRecord()
        } catch {
            print("삭제 실패")
        }
    }
}
