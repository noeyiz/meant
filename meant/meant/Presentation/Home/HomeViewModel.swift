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
    private var recentlyFetchedRecordIds: [UUID] = []
    private let maxCacheSize = 3
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
        fetchRandomRecord()
    }
    
    func fetchRecords() {
        let fetchedRecords = recordRepository.fetchRecords()
        
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
    
    func fetchRandomRecord() {
        let fetchedRecords = recordRepository.fetchRecords()
        
        // 가져올 수 있는 레코드가 없으면 nil 반환
        if fetchedRecords.isEmpty {
            randomRecord = nil
            return
        }
        
        // 최근에 가져온 레코드를 제외한 레코드들
        let availableRecords = fetchedRecords.filter { !recentlyFetchedRecordIds.contains($0.id) }
        
        // 모든 레코드가 최근에 가져온 것들이라면 전체 레코드에서 선택
        let recordsToChooseFrom = availableRecords.isEmpty ? fetchedRecords : availableRecords
        
        // 랜덤하게 레코드 선택
        let randomIndex = Int.random(in: 0..<recordsToChooseFrom.count)
        let selectedRecord = recordsToChooseFrom[randomIndex]
        
        // 선택된 레코드를 최근 가져온 레코드 목록에 추가
        recentlyFetchedRecordIds.append(selectedRecord.id)
        
        // 최근 가져온 레코드 목록이 최대 크기를 초과하면 가장 오래된 것 제거
        if recentlyFetchedRecordIds.count > maxCacheSize {
            recentlyFetchedRecordIds.removeFirst()
        }
        
        randomRecord = selectedRecord
    }
    
    func deleteRandomRecord() {
        guard let record = randomRecord else { return }
        do {
            try recordRepository.deleteRecord(record)
            fetchRecords()
            fetchRandomRecord()
        } catch {
            print("삭제 실패")
        }
    }
    
    func resetRecords() {
        do {
            try recordRepository.resetRecords()
            fetchRecords()
            fetchRandomRecord()
        } catch {
            print("초기화 실패")
        }
    }
    
    func updateUsername() {
        username = userSettingsRepository.username
    }
}
