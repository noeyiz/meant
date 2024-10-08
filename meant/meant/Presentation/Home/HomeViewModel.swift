//
//  HomeViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import Foundation

final class HomeViewModel {
    private let recordRepository: RecordRepositoryInterface
    private let userSettingsRepository: UserSettingsRepositoryInterface
    @Published var username = ""
    @Published var records = [RecordSectionViewModel]()
    @Published var randomRecord: Record?
    
    init(
        recordRepository: RecordRepositoryInterface,
        userSettingsRepository: UserSettingsRepositoryInterface
    ) {
        self.recordRepository = recordRepository
        self.userSettingsRepository = userSettingsRepository
        updateUsername()
        fetchRecords()
    }
    
    func fetchRecords() {
        let fetchedRecords = recordRepository.fetchRecords()
        
        if !fetchedRecords.isEmpty {
            randomRecord = fetchedRecords[0]
        }
        
        // 날짜별로 내림차순 정렬
        let sortedRecords = fetchedRecords.sorted { $0.date > $1.date }
        
        // 같은 월끼리 묶어서 그룹화
        let groupedRecords = Dictionary(grouping: sortedRecords) { record in
            return record.date.formatAsMonthYear()
        }
        
        // RecordSectionViewModel로 변환
        let sectionedRecords = groupedRecords.map { (month, records) in
            let cellViewModels = records.map { record in
                RecordCellViewModel(
                    id: record.id,
                    date: record.date.formatAsDayWeekday(),
                    content: record.content,
                    backgroundColor: RecordType(rawValue: record.type)!.color01
                )
            }
            return RecordSectionViewModel(month: month, cellViewModels: cellViewModels)
        }
        
        // 월별로 정렬 (내림차순)
        self.records = sectionedRecords.sorted { $0.month < $1.month }
    }
    
    func resetRecords() {
        do {
            try recordRepository.resetRecords()
            fetchRecords()
        } catch {
            print("초기화 실패")
        }
    }
    
    func updateUsername() {
        username = userSettingsRepository.username
    }
}
