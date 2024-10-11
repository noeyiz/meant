//
//  ReminiscenceViewModel.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import Foundation

final class ReminiscenceViewModel {
    private let recordRepository: RecordRepositoryInterface
    @Published var record: Record
    
    init(recordRepository: RecordRepositoryInterface, recordID: UUID) {
        self.recordRepository = recordRepository
        self.record = recordRepository.fetchRecords().first(where: { $0.id == recordID })!
    }
    
    func saveReminiscence(content: String) {
        let newReminiscence = Reminiscence(id: UUID(), date: Date(), content: content)
        do {
            try recordRepository.saveReminiscence(for: record.id, newReminiscence)
            NotificationCenter.default.post(name: .recordsDidUpdate, object: nil)
        } catch {
            print("저장 실패")
        }
    }
}
