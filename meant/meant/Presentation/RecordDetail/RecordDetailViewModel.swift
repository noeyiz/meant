//
//  RecordDetailViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

final class RecordDetailViewModel {
    enum RecordDetailMode {
        case editing
        case viewing
    }
    
    private let recordRepository: RecordRepositoryInterface
    private var record: Record
    @Published var mode: RecordDetailMode = .viewing
    
    init(recordRepository: RecordRepositoryInterface, recordID: UUID) {
        self.recordRepository = recordRepository
        self.record = recordRepository.fetchRecords().first(where: { $0.id == recordID })!
    }
    
    func getContent() -> String {
        return record.content
    }
    
    func toggleMode() {
        mode = mode == .editing ? .viewing : .editing
    }
    
    func updateRecord(content: String) {
        record.content = content
        do {
            try recordRepository.updateRecord(record)
        } catch {
            print("수정 실패")
        }
    }
    
    func deleteRecord() {
        do {
            try recordRepository.deleteRecord(record)
        } catch {
            print("삭제 실패")
        }
    }
}
